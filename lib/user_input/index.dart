import 'package:flutter/material.dart';
import './../ws_store.dart';
import 'index_store.dart';

class UserInputPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                  flex: 1,
                  child: Listener(
                    child: InkWell(
                        child: Container(
                          color: Colors.cyanAccent,
                        ),
                        radius: 90,
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