# v1.0.0 — Initial Release

**Released:** 2026-06-18

First public release of the Zemismart Water Valve & Meter Home Assistant dashboard card.

## What's included

- `card.yaml` — drop-in Lovelace card configuration (grid section + heading + html-template-card)

## Features

- Circular instrument dial with live flow rate and flowing animation
- Temperature badge with automatic ice warning (≤ 4 °C turns blue with pulse)
- Valve status badge: green OPEN / red CLOSED with tap-to-toggle via more-info
- Fault warning light: dim when clear, amber glow when any fault code is active
- Cumulative total water consumed
- Today's consumption — tap opens 24 h history graph
- This month's consumption — tap navigates to HA History page (full time-range selector)
- Dynamic units from entity attributes
- HA theme-aware styling

## Installation

See [INSTALLATION.md](../../INSTALLATION.md)

## Known issues

- On first install, `sensor.{prefix}_faults` may report `empty_pipe_alarm` and/or `transducer_alarm` — these are common boot-up states on a new or dry device and typically clear once water flows through
- `sensor.{prefix}_voltage` is not displayed (often reports `unknown` on initial setup)
