import 'dart:async';

import 'package:allergies/core/locales.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/controller/general_controller.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:multi_split_view/multi_split_view.dart';

import '../../../../core/theme/theme.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = 'scanner';
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with WidgetsBindingObserver {
  FoodController foodController = Get.find();
  GeneralController generalController = Get.find();

  final MultiSplitViewController splitViewController =
      MultiSplitViewController();

  StreamSubscription<Object?>? subscription;

  MobileScannerController qrController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [
      BarcodeFormat.code39,
      BarcodeFormat.code128,
      BarcodeFormat.ean8,
      BarcodeFormat.ean13,
      BarcodeFormat.upcE,
    ],
  );

  bool showFlashlight = false;
  bool showFrontcamera = false;

  void handleBarcode(capture) {
    List<Barcode> barcodes = capture.barcodes;

    for (var barcode in barcodes) {
      print("barcode: ${barcode.rawValue}");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    subscription = qrController.barcodes.listen(handleBarcode);

    unawaited(qrController.start());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deviceHeight = MediaQuery.of(context).size.height;
      splitViewController.areas = [
        Area(size: deviceHeight * 0.7, min: deviceHeight * 0.5),
        Area(size: deviceHeight * 0.3),
      ];
    });
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(subscription?.cancel());
    subscription = null;
    super.dispose();
    await qrController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!qrController.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        subscription = qrController.barcodes.listen(handleBarcode);
        unawaited(qrController.start());
      case AppLifecycleState.inactive:
        unawaited(subscription?.cancel());
        subscription = null;
        unawaited(qrController.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
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
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    highlightedColor: Theme.of(context).colorScheme.onSurface,
                    size: 60,
                    highlightedSize: 60,
                  ),
                ),
                child: MultiSplitView(
                  axis: Axis.vertical,
                  controller: splitViewController,
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
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  width: MediaQuery.sizeOf(context).width - 20,
                                  height: double.infinity,
                                  child: MobileScanner(
                                    controller: qrController,
                                    onDetect: handleBarcode,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: largeCirular,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        qrController.switchCamera();
                                      },
                                      child: Container(
                                        padding: smallPadding,
                                        child: Icon(
                                          Icons.flip_camera_ios_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    smallGap,
                                    GestureDetector(
                                      onTap: () async {
                                        qrController.toggleTorch();
                                        setState(() {
                                          showFlashlight = !showFlashlight;
                                        });
                                      },
                                      child: Container(
                                        padding: smallPadding,
                                        child: Icon(
                                          Icons.flashlight_on_rounded,
                                          color: showFlashlight
                                              ? primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                          size: 26,
                                        ),
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
                          left: 12,
                          right: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Obx(
                          () => foodController.scanList.isEmpty
                              ? Center(
                                  child: Text(
                                    LocaleData.scanResultInfo
                                        .getString(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                    textAlign: TextAlign.center,
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
                                              controllerAllergy
                                                  .name(context)
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

  // void onQRViewCreated(QRViewController qrViewController) {
  //   setState(() {
  //     this.qrViewController = qrViewController;
  //   });

  //   qrViewController.scannedDataStream.listen((qrData) async {
  //     final String? qrCode = qrData.code;

  //     if (!foodController.qrCodesList.contains(qrCode)) {
  //       if (generalController.useHapticFeedback.value == true) {
  //         showSuccessToast();
  //         showHapticFeedback();
  //       }

  //       qrViewController.pauseCamera();

  //       foodController.qrCodesList.add(qrCode!);
  //       foodController.addFoodFromBarcode(qrCode, context);

  //       Beamer.of(context).beamToNamed(FoodDetailScreen.routeName);

  //       Future.delayed(const Duration(seconds: 2), () {
  //         qrViewController.resumeCamera();
  //       });
  //     } else {
  //       showAlreadyScannedToast();
  //     }
  //     //qrViewController.dispose();
  //   });
  // }

  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: LocaleData.scanSuccess.getString(context),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: black,
      textColor: white,
      fontSize: 16,
    );
  }

  void showAlreadyScannedToast() {
    Fluttertoast.showToast(
      msg: LocaleData.scanExists.getString(context),
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
      await Haptics.vibrate(HapticsType.success);
    }
  }
}
