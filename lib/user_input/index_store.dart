import 'package:mobx/mobx.dart';
import './../ws_store.dart';

part 'index_store.g.dart';

class UserInputStore = _UserInputStore with _$UserInputStore;

abstract class _UserInputStore with Store {
	bool isMoving = false;
	num prevX = 0;
	num prevY = 0;
	List fcKeys = [
		'drag',
		'shift',
		'control',
		'option',
		'alt',
		'command'
	];

	List hotKeys = [
		'ctrl+a',
		'ctrl+c',
		'ctrl+x',
		'ctrl+v',
		'ctrl+z'
	];

	List underLineKeys = [
		'esc',
		'tab',
		'space',
		'backspace'
	];
	
	@observable
	bool holdingAlt = false;
	@observable
	bool holdingShift = false;
	@observable
	bool holdingOption = false;
	@observable
	bool holdingControl = false;
	@observable
	bool holdingCommand = false;
	
	@observable
	String userInput = '';
	
	@action
	userInputChange(String value) {
		userInput = value;
	}
	
	@action
	mouseAction(Map<String, dynamic> data) {
		var operation = data['operation'];

		switch(operation) {
			case 'pointerDown':
				prevX = data['prev']['x'];
				prevY  = data['prev']['y'];
				break;
			case 'move':
				prevX = data['prev']['x'];
				prevY  = data['prev']['y'];
				isMoving = true;
				wsStore.sendMessage({
					'operation': 'move',
					'axis': data['axis']
				});
				break;
			default:
				wsStore.sendMessage(data);
				break;
		}
	}
	
	@action
	setMovingStatus(status) {
		isMoving = status;
	}
	
	@action
	sendMessToPc() {
		wsStore.sendMessage({
			'operation': 'input',
			'message': userInput
		});
		userInput = '';
	}
	
	@action
	pressedKey(key) {
		wsStore.sendMessage({
			'operation': 'keyboard_press',
			'key': key
		});
	}
	
	@action
	pressedHotKey(key) {
		wsStore.sendMessage({
			'operation': 'hot_key_press',
			'key': key
		});
	}
	
}

final userInputStore = UserInputStore();