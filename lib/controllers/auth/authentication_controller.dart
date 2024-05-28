
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/models/user.dart';
import 'package:urbandrop/routes.dart';

class AuthenticationController{
String email = '';
String businessName = '';
String businessType = '';
String businessDescription = '';
String businessAddress= '';
String businessCity= '';
String businessPostCode= '';
String password = '';
String verifyPassword = '';
String errorMessage = '';
bool? emailValid ;
BuildContext? context;
String? token = "";
String? gcid = "";
String pinCode = "";
String mobileNumber = "";
String mobileNumberWithoutCountryCode = "";
String mcc = "+44";
String isoCountryCodes = "GB";
int counter = 0;
AccessToken? _accessToken;
File? selfieImageFile;
String? idType;
String? idName;
String? idNumber;
String? countryName;
File? frontImageFile;
File? backImageFile;

final ImagePicker _picker = ImagePicker();

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);
final userPreferences = UserPreferences();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final HttpClientWrapper _http = HttpClientWrapper();


getGoogleCloudId()async{
   gcid = await _firebaseMessaging.getToken();
  return gcid;
}

validateAllFields(){
  if(registrationEmptyFields()){
    if(comparePassword()){
      if(passwordVerifyCheck()){
        if(emailValid == true){
          return true;
        }
        errorMessage = "Email is not valid";
      }
    }
  }
    return false;
  }
validatePinCode(){
  if(pinCode.isNotEmpty && pinCode.length > 3){
    return true;
  }
  return false;
}
registrationEmptyFields(){
    if(email.isNotEmpty && password.isNotEmpty && verifyPassword.isNotEmpty){
      return true;
    }
    errorMessage = "All fields are required";
    return false;
  }
loginEmptyFields(){
    if(email.isNotEmpty && password.isNotEmpty){
      return true;
    }
    errorMessage = "All fields are required";
    return false;
  }
validateBusinessInformation(){
  if(businessName.isNotEmpty && businessAddress.isNotEmpty && businessCity.isNotEmpty && businessPostCode.isNotEmpty && businessType.isNotEmpty){
    return true;
  }
  return false;
}

passwordVerifyCheck(){
    if(verifyPassword.isNotEmpty && password.isNotEmpty){
      if(password.length > 6 && verifyPassword.length > 6){
        return true;
      }else{
        errorMessage = "Password length should be more than 6";
      }
    }else{
      errorMessage = "Password can not be empty";
    }
    return false;
  }

comparePassword(){
    if(verifyPassword.compareTo(password).toString() == "0"){
      return true;
    }
    errorMessage = "Password does not match";
    return false;
  }

login(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey ) async {
    try {
      showLoaderDialog(context);
      if(loginEmptyFields()){
        var response = await _http.postRequest(AppUrl.userLogin, {
          "email": email,
          "password": password,
          "gcid": await getGoogleCloudId()
        });
        log("(response.body:$response");
        if (response["status"] == AppResponseCodes.success) {
          UserModel user = UserModel.fromJson(response['data']);
          await userPreferences.setUser(response['data']);
          await userPreferences.getUser();
          await userPreferences.setToken(user.token!);
          await userPreferences.setRefreshToken(user.refreshToken!);
          context.pop();
          context.push(Routing.splashScreen,extra: true);
        }
        else if(response["status"] == AppResponseCodes.verificationPending){
          print("500 plus");
          UserModel user = UserModel.fromJson(response['data']);
          await userPreferences.setUser(response['data']);
          await userPreferences.setToken(user.token!);
          await userPreferences.setRefreshToken(user.refreshToken!);
          errorMessage = response['message'];
          context.pop();
          toastMessage(response['message'], context);
          context.push(Routing.splashScreen,extra: true);
        }else{
          context.pop();
          toastMessage(response['message'], context);
        }
      }else{
        context.pop();
        toastMessage(errorMessage, context);
      }

    } catch (e) {
      print(e.toString());
      errorMessage = e.toString();
      context.pop();
      toastMessage(errorMessage, context);
    }
  }

update(BuildContext context, Map body) async {
  try {
      var response = await _http.putRequest("${AppUrl.userUpdate}/${userInstance?.id}", body);
      log("(response.body:$response");
      if (response["status"] == AppResponseCodes.success) {
        UserModel user = UserModel.fromJson(response['data']);
        await userPreferences.setUser(response['data']);
        await userPreferences.getUser();
        await userPreferences.setToken(user.token!);
        await userPreferences.setRefreshToken(user.refreshToken!);
        return true;
      }
     else{
        toastMessage(response['message'], context);
      }


  } catch (e) {
    print(e.toString());
    errorMessage = e.toString();
    toastMessage(errorMessage, context);
  }
  return false;
}

