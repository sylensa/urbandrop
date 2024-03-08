import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';


class TabBarSlider extends StatefulWidget {
  List<Widget> child ;
  TabBarSlider({Key? key, this.child = const []}) : super(key: key);

  @override
  State<TabBarSlider> createState() => _TabBarSliderState();
}

class _TabBarSliderState extends State<TabBarSlider> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;
  List<Tab> myTabs = <Tab> [
    const Tab(
      text: "All",
    ),
    const Tab(
      text: "Pending",
    ),
    const Tab(
      text: "Confirm",
    ),
    const Tab(
      text: "In Progress",
    ),
    const Tab(
      text: "Completed",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState

    tabController = TabController(length: myTabs.length ,vsync: this,initialIndex: currentTabIndex)
      ..addListener(() {
        setState(() {
          currentTabIndex = tabController.index;
          print("currentTabIndex:$currentTabIndex");
        });
      });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Container(
        height:appHeight(context) * 0.723,
        width: appWidth(context),
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        child: Column(
          children: [
            TabBar(
              onTap: (index){
                setState(() {
                  currentTabIndex = index;
                  print("currentTabIndex:$currentTabIndex");
                });
              },
              controller: tabController,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 5,
              labelPadding: const EdgeInsets.only(right: 0),

              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,

              ),
              indicatorColor: Colors.transparent ,

              tabs: myTabs
                  .map<Widget>((myTab) => Tab(
                child:   AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical:5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),

                  // width: 110,
                  decoration: BoxDecoration(
                      color:   currentTabIndex == myTabs.indexOf(myTab) ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryColor)
                  ),
                  child: Text(
                    myTab.text!,
                    style: TextStyle(
                        color:   currentTabIndex == myTabs.indexOf(myTab)? Colors.white : primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),


              ))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  physics: const ClampingScrollPhysics(),
                  children:widget.child

              ),

              // FlutterCarousel(
              //
              //   carouselController: CarouselController(),
              //   options: CarouselOptions(
              //     scrollPhysics: ClampingScrollPhysics(),
              //
              //     // height: 500,
              //     showIndicator: false,
              //     viewportFraction: 1,
              //     floatingIndicator: true,
              //
              //     initialPage: widget.currentPage!,
              //     onPageChanged: (index,change){
              //       widget.sliderChange(index);
              //     }
              //   ),
              //   items:  [
              //
              //
              //
              //
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
