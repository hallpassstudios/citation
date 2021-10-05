extends Node

var db
var session_id
var ref
var timer

const MODULO_8_BIT = 256

# Called when the node enters the scene tree for the first time.
func _ready():
	var firebase_config = {
		"apiKey": "AIzaSyCTOankLa189x7qD_b8iIxETPefX_a-yeU",  # set somewhere only if using auth
		"authDomain": "your-awesome-app.firebaseapp.com",
		"databaseURL": "https://citation-34f48-default-rtdb.firebaseio.com/",
		"projectId": "citation-34f48",
		"storageBucket": "your-awesome-app.appspot.com",
		"messagingSenderId": "111111111111",
		"appId": "1:1082271308226:web:20420b71130671e1601e5b"
	}
	# Initialize Firebase
	firebase.initialize_app(firebase_config)

	# Get a reference to the database service.
	db = firebase.database()
	session_id = v4()
	print(session_id)
	new_session()
	add_player()
	
	# Sign in anon
	# Get a reference to the database service.
	var auth : FirebaseAuth = firebase.auth()

	# Sign a user in.
	var result = yield(auth.sign_in_anonymously(), "completed")
	if result is FirebaseError:
		print(result.code)
	else:
		var user = result as FirebaseUser
		print(user.email)
	
#store the session id upon load
func new_session():
	var ref : FirebaseReference = db.get_reference_lite("/sessions/" + session_id +"/client info")
	var result = yield(ref.update({
		"time": OS.get_time(true),
		"touchscreen": OS.has_touchscreen_ui_hint()
	}), "completed")
	
# incremement the total player count
func add_player():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current player count
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['player count']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"player count": value + 1
	}), "completed")

func player_wins():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['player wins']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"player wins": value + 1
	}), "completed")
	

# citations
func citations():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['total citations']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"total citations": value + 1
	}), "completed")

# hidden levels found
func hidden_level():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['hidden levels found']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"hidden levels found": value + 1
	}), "completed")

# caught cheating
func caught():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['cheaters caught']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"cheaters caught": value + 1
	}), "completed")

# table flips
func table_flips():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['table flips']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"table flips": value + 1
	}), "completed")

# books read
func books_read():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['books read']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"books read": value + 1
	}), "completed")
	
# bat deaths
func bat_deaths():
	var ref: FirebaseReference = db.get_reference_lite("/meta/player stats/")
	# read our current table flips
	var player_count = yield(ref.fetch(), "completed")
	var value = player_count.value()
	value = value['bat deaths']
	# player_count = int(player_count.value())
	var result = yield(ref.update({
		"bat deaths": value + 1
	}), "completed")
	
func dialogue_objective(value):
	set_objective(value[0])

func set_objective(objective):
	var ref : FirebaseReference = db.get_reference_lite("/sessions/" + session_id + "/objectives/" + objective)
	var result = yield(ref.update({
		"completed": true,
		"elapsed time": OS.get_ticks_msec()
	}), "completed")

func objective_completed(objective_name, data):
	var ref : FirebaseReference = db.get_reference_lite("/sessions/" + session_id + "/objectives/" + objective_name)
	var result = yield(ref.update({
		"data": data
	}), "completed")

static func getRandomInt():
  # Randomize every time to minimize the risk of collisions
  randomize()
  return randi() % MODULO_8_BIT

static func uuidbin():
  # 16 random bytes with the bytes on index 6 and 8 modified
  return [
	getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt(),
	getRandomInt(), getRandomInt(), ((getRandomInt()) & 0x0f) | 0x40, getRandomInt(),
	((getRandomInt()) & 0x3f) | 0x80, getRandomInt(), getRandomInt(), getRandomInt(),
	getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt(),
  ]

static func v4():
  # 16 random bytes with the bytes on index 6 and 8 modified
  var b = uuidbin()

  return '%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x' % [
	# low
	b[0], b[1], b[2], b[3],

	# mid
	b[4], b[5],

	# hi
	b[6], b[7],

	# clock
	b[8], b[9],

	# clock
	b[10], b[11], b[12], b[13], b[14], b[15]
  ]


