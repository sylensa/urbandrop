import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                      content: "New orders ",
                      onTap: (){
                        context.push(Routing.resetPassword);
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) {
                        },
                        value: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "support.png",
                      content: "Customer inquiry ",
                      onTap: (){
                        context.push(Routing.resetPassword);
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) {
                        },
                        value: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "completed.png",
                      content: "Order completion confirmation ",
                      onTap: (){
                        context.push(Routing.resetPassword);
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) {
                        },
                        value: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "security.png",
                      content: "Security alerts",
                      onTap: (){
                        context.push(Routing.resetPassword);
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) {
                        },
                        value: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "inven.png",
                      content: "Low inventory alerts",
                      onTap: (){
                        context.push(Routing.resetPassword);
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) {
                        },
                        value: true,
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
