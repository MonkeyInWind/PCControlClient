import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:PCControlClient/components/Button.dart';
import './../ws_store.dart';
import 'index_store.dart';

class UserInputPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    FocusNode inputFocusNode = new FocusNode();
    List<Widget> fcKeyList = [];
    List<Widget> hotKeyList = [];
    List<Widget> underLineKeyList = [];

    for(var i = 0; i < userInputStore.fcKeys.length; i++) {
      double paddingRight = i % 2 == 1 ? 0 : 10;
      fcKeyList.add(CButton(
        padding: [0, 10, 0, paddingRight],
        icon: userInputStore.fcKeys[i] == 'drag' ? Icons.touch_app : null,
        text: userInputStore.fcKeys[i] != 'drag' ? userInputStore.fcKeys[i] : '',
        onPressed: (){
          inputFocusNode.unfocus();
        },
      ));
    }

    for(var i = 0; i < userInputStore.hotKeys.length; i++) {
      String key = userInputStore.hotKeys[i];
      hotKeyList.add(CButton(
          width: 68,
          text: key,
          onPressed: (){
            inputFocusNode.unfocus();
            userInputStore.pressedHotKey(key);
          }
      ));
    }

    for(var i = 0; i < userInputStore.underLineKeys.length; i++) {
      String key = userInputStore.underLineKeys[i];
      IconData icon;
      if (key == 'space') icon = Icons.space_bar;
      if (key == 'backspace') icon = Icons.backspace;
      underLineKeyList.add(CButton(
          icon: icon,
          text: icon == null ? key : '',
          onPressed: (){
            inputFocusNode.unfocus();
            userInputStore.pressedKey(key);
          }
      ));
    }
    return Scaffold(
        body: Observer(builder: (_) => Flex(
            direction: Axis.vertical,
            children: [
              Container(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: Colors.black12
                            )
                          )
                        ),
                        child: Wrap(
                          children: fcKeyList
                        )
                      )
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5
                            ),
                            height: 60,
                            width: 50,
                            child: TextButton(
                              child: Icon(Icons.keyboard_arrow_left),
                              onPressed: () {
                                inputFocusNode.unfocus();
                                userInputStore.pressedKey('left');
                              },
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: TextButton(
                                    child: Icon(Icons.keyboard_arrow_up),
                                    onPressed: () {
                                      inputFocusNode.unfocus();
                                      userInputStore.pressedKey('up');
                                    },
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    child: Text('Enter'),
                                    onPressed: () {
                                      inputFocusNode.unfocus();
                                      userInputStore.pressedKey('enter');
                                    }
                                  )
                                ),
                                Container(
                                  child: TextButton(
                                    child: Icon(Icons.keyboard_arrow_down),
                                    onPressed: () {
                                      inputFocusNode.unfocus();
                                      userInputStore.pressedKey('down');
                                    },
                                  ),
                                )
                              ]
                            )
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5
                            ),
                            height: 60,
                            width: 50,
                            child: TextButton(
                              child: Icon(Icons.keyboard_arrow_right),
                              onPressed: () {
                                inputFocusNode.unfocus();
                                userInputStore.pressedKey('right');
                              },
                            ),
                          )
                        ]
                      )
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: hotKeyList
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: underLineKeyList
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        focusNode: inputFocusNode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Message',
                        ),
                        enabled: wsStore.connected,
                        onChanged: userInputStore.userInputChange,
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: userInputStore.userInput,
                            selection: TextSelection.fromPosition(
                              TextPosition(
                                offset: userInputStore.userInput.length
                              )
                            )
                          )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10
                      ),
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('send'),
                        onPressed: () {
                          inputFocusNode.unfocus();
                          userInputStore.sendMessToPc();
                        },
                      ),
                    )
                  ]
                )
              ),
              Expanded(
                  flex: 1,
                  child: Listener(
                    child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(50, 0, 0, 0)
                          ),
                        ),
                        onTap: () {
                          if (!wsStore.connected) return;
                          userInputStore.mouseAction({
                            'operation': 'tap'
                          });
                        },
                        onDoubleTap: () {
                          if (!wsStore.connected) return;
                          userInputStore.mouseAction({
                            'operation': 'doubleTap'
                          });
                        },
                        onLongPress: () {
                          if (!wsStore.connected || userInputStore.isMoving) return;
                          userInputStore.mouseAction({
                            'operation': 'longPress'
                          });
                        }
                    ),
                    onPointerDown: (PointerDownEvent e) {
                      inputFocusNode.unfocus();
                      if (!wsStore.connected) return;
                      Offset offset = e.position;
                      userInputStore.mouseAction({
                        'operation': 'pointerDown',
                        'prev': {
                          'x': offset.dx,
                          'y': offset.dy
                        }
                      });
                    },
                    onPointerMove: (PointerMoveEvent e) {
                      if (!wsStore.connected) return;
                      Offset offset = e.position;
                      num disX = offset.dx - userInputStore.prevX;
                      num disY = offset.dy - userInputStore.prevY;
                      if (disX == 0 && disY == 0) return;
                      var axis = {
                        'disX': disX,
                        'disY': disY
                      };
                      userInputStore.mouseAction({
                        'operation': 'move',
                        'axis': axis,
                        'prev': {
                          'x': offset.dx,
                          'y': offset.dy
                        }
                      });
                    },
                    onPointerUp: (PointerUpEvent e) {
                      userInputStore.setMovingStatus(false);
                    },
                    onPointerCancel: (PointerCancelEvent e) {
                      userInputStore.setMovingStatus(false);
                    },
                  )
              )
            ]
        )
      )
    );
  }
}