register(BuildContext context,bool isSocialMediaLoggedIn) async {
    try {
      showLoaderDialog(context);
      if(validateAllFields()){
        var response = await _http.postRequest(AppUrl.userRegister,{
          "email":email,
          "password": password,
          "gcid": await getGoogleCloudId()
        });
        print("(response:$response");
        if (response["status"] == AppResponseCodes.success) {
          UserModel user = UserModel.fromJson(response['data']);
          await userPreferences.setUser(response['data']);
          await userPreferences.getUser();
          await userPreferences.setToken(user.token!);
          await userPreferences.setRefreshToken(user.refreshToken!);
          context.pop();
          context.push(Routing.confirmOTP,extra: true);
          return;
        }
        context.pop();
        toastMessage(response["message"], context);
      }else{
        context.pop();
        toastMessage(errorMessage, context);
      }
    } catch (e) {
      context.pop();
      errorMessage = e.toString();
      toastMessage(errorMessage, context);

    }
  }

updateUser(Map data,BuildContext context,{notLoadingDialog = false}) async {
    try {
      var response = await _http.putRequest(AppUrl.userUpdate, data);
      if (response["status"] == AppResponseCodes.success) {
        UserModel user = UserModel.fromJson(response['data']);
        await userPreferences.setUser(response['data']);
        await userPreferences.setToken(user.token!);
        await userPreferences.setRefreshToken(user.refreshToken!);
        return true;
      }
      else{
        errorMessage = response["message"];
      }
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

signInWithGoogle(BuildContext context,GlobalKey<ScaffoldState> scaffoldKey,{bool isLoggedIn  = true}) async {
  try {
    showLoaderDialog(context, message: "logging in...");
    await _googleSignIn.signIn().then((result) {
      if(result != null){
        result.authentication.then((googleKey) async {
          print("googleKey.idToken:${googleKey.idToken}");
          // print(googleKey.serverAuthCode);

          if (googleKey.idToken != null) {
            var fcmToken = await getGoogleCloudId();
            await userPreferences.setPushNotificationToken(fcmToken);
            var response = await _http.postRequest(AppUrl.userGoogleLogin,
                {
                "access_token": googleKey.idToken,
                "gcid": fcmToken,
                "terms_accepted": true,
                "terms_accepted_at": DateTime.now().toString()
                }
            );
            log("(response:$response");
            if (response["status"] == AppResponseCodes.success) {
              UserModel user = UserModel.fromJson(response['data']);
              await userPreferences.setUser(response['data']);
              await userPreferences.setToken(user.token!);
              await userPreferences.setRefreshToken(user.refreshToken!);
              toastSuccessMessage(response['message'], context);
              context.pop();
              context.push(Routing.splashScreen,extra: true);
            } else{
              context.pop();
              toastMessage(response['message'].toString(), context);
            }
          } else{
            context.pop();
            toastMessage("Failed, try again", context);
          }
        }).catchError((err) {
          print('inner error $err');
          context.pop();
          toastMessage( isLoggedIn? "$err" : "$err" , context);
        });
      }else{
        context.pop();
        toastMessage( isLoggedIn? "Login failed, try again" : "Sign up failed, try again"  , context);
      }

    }).catchError((err, m) {
      print("print error:$err");
      context.pop();
      toastMessage( isLoggedIn? "$err" : "$err" , context);
    });
  } catch (error) {
    print("print error:$error");
    context.pop();
    toastMessage( isLoggedIn? "$error" : "$error" , context);
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
  var redirectURL = "https://api.urbandrop.io/callbacks/apple";
  var clientID = "io.urbandrop.merchant";
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
      toastSuccessMessage(response['message'], context);
      context.pop();
      context.push(Routing.splashScreen,extra: true);
    }
    else{
      errorMessage = response["message"];
      context.pop();
      toastMessage(errorMessage, context);
    }
  }catch(e){
    print("error:${e.toString()}");
    context.pop();
    toastMessage( isLoggedIn? "Apple sign in failed, try again" : "Apple sign up failed, try again", context);
  }
}



user({String userId = ''}) async {
  try {
    var response  = await _http.getRequest('${AppUrl.getUser}/me');
    log("response new api:$response");
    if (response["status"] == AppResponseCodes.success) {
      UserModel user = UserModel.fromJson(response['data']);
      print("refreshToken:${user.refreshToken}");
      await userPreferences.setUser(response['data']);
      await userPreferences.setToken(user.token!);
      await userPreferences.setRefreshToken(user.refreshToken!);
      userInstance = user;
      // await AuthenticationController().getUserConfig();
      return userInstance;
    }

  } catch (e) {
    print("error:${e.toString()}");

  }
  return null;
}

getUser({String userId = ''}) async {
  try {
    var response = await _http.getRequest('${AppUrl.getUser}/$userId');
    if (response["status"] == AppResponseCodes.success) {
      UserModel user = UserModel.fromJson(response['data']);
      return user;
    }

  } catch (e) {}
}

getUserConfig() async {
  try {
    var response = await _http.getRequest(AppUrl.config);
    // var response  = await _http.getRequest('${AppUrl.config}');
    if (response["status"] == AppResponseCodes.success) {
    }

  } catch (e) {}
}

Future<void> signOut() async {
  try {
    _googleSignIn.disconnect();
  } catch (err) {
    print("error:$err");
  }
}

getCountryCode()async{
  var response =  await _http.getRequest("http://ip-api.com/json");
  if(response.isNotEmpty){
    isoCountryCodes = response["countryCode"];
  }
  return isoCountryCodes;
}

verifyEmail(BuildContext context) async {
  try {
    showLoaderDialog(context);
    if(validatePinCode()){
      userInstance =  await userPreferences.getUser();
      var response = await _http.postRequest(AppUrl.userVerify, {
        "id": userInstance?.id,
        "token": pinCode
      });
      log("(response.body:$response");
      if (response["status"] == AppResponseCodes.success) {
        UserModel user = UserModel.fromJson(response['data']);
        await userPreferences.setUser(response['data']);
        await userPreferences.setToken(user.token!);
        await userPreferences.setRefreshToken(user.refreshToken!);
        pinCode = "";
        context.pop();
        toastSuccessMessage(response['message'], context);
        context.go(Routing.verifyMobilePage,extra: true);
      }
     else{
        context.pop();
        toastMessage(response['message'], context);
      }
    }else{
      context.pop();
      toastMessage(errorMessage, context);
    }

  } catch (e) {
    print(e.toString());
    errorMessage = e.toString();
    context.pop();
    toastMessage(errorMessage, context);
  }
}

verifyMobile(BuildContext context) async {
  try {
    showLoaderDialog(context);
    if(validatePinCode()){
      var response = await _http.postRequest(AppUrl.userVerifyOTP, {
        "id": "${userInstance?.id}",
        "token": pinCode
      });
      log("(response.body:$response");
      if (response["status"] == AppResponseCodes.success) {
        UserModel user = UserModel.fromJson(response['data']);
        await userPreferences.setUser(response['data']);
        await userPreferences.setToken(user.token!);
        await userPreferences.setRefreshToken(user.refreshToken!);
        context.pop();
        toastSuccessMessage(response['message'], context);
        context.go(Routing.businessInformationPage,extra: true);
      }
      else{
        context.pop();
        toastMessage(response['message'], context);
      }
    }else{
      context.pop();
      toastMessage(errorMessage, context);
    }

  } catch (e) {
    print(e.toString());
    errorMessage = e.toString();
    context.pop();
    toastMessage(errorMessage, context);
  }
}

resendEmail(BuildContext context) async {
  try {
    showLoaderDialog(context);
    userInstance =  await userPreferences.getUser();
      var response = await _http.postRequest(AppUrl.resendVerification, {"email":  userInstance?.email});
      log("(response.body:$response");
      if (response["status"] == AppResponseCodes.success) {
        context.pop();
        toastSuccessMessage(response['message'], context);
      }
     else{
        context.pop();
        toastMessage(response['message'], context);
      }

  } catch (e) {
    print(e.toString());
    errorMessage = e.toString();
    context.pop();
    toastMessage(errorMessage, context);
  }
}

resendOTP(BuildContext context) async {
  try {
    showLoaderDialog(context);
    if(mobileNumber.isNotEmpty && mobileNumberWithoutCountryCode.isNotEmpty){
     var res = await update(context,{
       "mobile_number": mobileNumberWithoutCountryCode,
       "mcc": mcc
     });
     if(res){
       var response = await _http.postRequest(AppUrl.userSendOTP, {
         "mobile": mobileNumber
       });
       log("(response.body:$response");
       if (response["status"] == AppResponseCodes.success) {
         context.pop();
         toastSuccessMessage(response['message'], context);
         context.push(Routing.confirmOTP,extra: false);
       } else{
         context.pop();
         toastMessage(response['message'], context);
       }
     }else{
       context.pop();
       toastMessage("Failed try again", context);
     }
     }else{
      context.pop();
      toastMessage("Mobile number is required", context);
    }
  } catch (e) {
    print(e.toString());
    errorMessage = e.toString();
    context.pop();
    toastMessage(errorMessage, context);
  }
}

attachFils() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    // User canceled the picker
    return null;
  }

}

