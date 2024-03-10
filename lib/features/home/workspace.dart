import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/home/dashboard.dart';
import 'package:urbandrop/features/home/menu_page.dart';
import 'package:urbandrop/features/home/notification.dart';
import 'package:urbandrop/features/orders/orders_page.dart';
import 'package:urbandrop/features/store/store.dart';
import 'package:urbandrop/features/widget/daily_summary_widget.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';



class WorkspacePage extends StatefulWidget {
  WorkspacePage({Key? key}) : super(key: key);


  @override
  _WorkspacePageState createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              print("menu index:${index}");
              setState(() {
                currentIndex = index;
                _controller.jumpToPage(index);
              });
            },
            backgroundColor: Colors.black,
            currentIndex: currentIndex,
            showUnselectedLabels: false,

            showSelectedLabels: false,
            selectedItemColor: Colors.white,
            selectedFontSize: 12,
            unselectedItemColor: Colors.white.withOpacity(0.7),
            unselectedLabelStyle: appStyle(col: Colors.white.withOpacity(0.7),
                weight: FontWeight.w700,
                size: 12),
            selectedLabelStyle: appStyle(col: Colors.white,
                weight: FontWeight.w700,
                size: 12,
                textDecoration: TextDecoration.underline),
            unselectedFontSize: 12,

            iconSize: 25,
            items: [
              _buildBottomNavigationBarItem(
                active: currentIndex == 0,
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/active_dash.png", width: 25,),
                ),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/inactive_dash.png", width: 25,),
                ),
                label: "Dashboard",

              ),
              _buildBottomNavigationBarItem(
                  active: currentIndex == 1,
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/active_menu.png", width: 25,),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        "assets/images/inactive_menu.png", width: 25),
                  ),
                  label: "Menu"),
              _buildBottomNavigationBarItem(
                  active: currentIndex == 2,
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/active_orders.png", width: 25,),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        "assets/images/inactive_orders.png", width: 25),
                  ),
                  label: "Orders"),
              _buildBottomNavigationBarItem(
                  active: currentIndex == 3,
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/active_notification.png", width: 25,),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        "assets/images/inactive_notification.png", width: 25),
                  ),
                  label: "Notifications"
              ),

              _buildBottomNavigationBarItem(
                active: currentIndex == 4,
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/inactive_store.png", width: 25,),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/active_store.png", width: 25,),
                ),
                label: "Store",
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: const [
                DashboardPage(),
                MenuPage(),
                OrdersPage(),
                NotificationPage(),
                StorePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String label = "", Widget? icon, Widget? activeIcon, bool? active}) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: active!
              ? const Border(
            bottom: BorderSide(
              color: primaryColor,
              width: 2.0,
            ),
          )
              : null,
        ),
        child: Column(
          children: [
            icon!,
            sText(label,color: Colors.white.withOpacity(0.7),size: 12)

          ],
        ),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: active!
              ? const Border(
            bottom: BorderSide(
              color: primaryColor,
              width: 2.0,
            ),
          )
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            activeIcon!,
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: sText(label,color: Colors.white,size: 12,weight: FontWeight.w600),
            )
          ],
        ),
      ),
      label: "",
    );
  }
}
