import 'dart:io';

import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/theme/theme.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = 'scanner';
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  FoodController foodController = Get.find();

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;

  final MultiSplitViewController _controller = MultiSplitViewController();

  bool useBackCamera = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deviceHeight = MediaQuery.of(context).size.height;
      _controller.areas = [
        Area(size: deviceHeight * 0.7, min: deviceHeight * 0.5),
        Area(size: deviceHeight * 0.3),
      ];
      _controller.addListener(_rebuild);
    });
    _controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    _controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // rebuild to update empty text and buttons
    });
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
      backgroundColor: background,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: MultiSplitViewTheme(
                data: MultiSplitViewThemeData(
                  dividerPainter: DividerPainters.grooved1(
                    thickness: 12,
                    highlightedThickness: 12,
                    color: neutral300,
                    highlightedColor: black,
                    size: 60,
                    highlightedSize: 60,
                  ),
                ),
                child: MultiSplitView(
                  axis: Axis.vertical,
                  controller: _controller,
                  pushDividers: false,
                  builder: (BuildContext context, Area area) {
                    if (area.index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: largeCirular,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: largeCirular,
                                    color: background,
                                  ),
                                  width: MediaQuery.sizeOf(context).width - 20,
                                  height: double.infinity,
                                  child: buildQRView(context),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: largeCirular,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        qrViewController!.flipCamera();
                                      },
                                      child: Container(
                                        padding: smallPadding,
                                        child: const Icon(
                                            Icons.flip_camera_ios_rounded),
                                      ),
                                    ),
                                    smallGap,
                                    GestureDetector(
                                      onTap: () {
                                        qrViewController!.toggleFlash();
                                      },
                                      child: Container(
                                        padding: smallPadding,
                                        child: const Icon(
                                            Icons.flashlight_on_rounded),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Obx(
                          () => foodController.scanList.isEmpty
                              ? Center(
                                  child: Text(
                                    "Hier werden deine Scans angezeigt",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: foodController.scanList.length,
                                  itemBuilder: (context, index) {
                                    final reversedIndex =
                                        foodController.scanList.length -
                                            1 -
                                            index;
                                    bool hasAllergies = foodController
                                        .scanList[reversedIndex].allergens
                                        .any(
                                      (allergy) {
                                        return foodController.allergiesList.any(
                                            (controllerAllergy) =>
                                                controllerAllergy.name ==
                                                allergy);
                                      },
                                    );

                                    List<String> commonAllergens =
                                        foodController
                                            .scanList[reversedIndex].allergens
                                            .where((allergy) {
                                      return foodController.allergiesList.any(
                                          (controllerAllergy) =>
                                              controllerAllergy.name
                                                  .toLowerCase() ==
                                              allergy.toLowerCase());
                                    }).toList();
                                    return FoodListTile(
                                      name: foodController
                                          .scanList[reversedIndex].name.value,
                                      allergenes: commonAllergens,
                                      hasAllergies: hasAllergies,
                                    );
                                  },
                                ),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width * 0.7,
        borderWidth: 12,
        borderLength: 24,
        borderRadius: 12,
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
  }

  void onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen((qrData) async {
      final String? qrCode = qrData.code;
      if (!foodController.qrCodesList.contains(qrCode)) {
        foodController.qrCodesList.add(qrCode!);
        foodController.addFoodFromBarcode(qrCode);
        showSuccessToast();
        showHapticFeedback();
      } else {
        print("already scanned");
      }
      //qrViewController.dispose();
    });
  }

  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Barcode erkannt!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: black,
      textColor: white,
      fontSize: 16,
    );
  }

  void showHapticFeedback() async {
    final canVibrate = await Haptics.canVibrate();

    if (canVibrate) {
      print('vibrate');
      await Haptics.vibrate(HapticsType.success);
    } else {
      print("can not vibrate");
    }
  }
}
