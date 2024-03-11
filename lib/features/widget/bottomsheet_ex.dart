import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';


extension PopupExtention on Widget {
  asFixedBottomSheet(BuildContext context,
      {double? height,
      String title = "bottomSheet",
      showCotrols = true,
      final isDismissible = true,
      VoidCallback? onDissmis}) {
    showModalBottomSheet<void>(
        // elevation: 15.0,
        // barrierColor: Colors.transparent,

        isScrollControlled: true,
        isDismissible: isDismissible,
        context: context,
        builder: (BuildContext context) {

          return WillPopScope(
            onWillPop: () async {
              return isDismissible;
            },
            child: Wrap(
              children: [
                Visibility(
                  visible: showCotrols,
                  child: Row(
                    children: [
                      sText(title),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, color: programsSheetTitle),
                      )
                    ],
                  ).marginOnly(left: 16, top: 12, right: 16),
                ),
                this
              ],
            ),
          );
        }).whenComplete(() {
      if (onDissmis != null) {
        onDissmis();
      }
    });
  }

  asBottomSheet(BuildContext context, {String? title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          minChildSize: 0.25,
          builder: (context, controller) {
            return CustomScrollView(
              controller: controller,
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: sText(title, size: 18,),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    )
                  ],
                ),
                this,
              ],
            );
          },
        );
      },
    );
  }
}
