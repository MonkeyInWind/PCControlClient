import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'index_store.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) => Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 20
              ),
              child: Text(
                'Device: ' + homeStore.platform,
                style: TextStyle(
                  fontSize: 15
                ),
              )
            )
          ]
        )
      )
    ));
  }
}