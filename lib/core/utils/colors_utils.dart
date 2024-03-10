import 'dart:ui';

import 'package:flutter/painting.dart';

const kAccountContainerColor = Color(0xFFF0F0F0);
const kBlue = Color(0xFF0066FF);
const kSocialLoginTextColor = Color(0xFF646464);
const kAccountFieldColor = Color(0xFFF5F5F5);
const firstGradientColor =  Color(0xffA08C64);
const secondGradientColor =  Color(0xff3E4550);
const kRedColor =  Color(0xffBB0000);
const Color sBlueGray = Color(0xFFb4bbc9);
const Color solonGray200 = Color(0xFFdadcdf);
const Color solonGray300 = Color(0xFFADB5BD);
const Color solonGray400 = Color(0xFF9ea6ad);
const Color solonGray500 = Color(0xFF757b81);
const Color solonGray600 = Color(0xFF5b5f64);
const Color solonGray700 = Color(0xFF495057);
const Color appCircleColor = Color(0xFF2C3543);

const Color darkColor = Color(0xFF253341);

Color sDarkGray = dDarkText.withOpacity(0.8);
Color sGray = dDarkText.withOpacity(0.4);
const dDarkText = Color(0xFF1D1D1D);
const Color dTurquoise = Color(0xFF0CB8B6);
const Color dPurple = Color(0xFF9F5DE2);
const Color dMiddleBlue = Color(0xFF5C86CE);
const Color dPurpleGradientLeft = Color(0xFF7A08FA);
const Color dPurpleGradientRight = Color(0xFFAD3BFC);
const Color dRedGradientRight = Color(0xFFE5366A);
const Color dRedGradientLeft = Color(0xFFFE806F);

const appLightGray = Color(0xFFE7ECF2);
const appMainLimeGreen = Color(0xFF96a038);
const appMainLimeGreen2 = Color(0xFF75bf43);
const appMainGreen = Color(0xFF00C853);
const appMainPink = Color(0xFFb81e4f);
const appMainViolet = Color(0xFF87449a);
const appMainDarkGrey = Color(0xFF253d47);
const appMainOrange = Color(0xFFFF9900);
const appMainColor = Color(0xFF428EFF);
// const appMainColor = Color(0xFF0066FF);
const appMainTextColor = Color(0xFF0066FF);
const appMainRedColor = Color(0XFFF74242);
const appGray = Color(0xFFadb4b9);
const appDarkText = Color(0xFF2F2F2F);
const cardColor =  Color(0XFF3E4550);
const Color primaryColor = Color(0xFF5CB35E);
const Color snackBarColor = Color(0xFF2C303A);
const Color lightBlueColor = Color(0xFFF5F5F5);
const Color primaryFadeColor = Color(0xFFF4F7FB);
const Color textFieldBorderColor = Color(0xFFD9D9D9);
const Color outlinedButtonBorderColor = Color(0xFFD9D9D9);
const Color scaffoldBackgroundColor = Color(0xFFF6F8FC);
const Color textFieldFilledBorderColor = Color(0xFFCED3D9);
const Color greyTitle = Color(0xFF6D6E80);
const Color hintColor = Color(0xFFCED3D9);
const Color darkBlueTextColor = Color(0xFF00457C);
const Color blueTextColor = Color(0xFF0973E7);
const Color menuBGColor = Color(0xFFF4F7FB);
const Color blueBorder = Color(0xFF0973E7);
const Color greenBorder = Color(0xFF45B25D);
const Color lightBlueBorder = Color(0xFF5EA8FA);
const Color transparentBlue = Color(0xFFBEDAF8);
const Color transparentGreen = Color(0xFFA2D8AE);
const Color greyText = Color(0xFF9698AF);
const Color greyIconColor = Color(0xFF6D6F81);
const Color calenderUnselectedIcon = Color(0xFF9699AF);
const Color calenderUnselectedText = Color(0xFF6D6F81);
const Color programsSheetTitle = Color(0xFF6D6F81);
const Color calenderBorder = Color(0xFFE4EAF2);
const Color calenderBg = Color(0x28A8B9CC);
final addProgramActiveIcon = HexColor("#5EA8FA");
final Color textColorBody = const Color(0xFF000000).withOpacity(0.7);
const greenColor = Color.fromRGBO(69, 178, 93, 1);
final invalidProgTextColor = HexColor("#B5B5B5");
final greyBorder = HexColor("#CED3D9");

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  const lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  const highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}
class Images{
  static const royaltyImage = 'assets/images/rec_info.svg';

}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor??'#00000000'));
}