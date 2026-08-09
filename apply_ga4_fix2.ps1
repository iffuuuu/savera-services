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
      window.dataLayer.push(Object.assign({ event: eventName }, params));
    }
  }
  function attachGa4LinkTracking(link, eventName, params) {
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
        attachGa4LinkTracking(link, 'phone_call_click', {
          event_category: 'engagement',
          event_label: href.replace(/^tel:/i, '')
        });
      }
    });
    document.querySelectorAll('a[href*="wa.me"], a[href*="api.whatsapp.com"]').forEach(function(link) {
      attachGa4LinkTracking(link, 'whatsapp_click', {
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
    if (-not $text.Contains('G-BGQMNF8C0G')) {
        $headMatch = [regex]::Match($text, '</head\s*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($headMatch.Success) {
            $text = $text.Substring(0, $headMatch.Index) + $gaSnippet + "`r`n" + $text.Substring($headMatch.Index)
            $changed = $true
            $report += "Added GA4 snippet to $($file.FullName)"
        }
    }
    if (-not ($text.Contains('window.SaveraGa4AnalyticsInstalled') -or $text.Contains('saveraTrackEvent') -or $text.Contains('phone_call_click') -or $text.Contains('whatsapp_click'))) {
        $bodyMatch = [regex]::Match($text, '</body\s*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($bodyMatch.Success) {
            $text = $text.Substring(0, $bodyMatch.Index) + $trackingHelper + "`r`n" + $text.Substring($bodyMatch.Index)
            $changed = $true
            $report += "Added GA4 click tracking helper to $($file.FullName)"
        }
    }
    if (($text -match 'id\s*=\s*"bookingForm"' -or $text -match "id\s*=\s*'bookingForm'") -and -not $text.Contains('booking_submit')) {
        $inserted = $false
        $resetIndex = $text.IndexOf('this.reset();', [System.StringComparison]::InvariantCultureIgnoreCase)
        if ($resetIndex -ge 0) {
            $text = $text.Insert($resetIndex, $bookingEvent)
            $inserted = $true
        } else {
            $successIndex = $text.IndexOf('document.getElementById("successMessage").style.display', [System.StringComparison]::InvariantCultureIgnoreCase)
            if ($successIndex -ge 0) {
                $text = $text.Insert($successIndex, $bookingEvent)
                $inserted = $true
            } else {
                $tickIndex = $text.IndexOf('tickModal.style.display', [System.StringComparison]::InvariantCultureIgnoreCase)
                if ($tickIndex -ge 0) {
                    $text = $text.Insert($tickIndex, $bookingEvent)
                    $inserted = $true
                }
            }
        }
        if ($inserted) {
            $changed = $true
            $report += "Inserted booking_submit success event into $($file.FullName)"
        }
    }
    if ($changed -and $text -ne $orig) {
        Set-Content -Path $file.FullName -Value $text -Encoding UTF8
        $modifiedFiles += $file.FullName
    }
}
$audit = [System.Collections.Generic.List[string]]::new()
$audit.Add("total_html_files=$($files.Count)")
$ga4Count = 0
$helperCount = 0
$phoneTrackCount = 0
$waTrackCount = 0
$bookingTrackCount = 0
foreach ($file in $files) {
    $text = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $hasGa4 = $text.Contains('G-BGQMNF8C0G')
    $hasHelper = $text.Contains('window.SaveraGa4AnalyticsInstalled') -or $text.Contains('saveraTrackEvent')
    $hasPhone = $hasHelper -and ($text -match 'href\s*=\s*"tel:')
    $hasWhatsApp = $hasHelper -and ($text -match 'href\s*=\s*"https?://(wa\.me|api\.whatsapp\.com)')
    $hasBooking = $text.Contains('booking_submit')
        if ($hasGa4) { $ga4Count++ }
    if ($hasHelper) { $helperCount++ }
    if ($hasPhone) { $phoneTrackCount++ }
    if ($hasWhatsApp) { $waTrackCount++ }
    if ($hasBooking) { $bookingTrackCount++ }
}
$audit.Add("public_html_files_with_ga4=$ga4Count")
$audit.Add("public_html_files_with_helper=$helperCount")
$audit.Add("public_html_files_with_phone_tracking=$phoneTrackCount")
$audit.Add("public_html_files_with_whatsapp_tracking=$waTrackCount")
$audit.Add("public_html_files_with_booking_success_tracking=$bookingTrackCount")
$audit.Add("excluded_files=employes (employee/admin pages excluded)")
$audit.Add("modified_files_count=$($modifiedFiles.Count)")
$audit.Add("files_modified=")
foreach ($f in $modifiedFiles) { $audit.Add($f) }
$duplicateReport = [System.Collections.Generic.List[string]]::new()
foreach ($file in $files) {
    $text = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $ga4CountLocal = ([regex]::Matches($text, 'googletagmanager\.com/gtag/js\?id=G-BGQMNF8C0G')).Count
    if ($ga4CountLocal -gt 1) { $duplicateReport.Add("Duplicate GA4 snippet in $($file.FullName): $ga4CountLocal occurrences") }
    $listenerCount = ([regex]::Matches($text, 'addEventListener\(\s*''click''\s*,\s*function')).Count
    if ($listenerCount -gt 1 -and $text -match 'a\[href\^="tel:"\]|a\[href\*="wa.me"\]') { $duplicateReport.Add("Possible duplicate click listener in $($file.FullName): $listenerCount occurrences") }
}
$audit.Add("duplicate_checks=")
if ($duplicateReport.Count -eq 0) { $audit.Add('no duplicate GA4 snippets or duplicate event listeners found') } else { $duplicateReport | ForEach-Object { $audit.Add($_) } }
$reportPath = Join-Path $root 'ga4_final_report.txt'
$audit | Set-Content -Path $reportPath -Encoding UTF8
$reportPath
Write-Output "Patch complete. Final audit written to ga4_final_report.txt."