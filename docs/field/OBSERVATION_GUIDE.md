# GeoApp — Field Observation Sheet Guide

**Bakit ito ang unang trabaho:** ~3 linggo ang kailangan ng data collection.
Walang observations = walang trustworthy forecast. Habang binubuo ang Flutter
app, dapat tumatakbo na ang field work.

## Crowd level scale (1–5)

| Level | Meaning | Ano ang makikita mo |
|------:|---------|---------------------|
| 1 | Empty / very light | Madaling umupo; walang pila o 1–2 tao lang |
| 2 | Light | May ilang customers; short wait |
| 3 | Moderate | Typical lunch/dinner; noticeable queue |
| 4 | Busy | Mahaba ang pila; konti o walang free seats |
| 5 | Packed | Sikip; mahirap pumasok; long wait |

## Protocol (pare-pareho kayong lahat)

1. Pumasok o tumayo sa **dining area entrance** (hindi sa drive-thru lang).
2. Mag-observe ng **2–3 minuto** bago mag-score.
3. Bilangin ang **queue length** (tao sa counter line), kung applicable.
4. Itala ang **exact local time** (phone clock).
5. Isang row = isang observation. Huwag i-average sa field — i-average sa pipeline.

## Minimum coverage target (Angeles City, ~10 km)

Per branch, aim for:

- **Weekday** lunch (11:00–13:00): ≥ 4 visits
- **Weekday** dinner (17:00–19:00): ≥ 4 visits
- **Weekend** lunch + dinner: ≥ 4 visits each
- At least **2 off-peak** slots (e.g. 15:00, 21:00)

Target: **≥ 30 observations per branch** before training the seed forecast.

## Brands to prioritize (example set)

Start with high-traffic Angeles corridors (adjust to your final list):

- Jollibee
- McDonald's
- Chowking
- Mang Inasal
- KFC

## Honesty rule for defense

GeoApp is **prediction + user reports**, not a live camera or sensor.
Field sheets train the historical model — they are not "live CCTV."
