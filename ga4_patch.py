from pathlib import Path
import re

root = Path('.').resolve()

ga_snippet = '''<script async src="https://www.googletagmanager.com/gtag/js?id=G-BGQMNF8C0G"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-BGQMNF8C0G');
</script>
'''

tracking_script = '''<script>
(function() {
  function trackEvent(eventName, params) {
    if (typeof gtag === 'function') {
      gtag('event', eventName, params);
    } else if (window.dataLayer && typeof window.dataLayer.push === 'function') {
      window.dataLayer.push(Object.assign({ event: eventName }, params));
    }
  }

  function addTracking(link, eventName, params) {
    if (link.dataset.ga4Tracked !== 'true') {
      link.addEventListener('click', function() {
        trackEvent(eventName, params);
      });
      link.dataset.ga4Tracked = 'true';
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('a[href^="tel:"]').forEach(function(link) {
      var href = link.getAttribute('href');
      if (href) {
        addTracking(link, 'phone_call_click', {
          event_category: 'engagement',
          event_label: href.replace(/^tel:/i, '')
        });
      }
    });

    document.querySelectorAll('a[href*="wa.me"], a[href*="api.whatsapp.com"]').forEach(function(link) {
      addTracking(link, 'whatsapp_click', {
        event_category: 'engagement',
        event_label: 'WhatsApp'
      });
    });
  });
})();
</script>
'''

booking_event = '''        if (typeof gtag === 'function') {
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
'''

changed_files = []
failed_files = []
html_files = list(root.rglob('*.html'))
for html_path in sorted(html_files):
    try:
        text = html_path.read_text(encoding='utf-8', errors='ignore')
    except Exception as e:
        failed_files.append(f'{html_path}: read error {e}')
        continue

    orig = text
    updated = text
    # GA snippet insertion
    if 'G-BGQMNF8C0G' not in updated or 'gtag(' not in updated:
        if re.search(r'</head\s*>', updated, flags=re.I):
            updated = re.sub(r'</head\s*>', ga_snippet + '\n</head>', updated, count=1, flags=re.I)

    # tracking script insertion
    if 'phone_call_click' not in updated and 'whatsapp_click' not in updated:
        if re.search(r'</body\s*>', updated, flags=re.I):
            updated = re.sub(r'</body\s*>', tracking_script + '\n</body>', updated, count=1, flags=re.I)

    # booking event insertion for booking forms
    if re.search(r'<form[^>]+id=["\']bookingForm["\']', updated, flags=re.I) and 'booking_submit' not in updated:
        match = re.search(r'(fetch\([^\)]*\)[\s\S]*?\.then\(\s*\(\)\s*=>\s*\{)([\s\S]*?)(this\.reset\(\)\s*;)', updated, flags=re.I)
        if match:
            start, end = match.span(3)
            updated = updated[:start] + booking_event + updated[start:]
        else:
            fetch_pos = updated.find('fetch(')
            reset_pos = updated.find('this.reset();', fetch_pos if fetch_pos >= 0 else 0)
            if fetch_pos != -1 and reset_pos != -1:
                updated = updated[:reset_pos] + booking_event + updated[reset_pos:]

    if updated != orig:
        try:
            html_path.write_text(updated, encoding='utf-8')
            changed_files.append(str(html_path))
        except Exception as e:
            failed_files.append(f'{html_path}: write error {e}')

report_path = root / 'ga4_patch_report.txt'
with report_path.open('w', encoding='utf-8') as report:
    report.write(f'total_html_files={len(html_files)}\n')
    report.write(f'modified_files={len(changed_files)}\n')
    report.write(f'failed_files={len(failed_files)}\n')
    report.write('\n'.join(changed_files) + '\n')
    report.write('\n'.join(failed_files) + '\n')

# marker file to verify execution
(root / 'ga4_patch_marker.txt').write_text('done', encoding='utf-8')

print(f'processed {len(html_files)} files, modified {len(changed_files)}, failed {len(failed_files)}')
