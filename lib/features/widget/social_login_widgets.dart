import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';


class SocialLoginWidget extends StatelessWidget {
  final String title;
  final String image;
  final Function onTap;
  const SocialLoginWidget(
      {required this.image, required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: appWidth(context),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
        decoration: BoxDecoration(
          color:title.contains("Google") ?   Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(56),
          border: Border.all(color: Colors.black)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,width: 23,),
            const SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                title,
                style:  TextStyle(
                  color:title.contains("Google") ? Colors.black : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
