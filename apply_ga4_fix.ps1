$root = Get-Location
$gaSnippet = @'
<script async src="https://www.googletagmanager.com/gtag/js?id=G-BGQMNF8C0G"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-BGQMNF8C0G');
</script>
'@
$trackingHelper = @'
<script>
(function() {
  if (window.SaveraGa4AnalyticsInstalled) return;
  window.SaveraGa4AnalyticsInstalled = true;
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  function saveraTrackEvent(eventName, params) {
    if (typeof gtag === 'function') {
      gtag('event', eventName, params);
    } else if (window.dataLayer && typeof window.dataLayer.push === 'function') {
      window.dataLayer.push(Object.assign({event: eventName}, params));
    }
  }
  function attachLinkTracking(link, eventName, params) {
    if (link.dataset.saveraGa4Attached === 'true') return;
    link.addEventListener('click', function() {
      saveraTrackEvent(eventName, params);
    });
    link.dataset.saveraGa4Attached = 'true';
  }
  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('a[href^="tel:"]').forEach(function(link) {
      var href = link.getAttribute('href');
      if (href) {
        attachLinkTracking(link, 'phone_call_click', {
          event_category: 'engagement',
          event_label: href.replace(/^tel:/i, '')
        });
      }
    });
    document.querySelectorAll('a[href*="wa.me"], a[href*="api.whatsapp.com"]').forEach(function(link) {
      attachLinkTracking(link, 'whatsapp_click', {
        event_category: 'engagement',
        event_label: 'WhatsApp'
      });
    });
  });
})();
</script>
'@
$bookingEvent = @'
          if (typeof gtag === 'function') {
            gtag('event', 'booking_submit', {
              event_category: 'conversion',
              event_label: 'booking_form'
            });
          } else if (window.dataLayer && typeof window.dataLayer.push === 'function') {
            window.dataLayer.push({
              event: 'booking_submit',
              event_category: 'conversion',
              event_label: 'booking_form'
            });
          }
'@
$modifiedFiles = @()
$report = @()
$files = Get-ChildItem -Recurse -Filter *.html | Where-Object { $_.FullName -notmatch '\\employes\\' }
foreach ($file in $files) {
    $text = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $orig = $text
    $changed = $false
    $hasGa4 = $text -match 'G-BGQMNF8C0G'
    if (-not $hasGa4) {
        if ($text -match '</head\s*>') {
            $text = [regex]::Replace($text, '</head\s*>', "$gaSnippet`r`n</head>", 1, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            $changed = $true
            $report += "Added GA4 snippet to $($file.FullName)"
        }
    }
    $hasHelper = $text -match 'SaveraGa4AnalyticsInstalled|saveraTrackEvent|phone_call_click|whatsapp_click'
    if (-not $hasHelper) {
        if ($text -match '</body\s*>') {
            $text = [regex]::Replace($text, '</body\s*>', "$trackingHelper`r`n</body>", 1, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            $changed = $true
            $report += "Added GA4 click tracking helper to $($file.FullName)"
        }
    }
    if ($text -match 'id\s*=\s*"bookingForm"|id\s*=\s*''bookingForm''') {
        $hasBookingSubmit = $text -match 'gtag\(\s*''event''\s*,\s*''booking_submit''|dataLayer\.push\(\s*\{[^}]*event\s*:\s*''booking_submit'''
        if (-not $hasBookingSubmit) {
            $submitPattern = [regex] 'fetch\([^\)]*\)[\s\S]*?\.then\s*\(\s*\(.*?\)\s*=>\s*\{'
            $match = $submitPattern.Match($text)
            if ($match.Success) {
                $thenStart = $match.Index + $match.Length
                $resetIndex = $text.IndexOf('this.reset();', $thenStart, [System.StringComparison]::Ordinal)
                if ($resetIndex -ge 0) {
                    $text = $text.Insert($resetIndex, $bookingEvent)
                    $changed = $true
                    $report += "Injected booking_submit event into success callback in $($file.FullName)"
                } else {
                    $successIndex = $text.IndexOf('document.getElementById("successMessage").style.display', $thenStart, [System.StringComparison]::Ordinal)
                    if ($successIndex -ge 0) {
                        $text = $text.Insert($successIndex, $bookingEvent)
                        $changed = $true
                        $report += "Injected booking_submit event into success callback in $($file.FullName)"
                    }
                }
            }
        }
    }
    if ($changed -and $text -ne $orig) {
        Set-Content -Path $file.FullName -Value $text -Encoding UTF8
        $modifiedFiles += $file.FullName
    }
}
$reportPath = Join-Path $root 'ga4_patch_report.txt'
$reportSummary = @(
    "total_public_html_files=$($files.Count)",
    "modified_public_html_files=$($modifiedFiles.Count)",
    "excluded_files=employes (employee/admin pages excluded)"
)
Set-Content -Path $reportPath -Value ($reportSummary + $report + $modifiedFiles) -Encoding UTF8
Write-Output "Patch completed: $($modifiedFiles.Count) files modified. Report saved to $reportPath."