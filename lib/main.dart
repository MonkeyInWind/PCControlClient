import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'main_store.dart';
import 'ws_store.dart';

void main() {
  runApp(PCController());
}

class PCController extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainContainer(),
    );
  }
}

class MainContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Observer(builder: (_) => Scaffold(
      appBar: AppBar(
        leading: Icon(
          wsStore.connected ? Icons.check_circle : Icons.error_outline,
          color: wsStore.connected ? Colors.greenAccent : Colors.redAccent
        ),
        title: Title(
          color: Colors.blue,
          child: Text(mainStore.mainTitle),
        ),
      ),
      body: mainStore.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mouse), label: 'Control'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: mainStore.currentIndex,
        fixedColor: Colors.blue,
        onTap: mainStore.pageChange
      )
    ));
  }
}