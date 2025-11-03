# Tower Types - Stats & Abilities

## 1. Basic Gnome (obj_tower_basic)

**Color:** Green
**Cost:** 50 gold
**Role:** Balanced starter tower

### Stats:

- Range: 200 pixels
- Damage: 10
- Attack Speed: 60 frames (1 second)
- DPS: 10

### Description:

Balanced tower good for all situations. Reliable and affordable.

---

## 2. Sniper Gnome (obj_tower_sniper)

**Color:** Blue
**Cost:** 100 gold
**Role:** Long-range specialist

### Stats:

- Range: 400 pixels (2x basic)
- Damage: 30 (3x basic)
- Attack Speed: 120 frames (2 seconds)
- DPS: 15

### Special Features:

- Crosshair appears on target when aiming
- Best for picking off enemies before they reach the front lines

### Description:

Long-range sniper tower with high single-target damage but slow fire rate.

---

## 3. Rapid Fire Gnome (obj_tower_rapid)

**Color:** Orange
**Cost:** 75 gold
**Role:** Swarm control

### Stats:

- Range: 150 pixels (shorter than basic)
- Damage: 5 (half of basic)
- Attack Speed: 20 frames (0.33 seconds, 3x faster than basic)
- DPS: 15

### Special Features:

- Muzzle flash visual effect when firing
- Excellent against swarms of weak enemies

### Description:

Rapid-fire tower that excels at dealing with multiple weak enemies.

---

## 4. Bomb Gnome (obj_tower_bomb)

**Color:** Red
**Cost:** 150 gold
**Role:** Area-of-Effect specialist

### Stats:

- Range: 180 pixels
- Primary Damage: 15
- Attack Speed: 90 frames (1.5 seconds)
- Primary DPS: 10

### AOE Stats:

- AOE Radius: 80 pixels
- AOE Damage: 8 (to all enemies in radius)
- Total Potential DPS: 10-50+ (depending on enemy clustering)

### Special Features:

- Deals splash damage to all enemies within 80 pixels of primary target
- Orange circle shows AOE radius when range display is active
- Enemies flash white when hit by AOE damage
- Best when enemies are grouped together

### Description:

Explosive tower that deals area-of-effect damage. Most expensive but devastating against grouped enemies.

---

## Tower Comparison Table

| Tower Type | Cost | Range | Damage | Speed (sec) | DPS | Special    |
| ---------- | ---- | ----- | ------ | ----------- | --- | ---------- |
| Basic      | 50   | 200   | 10     | 1.0         | 10  | Balanced   |
| Sniper     | 100  | 400   | 30     | 2.0         | 15  | Long range |
| Rapid      | 75   | 150   | 5      | 0.33        | 15  | Fast fire  |
| Bomb       | 150  | 180   | 15+8   | 1.5         | 10+ | AOE damage |

## Strategic Tips

1. **Early Game:** Use Basic Gnomes for cost efficiency
2. **Mid Game:** Add Sniper Gnomes for range coverage
3. **Swarms:** Place Rapid Fire Gnomes where enemies cluster
4. **Dense Waves:** Bomb Gnomes shine when enemies group up

## Implementation Notes

All towers inherit from `obj_gnome_defender` and share:

- Lane-based targeting (targets enemies in same lane)
- Homing projectile creation
- Range visualization toggle (R key)
- Automatic target acquisition

The Bomb Gnome has special AOE logic in its Step event that deals splash damage when the primary projectile is fired.
