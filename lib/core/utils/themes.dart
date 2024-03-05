import 'package:flutter/material.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';


final lightThemeData = ThemeData(
  useMaterial3: false,
  fontFamily: 'Red Hat Display',
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  primarySwatch: MaterialColor(appMainColor.value, getSwatch(primaryColor)),
  backgroundColor: Colors.white,
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: const TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: textColorBody,
      height: 1.5,
      fontSize: 16,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    suffixStyle: TextStyle(
      color: greyTitle,
      fontSize: 16,
      height: 1,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: textFieldFilledBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: textFieldFilledBorderColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      backgroundColor: primaryColor,
      disabledBackgroundColor: primaryColor.withOpacity(0.3),
      disabledForegroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: blueBorder,
      disabledForegroundColor: Colors.black.withOpacity(0.3),
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      side: const BorderSide(
        color: blueBorder,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        color: primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      disabledForegroundColor: primaryColor.withOpacity(0.3),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    centerTitle: false,
    foregroundColor: Colors.black,
    toolbarTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    shadowColor: Colors.grey.shade100,
  ),
  brightness: Brightness.light,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.transparent,
    disabledColor: Colors.transparent,
    selectedColor: Colors.transparent,
    secondarySelectedColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    shape: const StadiumBorder(side: BorderSide(color: textFieldBorderColor)),
    labelStyle: TextStyle(
      color: Colors.black.withOpacity(0.7),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(color: Colors.grey, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 3,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
  ),
);

final ecoLightThemeData = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  primarySwatch: MaterialColor(primaryColor.value, getSwatch(primaryColor)),
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: const TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: textColorBody,
      height: 1.5,
      fontSize: 16,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: hintColor),
    suffixStyle: TextStyle(
      color: greyTitle,
      fontSize: 16,
      height: 1,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    border: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: textFieldFilledBorderColor)),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      backgroundColor: primaryColor,
      disabledBackgroundColor: primaryColor.withOpacity(0.3),
      disabledForegroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: blueBorder,
      disabledForegroundColor: Colors.black.withOpacity(0.3),
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      side: const BorderSide(
        color: blueBorder,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        color: primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      disabledForegroundColor: primaryColor.withOpacity(0.3),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    centerTitle: false,
    foregroundColor: Colors.black,
    toolbarTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    shadowColor: Colors.grey.shade100,
  ),
  brightness: Brightness.light,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.transparent,
    disabledColor: Colors.transparent,
    selectedColor: Colors.transparent,
    secondarySelectedColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    shape: const StadiumBorder(side: BorderSide(color: textFieldBorderColor)),
    labelStyle: TextStyle(
      color: Colors.black.withOpacity(0.7),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(color: Colors.grey, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 3,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
  ),
);
const textFieldLabelStyle = TextStyle(
    fontSize: 16, color: Color(0xFF7E7F8A), fontWeight: FontWeight.w400);

final textFieldWhiteLabelStyle =
    textFieldLabelStyle.copyWith(color: Colors.white);

final moreContentGradientIndicator = LinearGradient(
    colors: [Colors.white, Colors.white.withAlpha(50)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: const [0.7, 1.0]);

final bottomActionsGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.white.withOpacity(0),
    Colors.white,
    Colors.white,
    Colors.white,
  ],
);
