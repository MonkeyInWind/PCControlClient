import 'package:mobx/mobx.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'index_store.g.dart';

class QRScannerStore = _QRScannerStore with _$QRScannerStore;

abstract class _QRScannerStore with Store {
  @observable
  QRViewController controller;

  @action
  QRViewCreated(QRViewController qrController) {
    controller = qrController;
    controller.scannedDataStream.listen((scanData) {

    });
  }
  
}

final qrScannerStore = QRScannerStore();