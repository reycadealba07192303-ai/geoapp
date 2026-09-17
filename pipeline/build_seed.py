"""
Offline forecast pipeline (laptop only — not shipped inside the Flutter app).

Flow:
  docs/field/observation_sheet.csv
    → clean + aggregate (pandas)
    → fit day-of-week × hour baselines (scikit-learn or weighted average)
    → export assets/seed/geoapp_seed.db

Run later:
  python pipeline/build_seed.py
"""

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CSV = ROOT / "docs" / "field" / "observation_sheet.csv"
OUT = ROOT / "assets" / "seed" / "geoapp_seed.db"


def main() -> None:
    print("GeoApp pipeline stub")
    print(f"  read:  {CSV}")
    print(f"  write: {OUT}")
    print("Implement aggregation once ≥30 observations/branch exist.")


if __name__ == "__main__":
    main()
