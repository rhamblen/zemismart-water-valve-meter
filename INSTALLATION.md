# Installation Guide

**Version:** 1.0.0  
**Last updated:** 2026-06-18

---

## Step 1 — Install the required custom card

This card requires **`custom:html-template-card`** by Piotr Machowski, installed via HACS.

1. Open Home Assistant → HACS → Frontend
2. Search for **"HTML Template Card"**
3. Install it and reload your browser

Direct link: [lovelace-html-template-card on GitHub](https://github.com/PiotrMachowski/lovelace-html-template-card)

---

## Step 2 — Confirm your entity IDs

The card expects entities with the prefix `garden_water_meter`. Check your actual entity IDs in **Settings → Devices & Services → your water meter device**.

If your prefix differs (e.g. `water_meter_garden` or `front_tap_meter`), you will substitute it in Step 4.

Required entities:

| Entity | What it provides |
|--------|-----------------|
| `sensor.garden_water_meter_flow_rate` | Current flow rate (centre dial) |
| `sensor.garden_water_meter_temperature` | Pipe temperature |
| `switch.garden_water_meter` | Valve control |
| `sensor.garden_water_meter_daily_consumption` | Today's usage |
| `sensor.garden_water_meter_month_consumption` | This month's usage |
| `sensor.garden_water_meter_water_consumed` | Cumulative total |
| `sensor.garden_water_meter_faults` | Fault codes |

---

## Step 3 — Download the card YAML

Download [`releases/v1.0.0/card.yaml`](releases/v1.0.0/card.yaml) from this repository.

Or copy the raw YAML directly from that file.

---

## Step 4 — Adapt entity IDs (if needed)

If your entity prefix is not `garden_water_meter`, open `card.yaml` in a text editor and do a **find and replace**:

- Find: `garden_water_meter`
- Replace: `your_actual_prefix`

---

## Step 5 — Add the card to your dashboard

### Option A — Via the UI editor

1. Open your dashboard → Edit → Add card → **Manual card**
2. Delete the placeholder YAML
3. Paste the full contents of `card.yaml`
4. Save

### Option B — Via Claude (AI-assisted)

Tell Claude:

> "Add the garden water meter card to my [dashboard name] dashboard, [tab name] tab, after the [section name] section. Use entity prefix [your_prefix]. The card spec is at https://github.com/rhamblen/zemismart-water-valve-meter."

Claude will need:
- Access to your Home Assistant via the Home Assistant MCP
- The `ha_config_get_dashboard` and `ha_config_set_dashboard` tools
- Your dashboard url_path, view index, and target section index

### Option C — Direct YAML edit (advanced)

Add the following to your Lovelace `views[n].sections` list:

```yaml
- type: grid
  background:
    color: lightgray
    opacity: 50
  cards:
    - type: heading
      heading: Water Meter
    - type: custom:html-template-card
      ignore_line_breaks: true
      content: >-
        # paste content string from card.yaml here
```

---

## Step 6 — Verify

Open your dashboard. The Water Meter card should show:
- A circular dial with your current flow rate
- Temperature in the top-left badge
- Valve status (OPEN/CLOSED) in the top-right badge
- Today and This month stats at the bottom

If the card shows a red error, check that `custom:html-template-card` is installed and that your entity IDs are correct.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Red "Custom element doesn't exist" error | html-template-card not installed | Install via HACS and reload |
| All values show `unknown` | Entity IDs don't match | Check entity prefix in HA device page |
| Fault light always amber | New device boot faults | These clear once the device sees water flow |
| Monthly history is flat | Expected — monthly counter changes slowly | The This Month click opens HA History page where you can widen the time range to weeks/months |
| Temperature badge always grey | Temp sensor unavailable | Check zigbee device connectivity |

---

## Updating to a newer version

When a new release is available:

1. Download the new `card.yaml` from the relevant release folder
2. In your dashboard editor, find the Water Meter card and click Edit
3. Replace the `content:` value with the updated one
4. Save

Or ask Claude to do it:

> "Update my garden water meter card to the latest version from https://github.com/rhamblen/zemismart-water-valve-meter"
