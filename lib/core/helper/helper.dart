import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as log;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/notifications/notification_controller.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/models/user.dart';
import 'package:url_launcher/url_launcher.dart';




final deviceType = getDeviceType();
final rootNavigatorKey = GlobalKey<NavigatorState>();
UserModel? userInstance;
AuthenticationController authenticationController = AuthenticationController();
enum DeviceType { Phone, Tablet }

DeviceType getDeviceType() {
  final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
  return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
}

formattedAmount({amount = "0"}){
  return MoneyFormatter(amount: double.parse(amount ?? "0")).output.nonSymbol.toString();
}
checkOutStock({String? stock = "0"}){
  return stock == null || stock == "0" ? true : false;
}


List<BoxShadow> elevation({required Color color, required int elevation}) {
  return [
    BoxShadow(
        color: color.withOpacity(0.6),
        offset: const Offset(0.0, 4.0),
        blurRadius: 3.0 * elevation,
        spreadRadius: -1.0 * elevation),
    BoxShadow(
        color: color.withOpacity(0.44),
        offset: const Offset(0.0, 1.0),
        blurRadius: 2.2 * elevation,
        spreadRadius: 1.5),
    BoxShadow(
        color: color.withOpacity(0.12),
        offset: const Offset(0.0, 1.0),
        blurRadius: 4.6 * elevation,
        spreadRadius: 0.0),
  ];
}



displayImage(imagePath, {double radius = 30.0, double? height, double? width, bool isFrom = false}) {

  return CachedNetworkImage(
      imageUrl: "${imagePath}",
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0
            ? Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: 2* radius ,
          height: 2* radius ,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26
          ),

        )
            : Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: radius ,
          height: radius ,
          decoration: const BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.black26
          ),

        );
      },
      errorWidget: (context, url, error) {
        return radius > 0
            ? Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
                width: radius * 2,
                height: radius * 2,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26
                ),
                // child:const Image(
                //   image: AssetImage('assets/images/logo.png'),
                // ) ,
              )
            : const Image(
                image: AssetImage('assets/images/logo.png'),
              );
      },
      imageBuilder: (context, image) {
        return radius > 0
            ? CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                radius: radius,
              )
            : Image(
                image: image,
                fit: BoxFit.cover,
              );
      });
}
displayImage3(imagePath, {double radius = 30.0, double? height, double? width,}) {
 // print("imagePath3:$imagePath");
  return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0
            ? Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: 2* radius ,
          height: 2* radius ,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26
          ),

        )
            : Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: radius ,
          height: radius ,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26
          ),

        );
      },
      errorWidget: (context, url, error) {
        return radius > 0
            ? Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
                width: radius * 2,
                height: radius * 2,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26
                ),
                // child:const Image(
                //   image: AssetImage('assets/images/logo.png'),
                // ) ,
              )
            : const Image(
                image: AssetImage('assets/images/logo.png'),
              );
      },
      imageBuilder: (context, image) {
        return radius > 0
            ? CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                radius: radius,
              )
            : Image(
                image: image,
                fit: BoxFit.cover,
              );
      });
}
displayProfileImage(imagePath, {double radius = 30.0, double? height, double? width}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0
            ? Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: 2* radius,
          height: 2* radius,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300]
          ),
          child:const Image(
            image: AssetImage('assets/images/profile_icon.png'),
          ) ,
        )
            : const Image(
                image: AssetImage('assets/images/profile_icon.png'),
              );
      },
      errorWidget: (context, url, error) {
        return radius > 0
            ? Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
                width: 2* radius,
                height: 2* radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                    color: Colors.grey[300]
                ),
                child:const Image(
                  image: AssetImage('assets/images/profile_icon.png'),
                ) ,
              )
            : const Image(
                image: AssetImage('assets/images/profile_icon.png'),
              );
      },
      imageBuilder: (context, image) {
        return radius > 0
            ? CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: image,
          radius: radius,
        )
            : Image(
                image: image,
                fit: BoxFit.cover,
              );
      });
}
displayBannerImage(imagePath, {double radius = 30.0, double? height, double? width}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0
            ? Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26
          ),
          child:const Image(
            image: AssetImage('assets/images/profile_banner.png'),
            fit: BoxFit.fill,
          ) ,
        )
            : const Image(
                image: AssetImage('assets/images/profile_banner.png'),
          fit: BoxFit.fill,
              );
      },
      errorWidget: (context, url, error) {
        return radius > 0
            ? Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child:const Image(
                  image: AssetImage('assets/images/profile_banner.png'),
                  fit: BoxFit.fill,
                ) ,
              )
            : const Image(
                image: AssetImage('assets/images/profile_banner.png'),
                fit: BoxFit.fill,
              );
      },
      imageBuilder: (context, image) {
        return radius > 0
            ? CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                radius: radius,
              )
            : Image(
                image: image,
                fit: BoxFit.cover,
              );
      });
}
displayImage2(imagePath, {double radius = 30.0, double? height, double? width}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0
            ? Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300]
          ),
          child:const Image(
            image: AssetImage('assets/images/logo.png'),
          ) ,
        )
            : const Image(
                image: AssetImage('assets/images/logo.png'),
              );
      },
      errorWidget: (context, url, error) {
        return radius > 0
            ? Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 5),
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child:const Image(
                  image: AssetImage('assets/images/logo.png'),
                ) ,
              )
            : const Image(
                image: AssetImage('assets/images/logo.png'),
              );
      },
      imageBuilder: (context, image) {
        return radius > 0
            ? CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                radius: 8,
              )
            : Image(
                image: image,
                fit: BoxFit.cover,
              );
      });
}

