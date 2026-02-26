# 2D Slimes Roguelike – TODO

This document tracks planned improvements, refactors, and future systems for the project.

The goal is not only to expand gameplay but to evolve the project into a scalable and well-structured roguelite architecture.

---

# 🎮 Core Gameplay Systems

## Combat & Player

- [ ] Improve player movement feel (acceleration / deceleration tuning)
- [ ] Add attack variations (area / piercing / scaling effects)
- [ ] Introduce ability cooldown visualization
- [ ] Add invulnerability frames
- [ ] Refactor damage calculation into centralized combat system

## Enemy System

- [ ] Create modular enemy behavior system (movement + attack as components)
- [ ] Add new slime archetypes (tank / ranged / split-on-death / fast)
- [ ] Implement elite variants
- [ ] Add boss encounter prototype
- [ ] Improve enemy scaling formula

---

# 📈 Progression & Roguelite Layer

## In-Run Progression

- [ ] Upgrade selection system (choice between 3 upgrades)
- [ ] Passive stat scaling system
- [ ] Synergy-based upgrades
- [ ] Temporary buffs
- [ ] Risk vs reward mechanics

## Meta Progression (Between Runs)

- [ ] Persistent currency system
- [ ] Permanent upgrade tree
- [ ] Unlockable abilities
- [ ] Difficulty tiers
- [ ] Run statistics tracking

---

# 💎 Drop & Reward System

- [ ] Refactor DropManager for scalability
- [ ] Support weighted drop tables
- [ ] Add rarity tiers
- [ ] Implement visual feedback for rare drops
- [ ] Optimize drop spawning performance
- [ ] Add auto-collect logic

---

# ⚙️ Architecture & Refactor

- [ ] Separate visual layer from gameplay logic
- [ ] Introduce stat container abstraction
- [ ] Centralize scaling formulas
- [ ] Decouple wave logic from enemy instantiation
- [ ] Standardize event signaling between systems
- [ ] Improve node hierarchy organization
- [ ] Add debug overlay for runtime stats

---

# 🚀 Performance Optimization

- [ ] Profile performance with large enemy counts
- [ ] Replace heavy nodes with lighter alternatives
- [ ] Reduce per-frame calculations
- [ ] Batch process stat updates
- [ ] Optimize collision layers and masks
- [ ] Implement object pooling for enemies
- [ ] Implement object pooling for drops
- [ ] Measure GC impact 

---

# 🌊 Wave & Scaling System

- [ ] Improve wave generation logic
- [ ] Add dynamic difficulty scaling
- [ ] Add pacing system (calm → intense → boss)
- [ ] Introduce spawn modifiers
- [ ] Implement adaptive difficulty experiment

---

# 🧠 Systems Design Experiments

- [ ] Hybrid roguelike + incremental scaling
- [ ] Endless mode prototype
- [ ] Time-based scaling model
- [ ] DPS benchmark mode
- [ ] Simulation mode for balancing

---

# 🎨 UX & Visual Polish

- [ ] Improve hit feedback (flash / shake / particles)
- [ ] Add screen shake system
- [ ] Add better damage numbers
- [ ] Add health bars for elites/bosses
- [ ] Improve UI layout consistency
- [ ] Add sound effects polish
- [ ] Add background parallax

---

# 💾 Persistence & Systems

- [ ] Implement save system
- [ ] Implement run summary screen
- [ ] Add statistics dashboard
- [ ] Store best runs
- [ ] Add JSON-based configuration system

---

# 🔬 Debug & Dev Tools

- [ ] Toggleable debug UI
- [ ] Spawn test controls
- [ ] Speed multiplier
- [ ] Force wave trigger
- [ ] Drop simulation tool

---

# 🧱 Long-Term Vision

- [ ] Procedural map variation
- [ ] Biomes
- [ ] Modular ability system
- [ ] Skill tree
- [ ] Mod support architecture experiment
- [ ] Mobile optimization experiment
- [ ] Web export optimization

---

# 🎯 Strategic Goal

Transform the project into:

- A scalable roguelite architecture sandbox
- A performance experimentation playground
- A systems design study project
- A strong technical portfolio piece

