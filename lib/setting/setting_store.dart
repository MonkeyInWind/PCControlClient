import 'package:mobx/mobx.dart';
import './../main_store.dart';

part 'setting_store.g.dart';

class SettingStore = _SettingStore with _$SettingStore;

abstract class _SettingStore with Store {
  @observable
  String inputIp = '';
  @observable
  String inputPort = '';

  //连接状态
  @action
  ipChange(String value) {
    inputIp = value;
  }

  @action
  portChange(String value) {
    inputPort = value;
  }

  @action
  connectToggle() {
    String address = 'http://$inputIp:$inputPort';
    print(address);
    mainStore.connected = !mainStore.connected;
  }
}

final settingStore = SettingStore();