Widget displaySQImage(imagePath,
    {double radius = 30.0, double height = 0, double width = 0}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: Clip.hardEdge,
          child: Container(
            color: solonGray200,
            width: width,
            height: height,
          ),
        );
      },
      errorWidget: (context, url, error) => ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: solonGray200,
              width: height,
              height: height,
            ),
          ),
      imageBuilder: (context, image) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image(
              image: image,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ));
      });
}

Widget displayCircularImage(imagePath, {double radius = 30.0}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) {
        return CircleAvatar(
          backgroundColor: solonGray200,
          radius: radius,
        );
      },
      imageBuilder: (context, image) {
        return CircleAvatar(
          backgroundImage: image,
          radius: radius,
        );
      });
}

Widget displayLocalImage(String filePath,
    {double radius = 30.0, double? height, double? width}) {
  File file = new File(filePath);
  return radius > 20
      ? CircleAvatar(
          backgroundColor: solonGray200,
          backgroundImage: (
              filePath.isEmpty
              ? const AssetImage('assets/images/user_placeholder.png')
              : FileImage(file)) as ImageProvider<Object>?,
          radius: radius,
        )
      : Image(
          fit: BoxFit.fitWidth,
          height: height,
          width: width,
          image: (filePath.isEmpty
              ? const AssetImage('assets/images/user_placeholder.png')
              :  AssetImage(filePath)
          ) as ImageProvider<Object>,
        );
}

Widget displayLocalImageDevice(String filePath,
    {double radius = 30.0, double? height, double? width}) {
  File file =  File(filePath,);
  return radius > 0
      ?   CircleAvatar(
    backgroundColor: solonGray200,
    backgroundImage: (
        filePath.isEmpty
            ? const AssetImage('images/user_placeholder.png')
            : FileImage(file)) as ImageProvider<Object>?,
    radius: radius,
  )
      :
  Image(
    fit: BoxFit.fitHeight,
    height: height,
    width: width,
    image: (filePath.isEmpty
        ? const AssetImage('images/user_placeholder.png')
        : FileImage(file)) as ImageProvider<Object>,
  );
  Image(
    fit: BoxFit.fitWidth,
    height: height,
    width: width,
    image: (filePath.isEmpty
        ? const AssetImage('assets/images/ads.png')
        : FileImage(file,)) as ImageProvider<Object>,
  );
}
Widget progress({double size = 20,double radius = 10,Color color = appMainColor}) {
  return SizedBox(
      width: size,
      height: size,
      child:  const CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation<Color>(primaryColor,)
      ));
}
Widget progressCircular({double size = 20,double radius = 10,Color color = appMainColor}) {
  return SizedBox(
      width: size,
      height: size,
      child: CupertinoActivityIndicator(
        radius: radius,
        animating: true,
        color: color,
      ));

}

