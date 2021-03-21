import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'index_store.dart';
import './../ws_store.dart';

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
                ),
                onChanged: settingStore.ipChange,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                enabled: !wsStore.connected,
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: settingStore.inputIp,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        offset: settingStore.inputIp.length
                      )
                    )
                  )
                ),
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
                      ),
                      onChanged: settingStore.portChange,
                      keyboardType: TextInputType.number,
                      enabled: !wsStore.connected,
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: settingStore.inputPort,
                          selection: TextSelection.fromPosition(
                            TextPosition(
                              offset: settingStore.inputPort.length
                            )
                          )
                        )
                      ),
                    ),
                  ),
                  Container(
                    child: MaterialButton(
                      child: Text(wsStore.connected ? 'disconnect' : 'connect'),
                      color: wsStore.connected ? Colors.red : Colors.blue,
                      onPressed: () {
                        ipFocusNode.unfocus();
                        portFocusNode.unfocus();
                        wsStore.connectToggle();
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