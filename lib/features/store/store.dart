import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/social_login_widgets.dart';
import 'package:urbandrop/features/widget/store_widget.dart';
import 'package:urbandrop/routes.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            width: appWidth(context),
            height: 200,
            color: primaryColor,
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 120),
            child:Column(
              children: [
                Image.asset("assets/images/store.png",height: 166,width: 166,),
                const SizedBox(height: 10,),
                sText("Super Store",size: 20,weight: FontWeight.w600),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/rating.png",height: 15,width: 15,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,),
                  ],
                ),
                const SizedBox(height: 10,),
                sText("123 Food Street, City. C45 9PL",size: 15,weight: FontWeight.w500,align: TextAlign.center,color: const Color(0XFF879EA4)),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      children:[
                        StoreWidget(
                          onTap: (){
                            context.push(Routing.updateBusinessInformationPage);

                          },
                        ),
                        const SizedBox(height: 20,),
                        StoreWidget(
                          image: "time.png",
                          content: "Opening & closing times ",
                          onTap: (){
                            context.push(Routing.schedulePage);
                          },
                        ),
                        const SizedBox(height: 20,),
                        StoreWidget(
                          content: "Payment information",
                          image: "payment.png",
                          onTap: (){
                            context.push(Routing.paymentInformation);

                          },
                        ),
                        const SizedBox(height: 20,),
                        StoreWidget(
                          image: "promo.png",
                          content: "Promotions",
                          onTap: (){

                          },
                        ),
                        const SizedBox(height: 20,),
                        StoreWidget(
                          content: "Settings",
                          image: "settings.png",
                          onTap: (){
                            context.push(Routing.settingsPage);
                          },
                        ),
                        const SizedBox(height: 20,),
                        StoreWidget(
                          content: "Log out",
                          image: "logout.png"
                              "",
                          onTap: (){

                          },
                        ),
                        const SizedBox(height: 20,),
                      ]
                  ),
                )
              ],
            ),

          ),


        ],
      ),
    );
  }
}
