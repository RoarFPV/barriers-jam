extends Node3D

enum LevelState {
	RELOAD,
	LOAD,
	START,
	PLAY,
	PAUSE,
	FAIL,
	WIN,
}

var _state:LevelState = LevelState.LOAD

@onready var DeliveryManager = get_tree().get_first_node_in_group("DeliveryManager")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_updateState()

func _updateState():
	match _state:
		LevelState.RELOAD:
			_state = LevelState.LOAD
			ScoreManager.score = 0
			DeliveryManager.reset()
			checkpoints.clear()
			checkpointsComplete.clear()
			get_tree().reload_current_scene()
		LevelState.LOAD:
			_state = LevelState.START
			$StartTimer.start()
		LevelState.START:
			pass
		LevelState.PLAY:
			if checkEnd():
				if ScoreManager.score < 1:
					_state = LevelState.FAIL
				else:
					_state = LevelState.WIN
					
				$EndTimer.start()
		LevelState.PAUSE:
			pass
		LevelState.FAIL:
			pass
		LevelState.WIN:
			pass

var checkpoints : Array[Checkpoint] = [] 
var checkpointsComplete : Array[bool] = []

func addCheckpoint(node:Checkpoint):
	checkpoints.append(node)
	checkpointsComplete.append(false)
	
func enterCheckpoint(node:Checkpoint):
	var index = checkpoints.find(node)
	if index == -1:
		return
	
	if index == 0 or checkpointsComplete[index-1]:
		checkpointsComplete[index] = true

func checkEnd() -> bool:
	return DeliveryManager.all_packages_delivered()
	

func all_checkpoints_complete():
	checkpointsComplete.all(func(complete): return complete)

func _on_end_timer_timeout() -> void:
	_state = LevelState.RELOAD


func _on_start_timer_timeout() -> void:
	_state = LevelState.PLAY

func get_level_state_name() -> String:
	return LevelState.keys()[_state]
	
func is_win_state() -> bool:
	return _state == LevelState.WIN
