import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      context.go(Routing.onBoarding);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: primaryColor,
      child:  Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/images/splash_logo.png",color: Colors.white,height: 300,),
          Container(
            margin: EdgeInsets.only(top: 220),
              child:  sText("Merchant",weight: FontWeight.w900,size: 30,color: Colors.white)
          )
        ],
      ),
    );
  }
}
