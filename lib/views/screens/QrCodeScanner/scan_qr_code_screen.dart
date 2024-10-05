//
// import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
// import 'package:card_scanner/views/widgets/customText/custom_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// import '../../../controllers/storage_controller.dart';
// import '../../../utils/app_strings.dart';
// import '../CreateCard/create_edit_card_screen.dart';
//
// class ScanQrCodeScreen extends StatefulWidget {
//   ScanQrCodeScreen({super.key, required this.result});
//
//   String? result;
//   @override
//   State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
// }
//
// class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
//
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   static Barcode? result;
//   QRViewController? controller;
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomBackButton(
//                       onTap: (){
//                         Get.back();
//                         widget.result = null;
//                         },
//                     icon: Icons.arrow_back,
//                   ),
//                   CustomText(text: "QR Scanner",),
//                   SizedBox(width: 30),
//                 ],
//               ),
//             ),
//             // Expanded(
//             //   flex: 5,
//             //   child: QRView(
//             //     cameraFacing: CameraFacing.back,
//             //     key: qrKey,
//             //     onQRViewCreated: _onQRViewCreated,
//             //   ),
//             // ),
//             Expanded(
//               flex: 1,
//               child: Center(
//                 child: (widget.result != null)
//                     ? Text(
//                     'Barcode Type: ${describeEnum(widget.result!)}   Data: ${widget.result!}')
//                     : Text('Scan a code'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   // void _onQRViewCreated(QRViewController controller) {
//   //   this.controller = controller;
//   //   controller.scannedDataStream.listen((scanData) {
//   //     setState(() {
//   //         result = scanData;
//   //         if (result != null) {
//   //           if (kDebugMode) {
//   //             print('Scanned data: ${result!.code}');
//   //           }
//   //           List<String> parts = result!.code!.split('/');
//   //           String name = parts[0];
//   //           String designation = parts[1];
//   //           String companyName = parts[2];
//   //           String email = parts[3];
//   //           String phoneNumber = parts[4];
//   //           String address = parts[5];
//   //
//   //           StorageController.nameController.text = name;
//   //           StorageController.designationController.text = designation;
//   //           StorageController.companyController.text = companyName;
//   //           StorageController.emailController.text = email;
//   //           StorageController.phoneController.text = phoneNumber;
//   //           StorageController.addressController.text = address;
//   //
//   //           if (kDebugMode) {
//   //             print("$name, $designation, $companyName, $email, $phoneNumber, $address");
//   //           }
//   //           // Now you can use this data as needed
//   //           Get.to(CreateOrEditCardScreen(screenTitle: AppStrings.createCard))?.then((value) {
//   //             result = null;
//   //           },);
//   //
//   //         }
//   //       });
//   //   });
//   //   controller.stopCamera();
//   // }
//
//   // @override
//   // void dispose() {
//   //   controller?.dispose();
//   //   super.dispose();
//   // }
// }
