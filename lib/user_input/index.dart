import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import './../ws_store.dart';
import 'index_store.dart';

class UserInputPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    FocusNode inputFocusNode = new FocusNode();
    
    return Scaffold(
        body: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Observer(builder: (_) => TextField(
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
                    )),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10
                      ),
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('send'),
                        onPressed: () {
                          inputFocusNode.unfocus();
                          userInputStore.sendMessToPc();
                        },
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text('Enter'),
                        onPressed: () {
                          inputFocusNode.unfocus();
                          userInputStore.pressedEnter();
                        }
                      )
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
                          userInputStore.userAction({
                            'operation': 'tap'
                          });
                        },
                        onDoubleTap: () {
                          if (!wsStore.connected) return;
                          userInputStore.userAction({
                            'operation': 'doubleTap'
                          });
                        },
                        onLongPress: () {
                          if (!wsStore.connected || userInputStore.isMoving) return;
                          userInputStore.userAction({
                            'operation': 'longPress'
                          });
                        }
                    ),
                    onPointerDown: (PointerDownEvent e) {
                      inputFocusNode.unfocus();
                      if (!wsStore.connected) return;
                      Offset offset = e.position;
                      userInputStore.userAction({
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
                      userInputStore.userAction({
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
    );
  }
}