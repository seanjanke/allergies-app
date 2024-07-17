import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = 'history';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  bool protocolExists = false;
  bool protocolTuerenExists = false;
  bool serviceReportExists = false;

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              buildQRView(context),
              Positioned(
                bottom: 20.0,
                child: buildBackButton(),
              ),
              Positioned(
                top: 20.0,
                child: buildText(),
              ),
            ],
          ),
        ),
      );

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 10.0,
          borderLength: 20.0,
          borderRadius: 10.0,
          borderColor: Colors.red,
        ),
        formatsAllowed: const [
          BarcodeFormat.qrcode,
        ],
      );

  void onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen((qrData) async {
      final String? qrCode = qrData.code;
      qrViewController.dispose();
    });
  }

  Widget buildBackButton() => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Abbrechen',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
        ),
      );

  Widget buildText() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'QR Code scannen',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Richten Sie die Kamera auf den QR Code',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ],
      );
}
