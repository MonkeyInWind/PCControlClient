import 'package:mobx/mobx.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
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
	connectToggle() {
		if (!connected) {
			String ip = settingStore.inputIp;
			String port = settingStore.inputPort;
			
			String address = 'ws://$ip:$port/ws';
			print(address);
			channel = IOWebSocketChannel.connect(Uri.parse(address));
			channel.stream.listen((message) {
				print(message);
			});
		} else {
			channel.sink.close();
		}
		connected = !connected;
	}
	
	sendMessage(data) {
		channel.sink.add(json.encode(data));
	}
}

final wsStore = WsStore();