Widget sText(String? word,
    {double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = Colors.black,
    TextAlign align = TextAlign.left,
    int maxLines = 5,
    double? lHeight = 1.2,
    double? decorationThickness = 1,
    String family = 'Red Hat Display',
    FontStyle style = FontStyle.normal,
    TextDecoration textDecoration = TextDecoration.none,
    int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,


    style: TextStyle(
      decoration: textDecoration,
      decorationThickness:decorationThickness ,
      height: lHeight,
      fontStyle: style,
      color: color,
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      shadows:
          shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

Widget sText2(String? word,
    {double size = 15,
    FontWeight weight = FontWeight.w400,
    Color color = solonGray700,
    TextAlign align = TextAlign.left,
    int maxLines = 5,
    double? lHeight = 1.2,
    String family = 'ProximaRegular',
    int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
    style: TextStyle(
      height: lHeight,
      color: color,
      fontFamily: 'ProximaRegular',
      fontSize: size,
      fontWeight: weight,
      shadows:
          shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

Widget outlineButton({
  required Widget content,
  required Function onPressed,
  textColor= Colors.white,
  double z= 16,
  double radius= 5,
  int shadowStrength= 1,
  double borderWidth= 1,
  double height= 60,
  double width= double.infinity,
  EdgeInsetsGeometry? padding,
  Color outlineColor= const Color(0xFF183A37),
  Color backgroundColor= Colors.white,
  String family = 'Red Hat Display',
}) {
  return Container(
    height: height,
    width: width,
    decoration: shadowStrength > 0
        ? BoxDecoration(
            boxShadow:
                elevation(color: solonGray200, elevation: shadowStrength),
            borderRadius: BorderRadius.circular(radius))
        : BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: outlineColor, width: borderWidth)),
      ),
      onPressed: () => onPressed(),
      child: content,
    ),
  );
}

Widget mainButton({
  required Widget content,
  required Function onPressed,
  textColor= Colors.white,
  double z= 16,
  double radius= 5,
  int shadowStrength= 1,
  double borderWidth= 1,
  double height= 60,
  double width= double.infinity,
  EdgeInsetsGeometry? padding,
  Color outlineColor= const Color(0xFFf2f2f2),
  Color backgroundColor= Colors.white,
  String family = 'Red Hat Display',
}) {
  return Container(
    height: height,
    width: width,
    decoration: shadowStrength > 0
        ? BoxDecoration(
        boxShadow:
        elevation(color: solonGray200, elevation: shadowStrength),
        borderRadius: BorderRadius.circular(radius))
        : BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: outlineColor, width: borderWidth)),
      ),
      onPressed: () => onPressed(),
      child: content,
    ),
  );
}

Widget dPurpleGradientButton(
    {required Widget content,
    required Function onPressed,
    double radius= 5,
    double height= 50,
    EdgeInsetsGeometry? padding,
    List<Color> colors= const [dPurpleGradientLeft, dPurpleGradientRight],
    gradientDirection= 'left_right'}) {
  return SizedBox(
    height: height,
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientDirection == 'left_right'
                ? Alignment.centerLeft
                : Alignment.topCenter,
            end: gradientDirection == 'left_right'
                ? Alignment.centerRight
                : Alignment.bottomCenter,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(radius)),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//          backgroundColor: col,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        onPressed: () => onPressed(),
        child: content,
      ),
    ),
  );
}

Future goTo(BuildContext context, Widget target,
    {bool replace = false,
    PageTransitionType anim = PageTransitionType.size,
    int millis = 200,
    bool opaque = true}) {
  if (!opaque) {
    if (!replace) {
      return Navigator.of(context).push(PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
              target,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          }));
    } else {
      return Navigator.of(context).pushReplacement(PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
              target,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          }));
    }
  }
  if (!replace) {
    return Navigator.push(
        context,
        PageTransition(
            type: anim,
            duration: Duration(milliseconds: millis),
            alignment: Alignment.bottomCenter,
            child: target));
  } else
    return Navigator.pushReplacement(
        context,
        PageTransition(
            type: anim,
            duration: Duration(milliseconds: millis),
            alignment: Alignment.bottomCenter,
            child: target));
}

