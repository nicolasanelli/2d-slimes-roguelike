# 2D-SLIMES-ROGUELIKE

A roguelike game using free assets and Godot Engine 4.4.

## Main features
- [x] Gameloop
- [x] GlobalTimer
- [x] Statistics
- [x] CardManager
- [x] Upgradable weapons
- [x] Scalable cards
- [x] Scalable weapons
- [x] Scalable enemies
- [x] Mobile friendly
- [x] ~~Tutorial~~ Pseudo-guide
- [x] Infinite map
- [x] Infinite waves
- [x] Dificulty Scale
- [x] 60 FPS
- [x] Sound efx
- [x] Pause screen
- [ ] Options Menu wih Music/SFX volume adjust on main menu
- [ ] Exit button for windows on main menu
- [ ] Pause button for mobile
- [ ] Pause menu
    - [ ] Exit
    - [ ] Options
- [ ] Mobile aim (currently using auto-aim)
- [ ] EventListener for SoundEffecs7
- [ ] Alternate between Pistol and Shotgun [can't use at same time]
- [ ] Reroll cards
- [ ] Use Path2D to slime find Player 
- [ ] Achievements
    - [ ] Finish with only Shotgun
    - [ ] Finish with only Pistol
    - [ ] Finish with only Saw
    - [ ] Finish without pickup any heal
    - [ ] Evolve Shotgun to Mythic
    - [ ] Evolve Pistol to Mythic
    - [ ] Evolve Saw to Mythic
    - [ ] Finish under 10 minutes


## How to add a new weapon

1. Create a new Resource Type to new weapon
This resource type is used to create diferent upgrades.
Create a data directory to the new weapon at **data/weapons/new_weapon** containing new_weapon_resource.gd (should extends BaseWeaponResource), and 001_common_newweapon.tres, etc

2. Create a new `add_weapon_card´ resource type at **data/usable_card/add_weapon_card**, this should extends AddWeaponCardResource

3. Create the ´upgrade_weapon_cards` to the new weapon at **data/usable_card/upgrade_weapon_card**, this should extends UpgradeWeaponCardResource

4. Create a new scene to the new weapon at **components/weapons/new_weapon**

5. The weapon root scene should have a MetaData names *WeaponName* with value equals to the weapon_name used in upgrade weapon cards. You can add a MetaData at the end of the Inspector.

6. The weapon root scene should belong to GlobalGroup "weapons". You can select a group in the Tab Node, right to Inspector tab.

7. The weapon script should have a upgrade function with following signature:
````
func upgrade(resource: BaseWeaponResource) -> void:
````


#### Planned Structure
Maybe something does not match, as this is the concept idea
````
UsableCardResource
    - name
    - description
    - color
    - texture

    AddWeaponCard
        - weapon_component // path_to_scene
        - position // vector2

        IMPLEMENTATIONs
        add_gun_card:
            name: pistol
            description: adiciona uma arma comum
            color: grey
            texture: pistol.png
            weapon_component: gun.tscn
            position Vector2(0, 34)

    UpgradeWeaponCard
        - weapon_name
        - resource: BaseWeapon

        IMPLEMENTATIONs
        upgrade_gun_uncommon:
            name: pistol
            description: atualiza sua arma para incomum
            color: light green
            texture: pistol.png
            weapon_name: pistol
            resource: 002_uncommon_pistol
````