import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/routes.dart';

import '../../core/helper/helper.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentSlide = 0;
  List<ListNames> onBoards = [
    ListNames(image:"assets/images/onboard_1.png",name: "Join the Flavors of Africa",
            desc: "Welcome to Urbandrop, where your delicious offerings meet hungry customers. "
                "Let's get started on bringing the taste of Africa to their doorstep!" ),
    ListNames(image:"assets/images/onboard_2.png",name: "Craft Your Menu, Your Way",
            desc: "Easily add and manage your menu items through our user-friendly interface. "
            "From Jollof rice to tasty soups to fresh ingredients, showcase the diversity "
            "of African cuisine with high-quality images and enticing descriptions.",
            ),
    ListNames(image:"assets/images/onboard_3.png",name: "Effortless Delivery, Happy Customers!",
            desc: "Delivery is as easy as preparing your favourite dish. Manage orders, track deliveries, "
                "and ensure your customers receive their meals fresh and on time!" ),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: (_currentSlide != 0) ? IconButton(onPressed: (){
          context.pop();
        }, icon: const Icon(Icons.arrow_back_ios)) : const SizedBox.shrink(),
        actions: [
          if(_currentSlide != onBoards.length -1)
          InkWell(
            onTap: (){
              context.go(Routing.registrationPage);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: sText("Skip",size: 15,weight: FontWeight.w700,color: primaryColor),
            ),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sText(onBoards[_currentSlide].name,size: 24,weight: FontWeight.w900),
            Column(
              children: [
                CarouselSlider.builder(
                    options:
                    CarouselOptions(
                      height: 250,
                      autoPlay:
                      false,
                      enableInfiniteScroll:
                      true,
                      autoPlayAnimationDuration:
                      const Duration(seconds: 1),
                      enlargeCenterPage:
                      false,
                      viewportFraction:
                      1,
                      aspectRatio:
                      2.0,
                      pageSnapping:
                      true,
                      onPageChanged: (index, reason) {
                        setState(
                                () {
                              _currentSlide =
                                  index;
                            });
                      },
                    ),
                    itemCount:onBoards.length,
                    itemBuilder: (BuildContext context, int indexReport, int index2) {
                        return displayLocalImage(
                            onBoards[indexReport].image,
                            height: 300,
                            width: double.infinity,
                            radius: 0
                        );


                    }),
                sText(onBoards[_currentSlide].desc,size: 12,weight: FontWeight.w400,align: TextAlign.center)
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Center(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: onBoards.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: _currentSlide == index ?  Colors.black : Colors.white,
                                shape: BoxShape.circle,
                              border: Border.all(color: Colors.black)
                            ),
                          );
                        }),
                  ),
                ),
                mainButton(
                    content: sText("Next",color: Colors.white,size: 18,weight: FontWeight.w600),
                    backgroundColor: primaryColor,
                    shadowStrength: 0,
                    height: 50,
                    radius: 30,
                    onPressed: (){
                      if(_currentSlide == onBoards.length -1){
                        context.go(Routing.registrationPage);
                      } else{
                        _currentSlide++;
                      }
                       setState(() {

                       });
                    })
              ],
            ),

          ],
        ),
      ),
    );
  }
}