TextStyle appStyle(
    {double size = 16,
    Color? col =  Colors.black,
    FontWeight weight = FontWeight.w400,
      double? decorationThickness = 1,
      String family = 'Proxima',
      FontStyle style = FontStyle.normal,
      TextDecoration textDecoration = TextDecoration.none,
    }) {
  return TextStyle(
      fontFamily: family, fontWeight: weight, fontSize: size, color: col,decoration: textDecoration,decorationThickness: decorationThickness);
}

EdgeInsets noPadding() {
  return EdgeInsets.zero;
}

EdgeInsets appPadding(double size) {
  return EdgeInsets.all(size);
}
InputDecoration textDecorSuffix({Color fillColor = Colors.white,String? hint, Icon? icon, Icon? suffIcon,Color? suffIconColor, String prefix = '', String suffix = '', bool enabled = true, Color hintColor = Colors.grey, double hintSize = 16, bool showBorder = true, String label = '', double size = 40,double top = 12.0,double radius = 0}) {
  return new InputDecoration(
    suffixIcon:  Container(
      child: suffIcon,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size)
      ),
    ),
    prefixIcon: icon,
    prefixText: prefix,
    suffixText: suffix,
    hintText: hint,
    hintStyle: appStyle(size: hintSize, col: hintColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.1), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(size)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.1), width: 1),
      borderRadius:  BorderRadius.all(Radius.circular(size)),
    ),
    labelStyle: appStyle(size: hintSize, col: hintColor),
    labelText: label,
    filled: true,
    fillColor: fillColor,
    contentPadding: EdgeInsets.fromLTRB(20.0, top, 10.0, 12.0),
  );
}

InputDecoration textDecor(
    {String hint = '',
    Widget? icon,
    String prefix = '',
    Widget? suffix,
    Widget? suffixIcon,
    bool enabled = true,
    Color? hintColor = solonGray500,
    double hintSize = 16,
    bool showBorder = true,
    double radius = 4,
    String label = '',
    EdgeInsetsGeometry padding =
        const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0)}) {
  return new InputDecoration(
    prefixIcon: icon,
    prefixText: prefix,
    suffix: suffix,
    suffixIcon: suffixIcon,
    hintText: hint,
    alignLabelWithHint: true,
    isDense: true,

    floatingLabelBehavior: (label.isNotEmpty && hint.isNotEmpty)
        ? FloatingLabelBehavior.never
        : FloatingLabelBehavior.auto,
    hintStyle: appStyle(size: hintSize, col: hintColor),
//    border: UnderlineInputBorder(
//      borderSide: BorderSide(color: theColor),
//    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    labelText: label,
    labelStyle: appStyle(size: hintSize, col: hintColor),
//    filled: true,
//    fillColor: Colors.white,
    contentPadding: padding,
  );
}

InputDecoration textDecorNoBorder(
    {String? hint,
    String prefix = '',
    Widget? suffix,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    double hintSize = 16,
    Color? hintColor,
    String labelText = '',
    String family = "Poppins",
    FontWeight hintWeight= FontWeight.normal,
    Color? fill,
    Color borderColor = Colors.black,
    double radius = 4,
    EdgeInsetsGeometry padding =
        const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0)}) {
  return new InputDecoration(
    prefixText: prefix,
    suffix: suffix,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintText: hint,
    labelText: labelText,
    hintStyle: appStyle(
      size: hintSize,
      col: hintColor,
      weight: hintWeight,
      family: family,
    ),
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusColor: dPurple,
    enabled: enabled,
    labelStyle: appStyle(size: hintSize, col: hintColor),
    filled: true,
    fillColor: fill,
    contentPadding: padding,
  );
}

