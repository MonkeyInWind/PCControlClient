import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.blue,
          child: Text('WebSocket')
        )
      ),
      body: Listener(
        child: Container(
          color: Colors.cyanAccent
        ),
        onPointerDown: (PointerDownEvent e) {
          Offset offset = e.position;
          print({
            'x': offset.dx,
            'y': offset.dy
          });
        },
      )
    );
  }
}