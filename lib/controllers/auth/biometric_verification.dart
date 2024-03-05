import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricVerification{
  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool isCheckBiometric = false;
  bool isAuthenticated = false;
  late List<BiometricType> listAvailableBiometric;

  Future<String> authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
          localizedReason: "Please authenticate to make transactions",
      );
    } on PlatformException catch (e) {
      print(e);
    }
    isAuthenticated = authenticated;
     authorized = authenticated ? "Authorized success" : "Failed to authenticate";
      print(authorized);

      return authorized;
  }

  Future<bool> checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

     isCheckBiometric = canCheckBiometric;
    print("_canCheckBiometric:$isCheckBiometric");
    return isCheckBiometric;
  }

  Future getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    listAvailableBiometric = availableBiometric;
    print("_availableBiometric:$listAvailableBiometric");

    return listAvailableBiometric;
  }
}