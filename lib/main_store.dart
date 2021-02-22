import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'home/index.dart';
import 'setting/index.dart';
import 'user_input/index.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  // 导航
  @observable
  Widget currentPage = HomePage();
  @observable
  String mainTitle = 'Home';
  @observable
  int currentIndex = 0;

  @action
  void pageChange(index) {
    List<String> titleList = [
      'Home',
      'Control',
      'Settings'
    ];

    List<Widget> pageList = [
      HomePage(),
      UserInputPage(),
      SettingPage()
    ];

    currentIndex = index;
    mainTitle = titleList[index];
    currentPage = pageList[index];
  }
}

final mainStore = MainStore();