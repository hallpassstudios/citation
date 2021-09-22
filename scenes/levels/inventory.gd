extends CanvasLayer

var inventory = []
var inventory_slots = []
onready var slot_1 = $"HBoxContainer/slot 1"
onready var slot_2 = $"HBoxContainer/slot 2"
onready var slot_3 = $"HBoxContainer/slot 3"


func _ready():
	update_inventory()

func add_item(item):
	print("adding item to inventory: ", item)
	inventory.append(item[0])
	print(inventory)
	update_inventory()

func remove_item(item):
	print("removing item from inventory: ", item)
	if inventory.size() == 0:
		return
	var i = 0
	while i < inventory.size():
		if inventory[i] == item[i]:
			print("removing item")
			inventory.remove(i)
			update_inventory()
		i+=1

func update_inventory():
	# loop through our inventory slots
	if inventory.size() == 0:
		print("inventory is zero")
		slot_1.visible = false
		return
	# loop through our inventory
	for inv in inventory:
		if inv == "illuminata cartridge":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/illuminata_cartridge.png"))
			slot_1.set_pressed_texture(load("res://sprites/ui/illuminata_cartridge_pressed.png"))
		if inv == "token":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/token.png"))
		if inv == "coffee":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/coffee.png"))
		if inv == "paper":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/paper.png"))
		if inv == "key":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/key.png"))
		if inv == "lantern":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/lantern.png"))
		if inv == "bulletin":
			slot_1.visible = true
			slot_1.set_normal_texture(load("res://sprites/ui/bulletin.png"))

func _on_slot_1_pressed():
	dialogue_controller.play_dialogue(inventory[0])

func _on_slot_2_pressed():
	dialogue_controller.play_dialogue(inventory[1])

func _on_slot_3_pressed():
	dialogue_controller.play_dialogue(inventory[2])
