# Installation Guide

**Current version:** v1.0.0  
**Repository:** https://github.com/rhamblen/zemismart-water-valve-meter

---

## Choose your installation method

### Option A — Claude-assisted (recommended)

No manual steps. Claude reads the repository and deploys the card for you.

**What you need first:**
- HACS installed in Home Assistant
- `custom:html-template-card` installed via HACS → Frontend → search "HTML Template Card"
- Claude with Home Assistant MCP connected

**Then tell Claude:**

> "Help me install the Zemismart Water Valve & Meter card from https://github.com/rhamblen/zemismart-water-valve-meter — my entity prefix is `garden_water_meter`. Add it to my [dashboard name] dashboard."

Claude will:
1. Read the card YAML from the repository
2. Confirm your entity prefix matches what the card expects
3. Deploy the card to your dashboard

Replace `garden_water_meter` with your actual prefix if it differs (see [Finding your entity prefix](#finding-your-entity-prefix) below).

---

### Option B — Manual installation

#### Prerequisites

| Requirement | How to get it |
|-------------|--------------|
| HACS | https://hacs.xyz |
| `custom:html-template-card` | HACS → Frontend → search "HTML Template Card" |
| Zemismart Water Meter | Paired via Zigbee2MQTT or ZHA |

---

#### Finding your entity prefix

Go to **Settings → Devices & Services → your water meter device**. You will see entities like:

| Entity | Example |
|--------|---------|
| `sensor.{prefix}_flow_rate` | `sensor.garden_water_meter_flow_rate` |
| `switch.{prefix}` | `switch.garden_water_meter` |
| `sensor.{prefix}_temperature` | `sensor.garden_water_meter_temperature` |

Your prefix is everything before `_flow_rate` in the flow sensor name — e.g. `garden_water_meter`.

> **Note:** This card requires no additional helpers or automations. The Zemismart device exposes all required sensors (flow rate, temperature, daily/monthly consumption, cumulative total, faults) natively.

---

#### Step 1 — Download and adapt the card YAML

1. Download [`releases/v1.0.0/card.yaml`](releases/v1.0.0/card.yaml) from this repository
2. If your entity prefix is not `garden_water_meter`, open the file in a text editor and do a find-and-replace:
   - Find: `garden_water_meter`
   - Replace: `your_actual_prefix`

---

#### Step 2 — Add the card to your dashboard

1. Open your Lovelace dashboard → click the pencil (edit) icon
2. Click **+ Add card** in the target section
3. Scroll to the bottom and choose **Manual card**
4. Delete the placeholder YAML and paste the full contents of your adapted `card.yaml`
5. Click **Save**

---

#### Step 3 — Verify

The card should show:

- **Circular dial** — live flow rate in the centre, pulsing blue glow when water is flowing
- **Temperature badge** — pipe temperature; turns blue with ❄ ice warning at ≤ 4 °C
- **Valve status badge** — 🟢 OPEN / 🔴 CLOSED; tap to toggle
- **Fault warning light** — dim when clear, glowing amber ⚠ when faults are active
- **Stats bar** — Today and This month (tappable for 24 h history graph)
- **Total consumed** — cumulative odometer

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| "Custom element doesn't exist" error | `html-template-card` not installed | Install via HACS and reload browser |
| All values show `unknown` or `unavailable` | Entity IDs don't match | Check the entity prefix — go to Settings → Devices → your meter |
| Fault light always amber | Device boot faults | These clear once the device sees water flow |
| Monthly history is flat | Expected — monthly counter changes slowly | Tap "This month" to open HA History; widen the time range to weeks/months |
| Temperature badge always grey | Temp sensor unavailable | Check Zigbee2MQTT / ZHA device connectivity |

---

## Updating to a newer version

1. Download `releases/v{version}/card.yaml` from this repository
2. Apply your entity prefix find-and-replace if needed
3. Open your dashboard editor → find the Water Meter card → Edit → replace the content → Save
