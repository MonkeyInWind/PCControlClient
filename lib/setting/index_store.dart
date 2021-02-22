import 'package:mobx/mobx.dart';

part 'index_store.g.dart';

class SettingStore = _SettingStore with _$SettingStore;

abstract class _SettingStore with Store {
  @observable
  String inputIp = '';
  @observable
  String inputPort = '';

  @action
  ipChange(String value) {
    inputIp = value;
  }

  @action
  portChange(String value) {
    inputPort = value;
  }
}

final settingStore = SettingStore();