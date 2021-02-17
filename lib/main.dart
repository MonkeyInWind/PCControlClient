import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MouseContainer(),
    );
  }
}

class MouseContainer extends StatefulWidget {
  @override
  _MouseState createState() => new _MouseState();
}

class _MouseState extends State<MouseContainer>{
  var channel;
  bool connected = false;
  bool isMoving = false;
  num prevX = 0;
  num prevY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.blue,
          child: Text('WebSocket')
        )
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: MaterialButton(
                  child: Text('connect'),
                  color: Colors.lightBlue,
                  onPressed: () {
                    channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.31.132:8000/ws'));
                    channel.stream.listen((message) {
                      print(message);
                      // channel.sink.add('received!');
                      // channel.sink.close(status.goingAway);
                    });
                    setState(() {
                      connected = true;
                    });
                    print('connected: $connected');
                  }
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: MaterialButton(
                  child: Text('disconnect'),
                  color: Colors.red,
                  onPressed: () {
                    channel.sink.close();
                    setState(() {
                      connected = false;
                    });
                    print('connected: $connected');
                  }
                )
              )
            ]
          ),
          Expanded(
            flex: 1,
            child: Listener(
              child: InkWell(
                child: Container(
                  color: Colors.cyanAccent,
                ),
                radius: 90,
                onTap: () {
                  if (!connected) return;
                  print('tap');
                  channel.sink.add(json.encode({
                    'operation': 'tap'
                  }));
                },
                onDoubleTap: () {
                  if (!connected) return;
                  print('double tap');
                  channel.sink.add(json.encode({
                    'operation': 'doubleTap'
                  }));
                },
                onLongPress: () {
                  print(isMoving);
                  if (!connected || isMoving) return;
                  print('on long press');
                  channel.sink.add(json.encode({
                    'operation': 'longPress'
                  }));
                }
              ),
              onPointerDown: (PointerDownEvent e) {
                if (!connected) return;
                Offset offset = e.position;
                prevX = offset.dx;
                prevY = offset.dy;
              },
              onPointerMove: (PointerMoveEvent e) {
                if (!connected) return;
                Offset offset = e.position;
                num disX = offset.dx - prevX;
                num disY = offset.dy - prevY;
                if (disX == 0 && disY == 0) return;
                print(1);
                isMoving = true;
                var axis = {
                  'disX': disX,
                  'disY': disY
                };
                channel.sink.add(json.encode({
                  'operation': 'move',
                  'axis': axis
                }));

                prevX = offset.dx;
                prevY = offset.dy;
              },
              onPointerUp: (PointerUpEvent e) {
                isMoving = false;
                print(2);
              },
              onPointerCancel: (PointerCancelEvent e) {
                isMoving = false;
              },
            )
          )
        ]
      )
    );
  }
}