attachCamera() async {
  List<Media>? res = await ImagesPicker.openCamera(
    pickType: PickType.image,
  );
  return res != null ? File(res.first.path) : null;
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  File? imageFile;
  if(photo != null){
    imageFile  = File(photo.path);
  }
  return imageFile;
}

signUpKYC(BuildContext context,) async {
  try{
    showLoaderDialog(context);
    var headers = {
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer ${await userPreferences.getUserToken()}',
      'x-api-key':MERCHANT_API_KEY
    };
    var request = http.MultipartRequest('post', Uri.parse(AppUrl.verifyUserDocs));
    Map <String,String> body = {

    };
    print("body: $body");
    request.fields.addAll(body);
    request.headers.addAll(headers);
    if(selfieImageFile != null){
      var ext = selfieImageFile!.path.split('.').last;
      request.files.add(
        http.MultipartFile("selfie", File(selfieImageFile!.path).readAsBytes().asStream(), File( selfieImageFile!.path).lengthSync(),
            filename: selfieImageFile!.path.split("/").last, contentType: MediaType('image', ext)),
      );
    }
    if(frontImageFile != null){
      var ext = frontImageFile!.path.split('.').last;
      request.files.add(
        http.MultipartFile("document_front", File(frontImageFile!.path).readAsBytes().asStream(), File( frontImageFile!.path).lengthSync(),
            filename: frontImageFile!.path.split("/").last, contentType: MediaType('image', ext)),
      );
    }
    if(backImageFile != null){
      var ext = backImageFile!.path.split('.').last;
      request.files.add(
        http.MultipartFile("document_back", File(backImageFile!.path).readAsBytes().asStream(), File( backImageFile!.path).lengthSync(),
            filename: backImageFile!.path.split("/").last, contentType: MediaType('image', ext)),
      );
    }
    print("request: ${request.fields}");
    var res = await request.send();
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print('responseString: ' + responseString);
    Map responseMap = json.decode(responseString);
    print('responseMap: ' + responseMap.toString());
    if(responseMap["status"] == AppResponseCodes.success && responseMap["data"].isNotEmpty){
      // UserModel user = UserModel.fromJson(responseMap['data']);
      // await userPreferences.setUser(responseMap['data']);
      // await userPreferences.setToken(user.token!);
      // await userPreferences.setRefreshToken(user.refreshToken!);
      errorMessage = "${responseMap["message"]}";
     context.pop();
     return true;
    }
    else  if(responseMap["status"] == AppResponseCodes.invalidToken){
      var body = {
        "id": userInstance!.id,
        "refresh_token" : await userPreferences.getUserRefreshToken()
      };
      var res = await _http.postRequest(AppUrl.refreshToken, body);
      print("res object:$res");
      if(res["status"] == AppResponseCodes.success){
        UserModel user = UserModel.fromJson(res['data']);
        await userPreferences.setUser(responseMap['data']);
        await userPreferences.setToken(user.token!);
        await userPreferences.setRefreshToken(user.refreshToken!);
        context.pop();
        errorMessage = "${res["message"]}";
        toastMessage( errorMessage,context);
      }else{
        context.pop();
        errorMessage = "${res["message"]}";
        toastMessage( errorMessage,context);
        return false;
      }
    }
    else{
      errorMessage = "${responseMap["message"]}";
      context.pop();
      toastMessage(errorMessage,context);
      return false;
    }
  }catch(e){
    print("object:${ e.toString()}");
    context.pop();
    toastMessage(e.toString(),context);
    return false;
  }
}
}