showDialogOk(
    {String? message,
    String? title = "Alert",
    BuildContext? context,
    Widget? target,
    bool? status = false,
    bool replace = false,
    bool dismiss = true}) {
  // flutter defined function
  showDialog(
    context: context!,
    barrierDismissible: dismiss,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("$title"),
        content: new Text(message!),
        actions: <Widget>[
          new MaterialButton(
            elevation: 0,
            child: const Text("Ok"),
            onPressed: () {
              if (status!) {
                Navigator.pop(context);
                goTo(context, target!, replace: replace);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}

showSuccessfulDialog(
    {String? message, BuildContext? context, Widget? target, bool? status}) {
  // flutter defined function
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: const Text("Alert"),
        content: new Text(message!),
        actions: <Widget>[
          new MaterialButton(
            elevation: 0,
            child: const Text("Ok"),
            onPressed: () {
              if (status!) {
                Navigator.pop(context);
                goTo(context, target!, replace: false);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}



appWidth(context) {
  return MediaQuery.of(context).size.width;
}

appHeight(context) {
  return MediaQuery.of(context).size.height;
}

List<BoxShadow> appShadow(
    Color col, double offset, double blur, double spread) {
  return [
    BoxShadow(
        blurRadius: blur,
        color: col,
        offset: const Offset(0, 2.0),
        spreadRadius: spread),
  ];
}

Future<bool> clearPrefs() async {
  var sp = await SharedPreferences.getInstance();
  sp.clear();
  return true;
}
getInDays(DateTime timestamp){
  double days = timestamp.difference(DateTime.now()).inHours/24;

  if(days.round() == 0){
    return "Today";
  }else if(days.round() == 1){
    return "Tomorrow";
  }else if(days.round() == 2){
    return "In 2days";
  }else if(days.round() == 3){
    return "In 3days";
  }else if(days.round() == 4){
    return "In 4days";
  }else{
    return DateFormat.yMMMEd().format(timestamp);
  }



}

Future<bool> setPref(key, value, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  print("Setting $type pref $key to $value...");
  switch (type) {
    case 'string':
      sp.setString(key, value);
      break;
    case 'bool':
      sp.setBool(key, value);
      break;
    case 'int':
      sp.setInt(key, value);
      break;
    case 'list':
      List<String> ls = value;
      sp.setStringList(key, ls);
      break;
  }
  return true;
}

Future<dynamic> getPref(key, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  switch (type) {
    case 'string':
      return sp.getString(key);
      break;
    case 'bool':
      return sp.getBool(key);
      break;
    case 'list':
      List<String> aList = [];
      List<String>? data = sp.getStringList(key);
      if (data != null) {
        aList = data;
        return aList;
      } else {
        return aList;
      }
      break;
  }
}

EdgeInsets topPadding(double size) {
  return EdgeInsets.only(top: size);
}

EdgeInsets bottomPadding(double size) {
  return EdgeInsets.only(bottom: size);
}

EdgeInsets leftPadding(double size) {
  return EdgeInsets.only(left: size);
}

EdgeInsets rightPadding(double size) {
  return EdgeInsets.only(right: size);
}

EdgeInsets horizontalPadding(double size) {
  return EdgeInsets.symmetric(horizontal: size);
}

EdgeInsets verticalPadding(double size) {
  return EdgeInsets.symmetric(vertical: size);
}

properCase(String txt) {
  return txt.titleCase;
}

capCase(String txt) {
  return txt.toUpperCase();
}

sentenceCase(String txt) {
  if (txt.isEmpty) return txt;
  return txt.sentenceCase;
}

// toastMessage(String text, {bool long = true}) {
//   Fluttertoast.showToast(
//       msg: text,
//       toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
//       backgroundColor: dDarkText,
//       textColor: Colors.white);
// }
noInternetConnection(String message) {
 return  Container(
   width: double.infinity,
   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
   margin: const EdgeInsets.symmetric(horizontal: 0),
   decoration: BoxDecoration(
       color: Colors.black, borderRadius: BorderRadius.circular(0)),
   child:  Center(
       child: Text(
         message,
         style: const TextStyle(color: Colors.white),
       )),
 );
}
toastMessage(String message,BuildContext context,) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child
                  : Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.red.shade200),
        ),
        showCloseIcon: true,
        dismissDirection: DismissDirection.down,
        duration: const Duration(seconds: 10),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20)
    ),
  );
}
toastSuccessMessage(String message,BuildContext context,) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child
                  : Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: primaryColor),
        ),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        dismissDirection: DismissDirection.down,
        duration: const Duration(seconds: 10),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20)
    ),
  );
}

Map replaceNulls(Map m) {
  for (var i in m.keys) {
    if (m[i] is String) {
      if (m[i] == "null") {
        m[i] = '';
      }
    } else if (m[i] == Null) {
      m[i] = '';
    } else {
      m[i] = jsonEncode(m[i]);
    }
  }
  return m;
}
String dateFormat(DateTime timestamp) {
  return DateFormat.yMMMMEEEEd().format(timestamp);
}
bool appIsEmpty(value) {
  return value.toString() == '' || value == null || value == 'null';
}

