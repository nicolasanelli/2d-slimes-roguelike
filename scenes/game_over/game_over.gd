extends Node2D


@onready var time_elapsed: Label = $GameOverScreen/Overlay/TimeElapsed
@onready var monster_killed: Label = $GameOverScreen/Overlay/MonsterKilled
@onready var bullets_shooted: Label = $GameOverScreen/Overlay/BulletsShooted

func _process(_delta: float) -> void:
	time_elapsed.text = "Time elapsed: %s" % Statistics.get_time_elapsed_as_string()
	monster_killed.text = "Monster killed: %s" % Statistics.get_mob_killed()
	bullets_shooted.text = "Bullets shooted: %s" % Statistics.get_bullet_shooted()

func _on_replay_button_pressed() -> void:
	Loader.load_scene(self, "res://scenes/game_screen/game_screen.tscn")


func _on_exit_button_pressed() -> void:
	Loader.load_scene(self, "res://scenes/main_menu/main_menu.tscn")
