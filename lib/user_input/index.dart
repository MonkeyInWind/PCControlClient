import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import './../ws_store.dart';
import 'index_store.dart';

class UserInputPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    FocusNode inputFocusNode = new FocusNode();
    
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
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Icon(Icons.touch_app),
                                onPressed: (){
                                  inputFocusNode.unfocus();
                                },
                              )
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Text('shift'),
                                onPressed: (){
                                  inputFocusNode.unfocus();
                                },
                              )
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Text('control'),
                                onPressed: (){
                                  inputFocusNode.unfocus();
                                },
                              )
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Text('option'),
                                onPressed: (){
                                  inputFocusNode.unfocus();
                                },
                              )
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Text('alt'),
                                onPressed: (){
                                  inputFocusNode.unfocus();
                                },
                              )
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Text('command'),
                                onPressed: (){
                                  inputFocusNode.unfocus();
                                },
                              )
                            ),
                          ]
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
                  children: [
                    Container(
                      width: 68,
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('ctrl+a'),
                        onPressed: (){
                          inputFocusNode.unfocus();
                          userInputStore.pressedHotKey('cmd+a');
                        },
                      )
                    ),
                    Container(
                      width: 68,
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('ctrl+x'),
                        onPressed: (){
                          inputFocusNode.unfocus();
                          userInputStore.pressedHotKey('cmd+x');
                        },
                      )
                    ),
                    Container(
                      width: 68,
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('ctrl+c'),
                        onPressed: (){
                          inputFocusNode.unfocus();
                          userInputStore.pressedHotKey('cmd+c');
                        },
                      )
                    ),
                    Container(
                      width: 68,
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('ctrl+v'),
                        onPressed: (){
                          inputFocusNode.unfocus();
                          userInputStore.pressedHotKey('cmd+v');
                        },
                      )
                    ),
                    Container(
                      width: 68,
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('ctrl+z'),
                        onPressed: (){
                          inputFocusNode.unfocus();
                          userInputStore.pressedHotKey('cmd+z');
                        },
                      )
                    ),
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('esc'),
                        onPressed: () {
                          inputFocusNode.unfocus();
                          userInputStore.pressedKey('esc');
                        },
                      )
                    ),
                    Container(
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('tab'),
                        onPressed: (){
                          inputFocusNode.unfocus();
                          userInputStore.pressedKey('tab');
                        },
                      )
                    ),
                    Container(
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Icon(Icons.space_bar),
                        onPressed: () {
                          inputFocusNode.unfocus();
                          userInputStore.pressedKey('space');
                        },
                      )
                    ),
                    Container(
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Icon(Icons.backspace),
                        onPressed: () {
                          inputFocusNode.unfocus();
                          userInputStore.pressedKey('backspace');
                        },
                      )
                    ),
                  ]
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