Map stripNulls(dynamic v) {
  Map m = v.toMap();
  Map<String, String> finalMap = v.toMap();
  for (var i in m.keys) {
    if (m[i] == "null") {
      finalMap.remove(i);
    }
  }
  return finalMap;
}

navigateTo(BuildContext context, Widget target,
    {bool replace = false,
    PageTransitionType anim = PageTransitionType.fade,
    int millis = 300,
    bool opaque = false}) {
  if (!replace) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
            target,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        }));
  } else
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.size,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
            child: target));
}

extension StringExtensions on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    if (diffInHours < 0) {
      diffInHours = diffInHours * -1;
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = 'min';
      } else if (diffInHours < 24) {
        timeValue = diffInHours;
        timeUnit = 'hr';
      } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
        timeValue = (diffInHours / 24).floor();
        timeUnit = 'd';
      } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
        timeValue = (diffInHours / (24 * 7)).floor();
        timeUnit = 'wk';
      } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
        timeValue = (diffInHours / (24 * 30)).floor();
        timeUnit = 'mth';
      } else {
        timeValue = (diffInHours / (24 * 365)).floor();
        timeUnit = 'yr';
      }
      timeAgo = timeValue.toString() + ' ' + timeUnit;
      timeAgo += timeValue > 1 ? 's' : '';

      return 'in ' + timeAgo;
    } else {
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = 'min';
      } else if (diffInHours < 24) {
        timeValue = diffInHours;
        timeUnit = 'hr';
      } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
        timeValue = (diffInHours / 24).floor();
        timeUnit = 'd';
      } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
        timeValue = (diffInHours / (24 * 7)).floor();
        timeUnit = 'wk';
      } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
        timeValue = (diffInHours / (24 * 30)).floor();
        timeUnit = 'mth';
      } else {
        timeValue = (diffInHours / (24 * 365)).floor();
        timeUnit = 'yr';
      }
      timeAgo = timeValue.toString() + '' + timeUnit;
      timeAgo += timeValue > 1 ? 's' : '';

      return "$timeAgo ago";
    }
  }
}

customerCare() async {
  var whatsappURl_android = "https://wa.me/233205177416?text=";
  var whatappURL_ios = Uri.parse("https://wa.me/send?phone=233205177416&text=");
  var whatappURL_caller = Uri.parse("tel://233205177416");
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(whatappURL_ios)) {
      await launchUrl(whatappURL_ios);
    } else {
      launchUrl(whatappURL_caller);
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      launchUrl(whatappURL_caller);
    }
  }
}

generateRandom() {
  var rng = Random();
  var code = rng.nextInt(900000) + 100000;

  return code;
}

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

getOutDays(DateTime timestamp){
  double days = DateTime.now().difference(timestamp).inHours/24;

  if(days.round() == 0){
    return "Today";
  }else if(days.round() == 1){
    return "Yesterday";
  }else if(days.round() == 2){
    return "2 days ago";
  }else if(days.round() == 3){
    return "3 days ago";
  }else{
    return " ${DateFormat("d MMM").format(timestamp)}";
  }

}

class ListNames {
  String name;
  String desc;
  String image;
  String id;
  bool enable;
  ListNames({this.name = '', this.id = '',this.enable = false, this.desc = '', this.image = ''});
}

enum NotificationViewType { foreground, background }

