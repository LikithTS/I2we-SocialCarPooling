import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class InternetChecks {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static void showLoadingCircle(BuildContext context) {
    // Show progress bar
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  static void closeLoadingProgress(BuildContext context) {
    Navigator.of(context).pop();
  }
}
