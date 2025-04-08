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
- [x] Use Path2D to slime find Player 
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

1. Create a new scene containing your weapon in **components/weapons**. It's a good idea to create a folder with your weapon's name. Your weapon's script must extends BaseWeapon like following example.
````godot
class_name Pistol
extends BaseWeapon
````
2. You can use Resources to manage diferente evolutions (or tiers) of your weapon. To create a resource for your weapon, create your weapon's name folder at **data/weapons** and you can create your own custom
resource type containing any data you need. Take a look at the following example:
````
class_name PistolData
extends BaseWeaponData

@export var bullets: int
@export var damage: int
@export var attack_speed: float
````
3. Now you can create resources using your custom type and name and populate them as your needs. They usually stay in the same folder where the custom type is.
4. To reference your resource in your weapon script, you need to use get_resource() method as shown below:
````
    func shoot() -> void:
        for n in range(get_resource().bullets):
````
5. If you are missing autocomplete, you can override the get_resource() method in your weapon script. You can also override a setup() method, that is called everytime the resource is replaced.
````
#region Override
    func setup() -> void:
        configure_timer()

    func get_resource() -> PistolData:
        return super.get_resource()
#endregion 
````
6. Now, yout weapon should be ready, you need to create Cards to allow player to use them during the game.
7. Go to **data/cards/weapon_cards** and create a folder with your weapon's name.
8. Now you can create card resource of type WeaponCard (i.e. common_pistol_card.tres). This resource is really straightforward.
    - Weapon: should be you weapon scene
    - Resource: should be the variation of your weapon that this card references (i.e. 001_common_pistol.tres)
    - Name: Card name
    - Texture: Card Texture
    - Description: Card Description
    - Color: Don't need to be defined here, since your WeaponResource should have a Rarity level.
9. Last, but not least, you need to add your card in the DeckManager (for now) manually. Open deck_manager.gd, and add you weapon in the options dictionary. The key should be unique, and the order of the elements
are the order that the cards should be picked by the player.
10. Also, add your key from the dictionary to the ``var consumable_keys``, to "consume" the card on use, and requeue if not picked.

