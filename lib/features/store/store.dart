import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
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
                sText("${userInstance?.businessName}",size: 20,weight: FontWeight.w600),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset("assets/images/rating.png",height: 15,width: 15,color: userInstance!.rating! > 0 ? Colors.yellow : Colors.black,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,color: userInstance!.rating! > 1 ? Colors.yellow : Colors.black,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,color: userInstance!.rating! > 2 ? Colors.yellow : Colors.black,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,color: userInstance!.rating! > 3 ? Colors.yellow : Colors.black,),
                    const SizedBox(width: 5,),
                    Image.asset("assets/images/rating.png",height: 15,width: 15,color: userInstance!.rating! > 4 ? Colors.yellow : Colors.black,),
                  ],
                ),
                const SizedBox(height: 10,),
                sText(" ${userInstance?.city},${userInstance?.address},${userInstance?.postCode}",size: 15,weight: FontWeight.w500,align: TextAlign.center,color: const Color(0XFF879EA4)),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      children:[
                        StoreWidget(
                          onTap: ()async{
                           await  context.push(Routing.updateBusinessInformationPage);
                           setState(() {

                           });

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
                            context.push(Routing.promotionsPage);
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
                          onTap: ()async{
                            await UserPreferences().logout();
                            context.pushReplacement(Routing.loginPage);

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
