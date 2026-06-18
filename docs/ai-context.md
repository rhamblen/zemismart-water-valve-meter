# AI Context — Zemismart Water Meter Card

This file helps Claude (or any AI assistant) understand the repository structure so it can assist with modifications, updates, and publishing new versions.

---

## Repository purpose

This repository contains a Home Assistant Lovelace dashboard card for the Zemismart Water Valve & Meter zigbee device. The card is a single `custom:html-template-card` rendered as a circular instrument dial.

## File structure

```
/
├── README.md                        — Main project description, features, entity table, colour reference
├── CHANGELOG.md                     — Version history (Keep a Changelog format)
├── INSTALLATION.md                  — Step-by-step install guide including Claude-assisted install
├── .gitignore
├── docs/
│   └── ai-context.md                — This file. AI/Claude reference for repo navigation
└── releases/
    └── v1.0.0/
        ├── card.yaml                — The full Lovelace card YAML (copy-paste ready)
        └── RELEASE_NOTES.md         — Release-specific notes for v1.0.0
```

## Card architecture

The card is a single `custom:html-template-card` with `ignore_line_breaks: true`. It uses:
- **Jinja2** for all live data (entity states and attributes)
- **Inline CSS** scoped under the `.wm-` prefix
- **JavaScript onclick handlers** for interactivity (dispatching HA custom events)
- No external dependencies beyond `custom:html-template-card` itself

## Entity prefix

All entities use the prefix `garden_water_meter`. In `card.yaml`, this appears as:
- `sensor.garden_water_meter_flow_rate`
- `sensor.garden_water_meter_temperature`
- `switch.garden_water_meter`
- `sensor.garden_water_meter_daily_consumption`
- `sensor.garden_water_meter_month_consumption`
- `sensor.garden_water_meter_water_consumed`
- `sensor.garden_water_meter_faults`

To adapt for a different device, find-and-replace `garden_water_meter` with the target prefix.

## Dashboard location (original deployment)

- Dashboard: `my-home` (url_path: `my-home`)
- View index: `5` (Garden tab, `mdi:flower` icon)
- Section index: `5` (after Irrigation, before Cameras)
- Card index within section: `1` (index 0 is the heading card)

HA python_transform path: `config['views'][5]['sections'][5]['cards'][1]['content']`

## Colour logic (quick reference)

| Condition | Element | Effect |
|-----------|---------|--------|
| `temp <= 4.0` | Temperature badge | Blue pulse + ❄ + "Ice Warning" text |
| `valve == 'on'` | Valve badge | Green (OPEN) |
| `valve == 'off'` | Valve badge | Red (CLOSED) |
| `faults not in ['none','None','unknown','unavailable','']` | Warning light | Amber glow |
| `flow > 0` | Dial border | Cyan pulse animation |

## Click interactions

| Element | Action |
|---------|--------|
| Temperature badge | `hass-more-info` → `sensor.{prefix}_temperature` |
| Valve badge | `hass-more-info` → `switch.{prefix}` (includes toggle) |
| Dial | `hass-more-info` → `sensor.{prefix}_flow_rate` (24 h history) |
| Fault light | `hass-more-info` → `sensor.{prefix}_faults` |
| Today stat | `hass-more-info` → `sensor.{prefix}_daily_consumption` (24 h history) |
| This month stat | Navigate to `/history?entity_id=sensor.{prefix}_month_consumption` (full time-range selector) |

Note: Monthly stat uses full-page HA History navigation rather than more-info because a monthly counter changes too slowly for a 24 h popup graph to be useful.

## How to publish a new version

1. Make changes to `releases/v1.0.0/card.yaml` (or create a new `releases/vX.Y.Z/` folder)
2. Update `CHANGELOG.md` with the new version section
3. Update the "Quick install" link in `README.md` to point to the new release folder
4. Commit: `git commit -m "release: vX.Y.Z — description"`
5. Tag: `git tag -a vX.Y.Z -m "vX.Y.Z — description"`
6. Push: `git push origin main --tags`
7. On GitHub, create a Release from the tag, paste `RELEASE_NOTES.md` as the body, and attach `card.yaml` as a release asset

## How to modify the card via Claude

Tell Claude:
> "Update the garden water meter card in my Home Assistant. [describe change]. Reference https://github.com/rhamblen/zemismart-water-valve-meter for context."

Claude should:
1. Read this file for context
2. Call `ha_config_get_dashboard(url_path='my-home', heading='Water Meter')` to locate the card
3. Get current config hash via `ha_config_get_dashboard(url_path='my-home')`
4. Apply changes via `ha_config_set_dashboard(python_transform=..., config_hash=...)`
5. Update `CHANGELOG.md` and `releases/` with the new version
6. Commit and push

## CSS class reference (for modifications)

All classes prefixed `.wm-` — see README.md for full table.
Key classes for visual changes:
- `.wm-ice` — ice warning badge style (blue)
- `.wm-tnorm` — normal temperature badge style (grey)
- `.wm-vopen` — valve open badge (green)
- `.wm-vclosed` — valve closed badge (red)
- `.wm-won` — fault warning light active (amber)
- `.wm-woff` — fault warning light inactive (grey)
- `.wm-df` — dial flowing state (cyan border + glow animation)
