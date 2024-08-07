import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';
import 'package:urbandrop/features/widget/store_widget.dart';
import 'package:urbandrop/routes.dart';

class NotificationSettingTypesPage extends StatefulWidget {
  const NotificationSettingTypesPage({super.key});

  @override
  State<NotificationSettingTypesPage> createState() => _NotificationSettingTypesPageState();
}

class _NotificationSettingTypesPageState extends State<NotificationSettingTypesPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Notifications",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                  children:[
                    StoreWidget(
                      image: "new_order.png",
                      content: "New orders",
                      onTap: ()async{
                        userInstance?.notifications?.orders = !userInstance!.notifications!.orders!;
                        setState(() {});
                        await AuthenticationController().update(context,{
                          "notifications":userInstance?.notifications!.toJson()
                        });
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.orders = val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance!.notifications!.orders!,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "support.png",
                      content: "Customer inquiry ",
                      onTap: ()async{
                        userInstance?.notifications?.inquiry = !userInstance!.notifications!.inquiry!;
                        setState(() {});
                        await AuthenticationController().update(context,{
                          "notifications":userInstance?.notifications!.toJson()
                        });
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.inquiry = val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance!.notifications!.inquiry!,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "completed.png",
                      content: "Order completion confirmation ",
                      onTap: ()async{
                        userInstance?.notifications?.order_complete = !userInstance!.notifications!.order_complete!;
                        setState(() {});
                        await AuthenticationController().update(context,{
                          "notifications":userInstance?.notifications!.toJson()
                        });
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.order_complete = val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance!.notifications!.order_complete!,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "security.png",
                      content: "Security alerts",
                      onTap: ()async{
                        userInstance?.notifications?.security = !userInstance!.notifications!.security!;
                        setState(() {});
                        await AuthenticationController().update(context,{
                          "notifications":userInstance?.notifications!.toJson()
                        });
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.security = val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance!.notifications!.security!,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "inven.png",
                      content: "Low inventory alerts",
                      onTap: ()async{
                        userInstance?.notifications?.inventory = !userInstance!.notifications!.inventory!;
                        setState(() {});
                        await AuthenticationController().update(context,{
                          "notifications":userInstance?.notifications!.toJson()
                        });
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.inventory = val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance!.notifications!.inventory!
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
