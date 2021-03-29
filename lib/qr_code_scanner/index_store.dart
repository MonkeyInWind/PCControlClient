import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import './../setting/index_store.dart';
import './../ws_store.dart';

part 'index_store.g.dart';

class QRScannerStore = _QRScannerStore with _$QRScannerStore;

abstract class _QRScannerStore with Store {
  @observable
  QRViewController controller;
  @observable
  bool flashOpened = false;

  BuildContext context;

  @action
  qrViewCreated(QRViewController qrController) {
    controller = qrController;
    controller.scannedDataStream.listen((scanData) {
      if (describeEnum(scanData.format) != 'qrcode') return;
      String address = scanData.code;
      if (!address.startsWith('http://') || !address.contains(':')) return;
      if (Platform.isAndroid) {
        controller.pauseCamera();
      } else if (Platform.isIOS) {
        controller.resumeCamera();
      }

      List splitArr = address.split('http://')[1].split(':');
      settingStore.inputIp = splitArr[0];
      settingStore.inputPort = splitArr[1];
      wsStore.connectToggle();
      Navigator.pop(context, false);
    });
  }

  @action
  toggleFlash() async {
    await controller.toggleFlash();
    flashOpened = !flashOpened;
  }
}

final qrScannerStore = QRScannerStore();