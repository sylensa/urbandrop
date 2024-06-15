import 'dart:convert';
import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';
import 'package:urbandrop/features/widget/tab_bar_slider.dart';
import 'package:urbandrop/models/user.dart';
import 'package:urbandrop/routes.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
AuthenticationController authenticationController = AuthenticationController();
 String? selectedDay = "1";
 int? selectedIndex = 0;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0),(){
      for(int i =0; i < userInstance!.storeTimes!.length; i++){
        for(int t =0 ; t < authenticationController.storeTimes.length; t++){
          if(userInstance!.storeTimes![i].day == authenticationController.storeTimes[t].day){
            log("userInstance:${userInstance!.storeTimes![i].toJson()}");
            authenticationController.storeTimes[t].closingTime = userInstance!.storeTimes![i].closingTime;
            authenticationController.storeTimes[t].openingTime = userInstance!.storeTimes![i].openingTime;
          }
        }
      }
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Opening and Closing time",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20,left: 0,right: 0,bottom: 20),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: authenticationController.storeTimes.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          mainButton(
                              width: 120,
                              height: 30,
                              radius: 30,
                              outlineColor: selectedDay ==  authenticationController.storeTimes[index].day ? Colors.transparent : primaryColor,
                              shadowStrength: 0,
                              backgroundColor: selectedDay ==  authenticationController.storeTimes[index].day  ? primaryColor : Colors.white,
                              content:  sText(authenticationController.storeTimes[index].weekDays,color: selectedDay ==  authenticationController.storeTimes[index].day  ? Colors.white : primaryColor,weight: FontWeight.w600,size: 12),
                              onPressed:(){
                                setState(() {
                                  selectedDay = authenticationController.storeTimes[index].day ;
                                  selectedIndex = index;
                                });
                              }),

                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(height:20,),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Flexible(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 0),
                         child: sText("Opening time",size: 12,weight: FontWeight.w600),
                       ),
                       const SizedBox(height: 20,),
                       TimePickerSpinnerPopUp(
                         mode: CupertinoDatePickerMode.time,
                         initTime: DateTime.now(),
                         barrierColor: Colors.black12, //Barrier Color when pop up show
                         minuteInterval: 1,
                         padding : const EdgeInsets.fromLTRB(12, 10, 12, 10),
                         cancelText : 'Cancel',
                         confirmText : 'OK',
                         pressType: PressType.singlePress,
                         timeFormat: 'HH:MM',
                         // Customize your time widget
                         timeWidgetBuilder: (dateTime) {
                           return Container(
                             alignment: Alignment.center,
                             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               border: Border.all(color: const Color(0XFF1F546033)),
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 sText(selectedIndex != null ? authenticationController.storeTimes[selectedIndex!].openingTime!.isNotEmpty ?  authenticationController.storeTimes[selectedIndex!].openingTime  : "Pick time" :"Pick time" ,color: const Color(0xFF879EA4)),
                                 const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                               ],
                             ),
                           );
                         },
                         onChange: (dateTime) {
                           print("dateTime:$dateTime");
                           setState(() {
                             authenticationController.storeTimes[selectedIndex!].openingTime = "${dateTime.toString().split(" ").last.split(":")[0]}:${dateTime.toString().split(" ").last.split(":")[1]}:00";
                           });
                           // Implement your logic with select dateTime
                         },
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(width: 20,),
                 Flexible(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         padding: const EdgeInsets.only(right: 0),
                         child: sText("Closing time",size: 12,weight: FontWeight.w600),
                       ),
                       const SizedBox(height: 20,),
                       TimePickerSpinnerPopUp(
                         mode: CupertinoDatePickerMode.time,
                         initTime: DateTime.now(),
                         barrierColor: Colors.black12, //Barrier Color when pop up show
                         minuteInterval: 1,
                         padding : const EdgeInsets.fromLTRB(12, 10, 12, 10),
                         cancelText : 'Cancel',
                         confirmText : 'OK',
                         pressType: PressType.singlePress,
                         timeFormat: 'HH:MM',
                         // Customize your time widget
                         timeWidgetBuilder: (dateTime) {
                           return Container(
                             alignment: Alignment.center,
                             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               border: Border.all(color: const Color(0XFF1F546033)),
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 sText(selectedIndex != null ? authenticationController.storeTimes[selectedIndex!].closingTime!.isNotEmpty ?  authenticationController.storeTimes[selectedIndex!].closingTime  : "Pick time" : "Pick time",color: const Color(0xFF879EA4)),
                                 const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                               ],
                             ),
                           );
                         },
                         onChange: (dateTime) {
                           print("dateTime:$dateTime");
                           setState(() {
                             authenticationController.storeTimes[selectedIndex!].closingTime = "${dateTime.toString().split(" ").last.split(":")[0]}:${dateTime.toString().split(" ").last.split(":")[1]}:00";
                           });
                           // Implement your logic with select dateTime
                         },
                       ),
                     ],
                   ),
                 )
               ],
             ),
           ),

            InkWell(
              onTap: (){
              setState(() {
                authenticationController.storeTimes[selectedIndex!].openingTime = '';
                authenticationController.storeTimes[selectedIndex!].closingTime = '';
              });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   sText("clear",color: primaryRedColor,size: 16),
                   Icon(Icons.clear,color: primaryRedColor,size: 18,)
                 ],

                ),
              ),
            ),



            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: mainButton(
                  content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: primaryColor,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: ()async{
                    try{
                      showLoaderDialog(context);
                      var response = await authenticationController.setTime(context,
                        List<dynamic>.from(authenticationController.storeTimes.where((x) => x.closingTime!.isNotEmpty && x.openingTime!.isNotEmpty).map((x) => x.toJson()))
                      );
                      if(response){
                        context.pop();
                        toastSuccessMessage("Opening and Closing time updated successfully ", context);
                      }else{
                        context.pop();
                        toastMessage("Opening and Closing time updated failed ", context);
                      }
                    }catch(e){
                      context.pop();
                      toastMessage("Opening and Closing time updated failed ", context);
                      print("error:${e.toString()}");
                    }
                  }),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}



