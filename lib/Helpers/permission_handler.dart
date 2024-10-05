
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';


class PhonePermissionHandler{
  Future<bool> storageRequest(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if(build.version.sdkInt >= 30){
      var re = await Permission.manageExternalStorage.request();
      if(re.isGranted){
        if (kDebugMode) {
          print("Permission is granted");
        }
        return true;
      }else{
        if (kDebugMode) {
          print("Permission is not granted");
        }
        return false;
      }
    }else{
      if(await permission.isGranted){
        return true;
      }else{
        var result = await permission.request();
        if(result.isGranted){
          return true;
        }else{
          return false;
        }
      }
    }
  }

  Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release);
    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await Permission.photos.request(); //import 'package:permission_handler/permission_handler.dart';
      debugPrint('IsPermission Granted? : ${request.isGranted}');
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
      debugPrint('IsPermission Granted? : $havePermission');
    }

    if (!havePermission) {
      // if no permission then open app-setting
      await openAppSettings();
    }

    return havePermission;
  }

}
