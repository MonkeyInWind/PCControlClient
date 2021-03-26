import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'index_store.dart';

class QrScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    //此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
    @override
    void reassemble() {
      if (Platform.isAndroid) {
        qrScannerStore.controller.pauseCamera();
      }
      qrScannerStore.controller.resumeCamera();
    }

    var scanArea = (MediaQuery.of(context).size.width < 500 ||
        MediaQuery.of(context).size.height < 500)
        ? 250.0
        : 350.0;

    return Stack(
      children: [
        Container(
          child: QRView(
            key: qrKey,
            onQRViewCreated: qrScannerStore.QRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 6,
                cutOutSize: scanArea
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 30,
          child: FloatingActionButton(
            mini: true,
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            },
          )
        ),
        Positioned(
          width: 60,
          height: 60,
          bottom: 140,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: TextButton(
            child: Icon(
              Icons.highlight,
              size: 40,
            ),
            onPressed: () async {
              await qrScannerStore.controller.toggleFlash();
            },
          )
        )
      ]
    );
  }
}