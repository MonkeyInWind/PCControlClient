import 'package:mobx/mobx.dart';

part 'index_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  String platform = '';

  @action
  setDeviceInfo(deviceInfo) {
    if (deviceInfo == null) return;
    platform = deviceInfo['platform'];
  }
}

final homeStore = HomeStore();