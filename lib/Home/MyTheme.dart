import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryLight =  Color(0xff5D9CEC);
  static Color mintGreenColor = Color(0xffDFECDB);
  static Color greenColor = Color(0xff61E757);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color DarkblackColor = Color(0xff141922);
  static Color DarkblueColor = Color(0xff060E1E);
  static Color grayColor = Color(0xffC8C9CB);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    scaffoldBackgroundColor: mintGreenColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLight,
      unselectedItemColor: grayColor,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: whiteColor,
        fontSize: 22
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: blackColor,
        fontSize: 20,
    ),
      titleSmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: blackColor,
          fontSize: 18,
        )

    )

  );

}