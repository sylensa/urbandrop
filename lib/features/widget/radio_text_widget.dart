import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class RadioTextWidget extends StatefulWidget {
  final String? text;
  final bool? selected ;
  final Function() onTap;
  const RadioTextWidget({super.key,required this.onTap, this.selected = false, this.text = "Found a better alternative"});


  @override
  State<RadioTextWidget> createState() => _RadioTextWidgetState();
}

class _RadioTextWidgetState extends State<RadioTextWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: widget.selected! ? primaryColor : Color(0XFF879EA4))
            ),
            child: Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.all(2),
              decoration:  BoxDecoration(
                  color: widget.selected! ? primaryColor : Colors.white,
                  shape: BoxShape.circle
              ),
            ),
          ),
          SizedBox(width: 10,),
          sText(widget.text,size: 12,weight: FontWeight.w400)
        ],
      ),
    );
  }
}
