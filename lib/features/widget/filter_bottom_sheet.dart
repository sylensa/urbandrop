import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
String? orderStatus;
DateTime? selectedDate;
final List<String> _list = [
  'Pending',
  'Cancelled',
  'Completed',
  'Confirmed',
];

// custom bottom sheet for filtering
ordersPlaceFilter(BuildContext context){

  final state = Get.put(OrdersController());
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent ,
      isScrollControlled: true,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context,StateSetter stateSetter){
            return Container(
              height: 400,
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius:  BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0XFF1F546033))
                      ),
                      child: CustomDropdown<String>.search(
                        hintText: 'Select order status',
                        headerBuilder: (context, selectedItem,v) {
                          return sText(
                            selectedItem.toString(),
                            color:   Colors.black,
                            size: 16,
                            weight:  FontWeight.w500,

                          );
                        },
                        hintBuilder: (context, selectedItem,v) {
                          return sText(
                            selectedItem.toString(),
                            color:  const Color(0xFF879EA4),
                            size: 16,
                            weight:  FontWeight.w400,

                          );
                        },

                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        canCloseOutsideBounds: true,
                        decoration: CustomDropdownDecoration(
                          closedFillColor: Colors.white,
                          closedBorderRadius: BorderRadius.circular(30),
                          closedBorder: Border.all(color: const Color(0XFF1F546033)),
                          closedShadow:[
                            const BoxShadow(
                                blurRadius: 1,
                                color: Colors.white,
                                offset: Offset(0, 0.0),
                                spreadRadius: 1),
                            const BoxShadow(
                                blurRadius: 1,
                                color: Colors.white,
                                offset: Offset(0, 0.0),
                                spreadRadius: 1)
                          ],
                        ),

                        items: _list,
                        onChanged: (value) {
                          stateSetter(() {
                            orderStatus = value;
                          });
                          log('changing value to: $value');
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  InkWell(
                    onTap: () async {
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
                        stateSetter(() {
                          if (dateSelected.isNotEmpty) {
                            selectedDate = dateSelected.first;
                          }
                        });
                      }

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0XFF1F546033))
                      ),
                      child: Center(child: sText(selectedDate == null ? "Select date" : dateFormat(selectedDate!),color: Colors.black)),
                    ),
                  ),
                    const Spacer(),

                  mainButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if(selectedDate != null  || selectedDate != null){
                        // state.filterOrders(orderStatus ?? "", selectedDate != null ? dateFormat(selectedDate!) : "");
                      }
                    },
                    backgroundColor:  orderStatus != null  || selectedDate != null ? primaryColor: Colors.grey[400]!,
                    content: sText("Apply filters", color: Colors.white),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  InkWell(
                    onTap: () {
                      stateSetter(() {
                        Navigator.pop(context);
                        selectedDate = null;
                        orderStatus = null;
                        // state.filterOrders(orderStatus ?? "", selectedDate != null ? dateFormat(selectedDate!) : "");
                      });
                    },
                    child:Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: appMainRedColor,width: 2)
                              )
                          ),
                          child:  sText(
                              'Clear',
                              align: TextAlign.left,
                              color: appMainRedColor,
                              weight: FontWeight.w600,
                              size: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },

        );
      }
  );
}