
import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/user.dart';

class AuthenticationController{
String email = '';
String password = '';
String verifyPassword = '';
String errorMessage = '';
bool? emailValid ;
BuildContext? context;
String? token = "";
int counter = 0;
AccessToken? _accessToken;

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);
final userPreferences = UserPreferences();
// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final HttpClientWrapper _http = HttpClientWrapper();


getGoogleCloudId()async{
  // String? token = await _firebaseMessaging.getToken();
  return token;
}

  validateAllFields(){
    if(passwordVerifyCheck()){
      if(comparePassword()){
        if(emailValid == true){
          return true;
        }
        errorMessage = "Email is not valid";
      }
    }
  }
  passwordVerifyCheck(){
    if(verifyPassword.isEmpty && password.isEmpty){
      if(password.length > 6 && verifyPassword.length > 6){
        return true;
      }
      errorMessage = "Password length should be bigger than 6";
      return false;

    }
    errorMessage = "Password can not be empty";
    return false;

  }
  comparePassword(){
    if(verifyPassword.compareTo(password).toString() == "0"){
      return true;
    }
    errorMessage = "Password does not match";
    return false;
  }


signInWithGoogle(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey,{bool isLoggedIn  = true}) async {
  try {
    await _googleSignIn.signIn().then((result) {
      if(result != null){
        result.authentication.then((googleKey) async {
          print("googleKey.idToken:${googleKey.idToken}");
          // print(googleKey.serverAuthCode);
          showLoaderDialog(context, message: "logging in...");
          if (googleKey.idToken != null) {
            var fcmToken = await getGoogleCloudId();
            await userPreferences.setPushNotificationToken(fcmToken);
            var response = await _http.postRequest(AppUrl.userGoogleLogin,
                {"access_token": googleKey.idToken, "gcid": fcmToken,}
            );
            log("(response:$response");
            if (response["status"] == AppResponseCodes.success) {
              UserModel user = UserModel.fromJson(response['data']);
              await userPreferences.setUser(response['data']);
              await userPreferences.setToken(user.token!);
              await userPreferences.setRefreshToken(user.refreshToken!);

            } else{

              showOkAlertDialog(context: context,message: errorMessage,);
            }
          } else{

            showOkAlertDialog(context: context,message: isLoggedIn? "Google sign in failed, try again" : "Google sign up failed, try again" ,);
          }
        }).catchError((err) {
          print('inner error $err');
          showOkAlertDialog(context: context,message: isLoggedIn? "$err" : "$err" ,);
        });
      }else{
        showOkAlertDialog(context: context,message: isLoggedIn? "Login failed, try again" : "Sign up failed, try again" ,);
      }

    }).catchError((err, m) {
      showOkAlertDialog(context: context,message: isLoggedIn? "$err" : "$err" ,);
    });
  } catch (error) {

    showOkAlertDialog(context: context,message: isLoggedIn? "$error" : "$error" ,);
  }

}

faceBookLogin (BuildContext context,GlobalKey<ScaffoldState> scaffoldKey,{bool isLoggedIn = true}) async {
  try{
    final LoginResult result = await FacebookAuth.i.login();
    showLoaderDialog(context, message: "logging in...");
    var fcmToken = await getGoogleCloudId();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken!;
      if (_accessToken != null) {
        var response = await _http.postRequest(AppUrl.userFacebookLogin,
            {"access_token": _accessToken!.token, "gcid": fcmToken,'user_id' :  _accessToken!.userId,}
        );
        print("(response:$response");
        if (response["status"] == AppResponseCodes.success) {
          UserModel user = UserModel.fromJson(response['data']);
          await userPreferences.setUser(response['data']);
          await userPreferences.setToken(user.token!);
          await userPreferences.setRefreshToken(user.refreshToken!);

        }
        else{
          errorMessage = response["message"];
          showOkAlertDialog(context: context,message: errorMessage,);
        }
      }else{
        errorMessage = "Token not set, try again";
        showOkAlertDialog(context: context,message: errorMessage,);
      }
    } else {
      showOkAlertDialog(context: context,message: isLoggedIn? "Facebook sign in failed, try again" : "Facebook sign up failed, try again" ,);
    }
  }
  catch(e){
    showOkAlertDialog(context: context,message: isLoggedIn? "Facebook sign in failed, try again" : "Facebook sign up failed, try again" ,);

  }
}

appleLogin (BuildContext context,GlobalKey<ScaffoldState> scaffoldKey,{bool isLoggedIn  = true}) async {
  var redirectURL = "https://apidev.showout.studio/auth/callbacks/apple";
  var clientID = "com.showout.web";
  try{
    final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID,
            redirectUri: Uri.parse(
                redirectURL))
    ).catchError((e) {
      print("e.toString():${e.toString()}");
      showOkAlertDialog(context: context,message: isLoggedIn? "Apple sign in failed, try again" : "Apple sign up failed, try again" ,);

    });

    print("credential authorizationCode:${credential.email}");
    showLoaderDialog(context, message: "logging in...");
    var fcmToken = await getGoogleCloudId();
    var response = await _http.postRequest(AppUrl.userAppleLogin, {
      "access_token": credential.authorizationCode,
      "email": credential.email,
      "full_name": "${credential.givenName} ${credential.familyName}",
      "gcid": fcmToken,
    });
    print("(response:$response");

    if (response["status"] == AppResponseCodes.success) {
      UserModel user = UserModel.fromJson(response['data']);
      await userPreferences.setUser(response['data']);
      await userPreferences.setToken(user.token!);
      await userPreferences.setRefreshToken(user.refreshToken!);
    }
    else{
      errorMessage = response["message"];
      showOkAlertDialog(context: context,message: errorMessage,);
    }
  }catch(e){
    print("error:${e.toString()}");
    showOkAlertDialog(context: context,message: isLoggedIn? "Apple sign in failed, try again" : "Apple sign up failed, try again" ,);
  }
}

signInWithApple() async {
  var redirectURL = "https://apidev.showout.studio/auth/callbacks/apple";
  var clientID = "com.showout.web";
  final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
          clientId: clientID,
          redirectUri: Uri.parse(
              redirectURL)));

  print("appleIdCredential:$appleIdCredential");


}
Future<void> signOut() async {
  try {
    _googleSignIn.disconnect();
  } catch (err) {
    print("error:$err");
  }
}

}