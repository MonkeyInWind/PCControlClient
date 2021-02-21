import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'setting_store.dart';
import './../main_store.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode ipFocusNode = new FocusNode();
    FocusNode portFocusNode = new FocusNode();

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Observer(builder: (_) => ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10
              ),
              child: TextField(
                focusNode: ipFocusNode,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'IP',
                  prefix: Text('http://'),
//                  border: OutlineInputBorder(
//                    borderSide: BorderSide(
//                      color: Colors.blue
//                    )
//                  )
                ),
                onChanged: settingStore.ipChange,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                enabled: !mainStore.connected,
              )
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 0,
                bottom: 10,
                right: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      focusNode: portFocusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'PORT',
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide(
//                            color: Colors.blue
//                          )
//                        )
                      ),
                      onChanged: settingStore.portChange,
                      keyboardType: TextInputType.number,
                      enabled: !mainStore.connected,
                    ),
                  ),
                  Container(
                    child: MaterialButton(
                      child: Text(mainStore.connected ? 'disconnect' : 'connect'),
                      color: mainStore.connected ? Colors.red : Colors.blue,
                      onPressed: () {
                        ipFocusNode.unfocus();
                        portFocusNode.unfocus();
                        settingStore.connectToggle();
                      },
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    ));
  }
}