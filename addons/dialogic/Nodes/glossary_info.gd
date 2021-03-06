tool
extends PanelContainer

onready var nodes = {
	'title': $VBoxContainer/Title,
	'body': $VBoxContainer/Content,
	'extra': $VBoxContainer/Extra,
	'url': $VBoxContainer/URL
}

var in_theme_editor = false
var margin = 10
var touch : bool = true
var touch_position
var url : String
var hovering

func _ready():
	set_deferred('rect_size.y', 0)
	nodes['title'].bbcode_enabled = true
	nodes['body'].bbcode_enabled = true
	nodes['extra'].bbcode_enabled = true


func _input(event):
	if event is InputEventMouseButton and event.is_pressed() && hovering:
		if url != null:
			print(url)
			# show the confirmation dialogue
			get_parent().current_url = url
			get_parent().open_confirmation(url)
	if event is InputEventScreenTouch:
		touch_position = get_canvas_transform().affine_inverse().xform(event.position)
	
func _process(_delta):
	if Engine.is_editor_hint() == false or in_theme_editor == true:
		if visible:
			if globals.platform != "mobile":
				if get_global_mouse_position().x < get_viewport().size.x * 0.5:
					rect_global_position = get_global_mouse_position() - Vector2(0, rect_size.y + (margin * 2))
				else:
					rect_global_position = get_global_mouse_position() - rect_size - Vector2(0, (margin * 2))
				rect_size.y = 0
			else:
				rect_global_position = touch_position - rect_size - Vector2(0, (margin * 2))
				print("touching")
			rect_size.y = 0
#			

func load_preview(info):
	nodes['title'].visible = false
	nodes['body'].visible = false
	nodes['extra'].visible = false
	nodes['url'].visible = false
	print("url is: ", nodes['url'].text)
	print("title is: ", nodes['title'].text)
	
	if info['title'] != '':
		nodes['title'].bbcode_text = info['title']
		nodes['title'].visible = true

	if info['body'] != '':
		nodes['body'].bbcode_text = info['body']
		nodes['body'].visible = true
	
	if info['extra'] != '':
		nodes['extra'].bbcode_text = info['extra']
		nodes['extra'].visible = true
	
	if info['url'] != '':
		print(info['url'])
		url = info['url']

func load_theme(theme):
	# Fonts
	$VBoxContainer/Title.set(
		'custom_fonts/normal_font', 
		DialogicUtil.path_fixer_load(theme.get_value('definitions', 'font', "res://addons/dialogic/Example Assets/Fonts/GlossaryFont.tres")))
	$VBoxContainer/Title.set('custom_colors/default_color', theme.get_value('definitions', 'title_color', "#ffffffff"))
	
	$VBoxContainer/Content.set(
		'custom_fonts/normal_font', 
		DialogicUtil.path_fixer_load(theme.get_value('definitions', 'text_font', "res://addons/dialogic/Example Assets/Fonts/GlossaryFont.tres")))
	$VBoxContainer/Content.set('custom_colors/default_color', theme.get_value('definitions', 'text_color', "#c1c1c1"))
	
	$VBoxContainer/Extra.set(
		'custom_fonts/normal_font', 
		DialogicUtil.path_fixer_load(theme.get_value('definitions', 'extra_font', "res://addons/dialogic/Example Assets/Fonts/GlossaryFont.tres")))
	$VBoxContainer/Extra.set('custom_colors/default_color', theme.get_value('definitions', 'extra_color', "#c1c1c1"))
	
	set("custom_styles/panel", load(theme.get_value('definitions', 'background_panel', "res://addons/dialogic/Example Assets/backgrounds/GlossaryBackground.tres")))
