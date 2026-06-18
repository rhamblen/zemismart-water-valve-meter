# Changelog

All notable changes to this project will be documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/).

---

## [1.0.0] — 2026-06-18

### Added
- Initial release of the Garden Water Meter dashboard card
- Circular instrument dial showing live flow rate (`sensor.{prefix}_flow_rate`)
- Pulsing cyan glow animation on the dial when water is actively flowing
- Temperature badge (top-left): grey normally, pulses blue with ❄ ice warning at ≤ 4 °C
- Valve status badge (top-right): green OPEN / red CLOSED; taps open HA more-info with toggle
- Fault warning light: dim grey when clear, glowing amber ⚠ when any fault is active; taps open fault detail
- Cumulative total water consumed displayed below the dial
- Today stat cell — taps open 24 h history graph for `sensor.{prefix}_daily_consumption`
- This month stat cell — taps navigate to HA History page for `sensor.{prefix}_month_consumption` (full time-range selector, appropriate for month-scale data)
- Dynamic units — reads `unit_of_measurement` attribute from each entity; falls back to sensible defaults
- HA theme-aware CSS using `--primary-text-color`, `--secondary-text-color`, `--primary-font-family`
- All CSS scoped under `wm-` prefix to avoid collisions with HA built-in styles
- Full documentation: README, INSTALLATION guide, entity reference, CSS class reference

### Design decisions
- `switch.{prefix}_auto_clean` and `select.{prefix}_report_period` intentionally excluded from the card (internal device controls not needed in daily use)
- Monthly stat navigates to full History page rather than more-info, because a monthly counter changes too slowly for a 24 h graph to be meaningful
