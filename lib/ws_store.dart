import 'package:mobx/mobx.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './setting/index_store.dart';

part 'ws_store.g.dart';

class WsStore = _WsStore with _$WsStore;

abstract class _WsStore with Store {
	@observable
	var channel;
	
	//连接状态
	@observable
	bool connected = false;
	
	@action
	connectToggle() async {
		if (!connected) {
			String ip = settingStore.inputIp;
			String port = settingStore.inputPort;
			
			String address = 'ws://$ip:$port/ws';
			print(address);
			channel = IOWebSocketChannel.connect(Uri.parse(address));
			print('connected');
			channel.stream.listen(onWsMessage, onError: onWsError, onDone: onWsDown);
			SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString('ip', ip);
			prefs.setString('port', port);
		} else {
			channel.sink.close();
		}
		connected = !connected;
	}
	
	sendMessage(data) {
		channel.sink.add(json.encode(data));
	}
	
	onWsMessage(data) {
		var received = json.decode(data);
		if (received == null || !received['result']) {
			print(received);
			return;
		}
		
		var receivedData = received['data'];
		switch(received['type']) {
			case 'system_info':
				String platform = receivedData['platform'];
				print(platform);
				break;
			default:
				break;
		}
	}
	
	onWsError(e) {
		print(e);
	}
	
	@action
	onWsDown() {
		print('disconnected');
		connected = false;
	}
}

final wsStore = WsStore();