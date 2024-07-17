import 'dart:io';

import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/presentation/widgets/button.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/theme/theme.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = 'scanner';
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  FoodController foodController = Get.put(FoodController());

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRView(context),
          Positioned(
            top: 80,
            child: buildText(),
          ),
        ],
      ),
    );
  }

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 10.0,
          borderLength: 20.0,
          borderRadius: 10.0,
          borderColor: primary,
        ),
        formatsAllowed: const [
          BarcodeFormat.code39,
          BarcodeFormat.code128,
          BarcodeFormat.ean8,
          BarcodeFormat.ean13,
          BarcodeFormat.upcE,
        ],
      );

  void onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen((qrData) async {
      final String? qrCode = qrData.code;
      foodController.addFoodFromBarcode(qrCode!);
      qrViewController.dispose();
    });
  }

  Widget buildText() => SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Text(
            'Barcode scannen',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.white),
          ),
        ),
      );
}
