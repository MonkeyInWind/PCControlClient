import 'package:mobx/mobx.dart';
import './../ws_store.dart';

part 'index_store.g.dart';

class UserInputStore = _UserInputStore with _$UserInputStore;

abstract class _UserInputStore with Store {
	bool isMoving = false;
	num prevX = 0;
	num prevY = 0;
	
	@action
	userAction(Map<String, dynamic> data) {
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
}

final userInputStore = UserInputStore();