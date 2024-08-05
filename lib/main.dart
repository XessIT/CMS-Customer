import 'package:cms_customer/screens/login.dart';
import 'package:cms_customer/theme/theme.dart';
import 'package:cms_customer/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => ThemeNotifier(AppThemes.lightTheme),
          child: CMSApp()
      ),
  );
}

class CMSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
     return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CMS',
        theme: themeNotifier.themeData,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   textTheme: GoogleFonts.tajawalTextTheme(
        //     Theme.of(context).textTheme,
        //   ),
        // ),
        home: LoginScreen(),
      );
      }
    );
  }
}