showLoaderDialog(BuildContext context, {String? message = "loading...", bool barrierDismissible = true}) {
  AlertDialog alert = AlertDialog(
    content:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        progress(),
        const SizedBox(width: 10,),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(
              message!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


Future<void> urlLauncher(String _url) async {
  if (!await launchUrl(Uri.parse(_url))) {
    throw 'Could not launch $_url';
  }
}

enum CardType {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}



getAssetFormattedAmount(double sums){
  print("double: $sums ${sums.toStringAsFixed(2).length}");
  if(sums < 0 ? sums.toStringAsFixed(2).toString().length > 10 : sums.toStringAsFixed(2).toString().length > 9) {
    return '${(sums/1000000).toStringAsFixed(2)}m';
  }else if(sums < 0 ? sums.toStringAsFixed(2).toString().length > 7 : sums.toStringAsFixed(2).toString().length > 6){
    return '${(sums/1000).toStringAsFixed(2)}k';
  }else{
    return (sums.abs()).toStringAsFixed(2);
  }
}

countFormat(int sums){
  print("double: $sums ${sums.toStringAsFixed(2).length}");
  if(sums < 0 ? sums.toStringAsFixed(2).toString().length > 10 : sums.toStringAsFixed(2).toString().length > 9) {
    return '${(sums/1000000).toStringAsFixed(0)}m';
  }else if(sums < 0 ? sums.toStringAsFixed(2).toString().length > 7 : sums.toStringAsFixed(2).toString().length > 6){
    return '${(sums/1000).toStringAsFixed(0)}k';
  }else{
    return (sums.abs()).toStringAsFixed(0);
  }
}


generateRandomdigit(){
  var rng = new Random();
  var rand = rng.nextInt(900000000) + 100000000;
  print("$rand${DateTime.now().microsecondsSinceEpoch}");
  return "$rand${DateTime.now().microsecondsSinceEpoch}";
}

isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;


class CardStatus {
  static const String  pending = "pending approval";
  static const String  active = "active";
  static const String  lock = "lock";
  static const String  disabled = "disabled";

}

openWebview(String url)async{
  print("url:$url");
  if (await canLaunchUrl(Uri.parse(url))){
  await launchUrl(Uri.parse(url),mode:  LaunchMode.inAppWebView,);
  }else{
  throw "Could not launch $url";
  }
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("background message:${message.data}");
  if(message.data.isNotEmpty){
    instantNotification(message.notification!.body!,message.notification!.title!,jsonEncode(message.data),);
  }

}

dateConversion(Timestamp timestamp) {
  final String preConverted = timestamp.toString();
  final int seconds = int.parse(preConverted.substring(18, 28)); // 1621176915
  final int nanoseconds = int.parse(
      preConverted.substring(42, preConverted.lastIndexOf(')'))); // 276147000
  Timestamp postConverted = Timestamp(seconds, nanoseconds);
  return "${postConverted.toDate()}";
}
 String timeFormat(DateTime date) {
return DateFormat("HH:mm").format(date);
// return DateFormat.d().add_yMMM().format(date);
}


String getRandomGeneratedId() {
  const int AUTO_ID_LENGTH = 20;
  const String AUTO_ID_ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  const int maxRandom = AUTO_ID_ALPHABET.length;
  final Random randomGen = Random();

  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < AUTO_ID_LENGTH; i++) {
    buffer.write(AUTO_ID_ALPHABET[randomGen.nextInt(maxRandom)]);
  }

  return buffer.toString();
}

String formatFullDate(String? dateText) {
  dateText = dateText == "null" ? "" : dateText;
  try {
    final date = DateTime.parse(dateText.toString());
    return DateFormat("dd/MM/yyyy").format(date);
  } catch (ex) {
    return dateText.toString();
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask; // = '0-0-0-0-0-0';
  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length && mask[newValue.text.length - 1] == '-') {
          return TextEditingValue(

            text: '${oldValue.text}-${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

String formatDateTime(DateTime dateTime) {
  final day = DateFormat('d').format(dateTime);
  final suffix = getDaySuffix(int.parse(day));
  final formattedDate = DateFormat('d\'$suffix\' MMM. yyyy; h:mm a').format(dateTime);
  return formattedDate;
}
DateTime? selectedDate;
dateCalendar(BuildContext context, String orderStatus)async{
  final state = Get.put(OrdersController());
  final dateSelected =
  await showCalendarDatePicker2Dialog(
    value: [selectedDate ?? DateTime.now()],
    context: context,
    config:
    CalendarDatePicker2WithActionButtonsConfig(
        currentDate: selectedDate,
        calendarType:
        CalendarDatePicker2Type.single),
    dialogSize: const Size(325, 400),
    // value: _dates,
    borderRadius: BorderRadius.circular(15),
  );
  if (dateSelected != null) {
      if (dateSelected.isNotEmpty) {
        selectedDate = dateSelected.first;
        state.filterOrders(orderStatus,selectedDate != null ? dateFormat(selectedDate!) : "");
      }
  }

}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

