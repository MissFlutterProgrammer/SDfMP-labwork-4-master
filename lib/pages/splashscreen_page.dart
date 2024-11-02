// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:planner/consts/consts.dart';
import 'package:planner/db/db_helper.dart';
import 'package:planner/models/user.dart';
import 'package:planner/pages/welcome_page.dart';
import 'main_page.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  _SplashscreenPageState createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  Widget widgetNavigate = const WelcomePage();

  Future<void> loadPage() async {
    User? user = await DatabaseHelper.instance.findAuthUser();
    setState(() {
      widgetNavigate =
          user == null ? const WelcomePage() : MainPage(index: 0, user: user);
    });
  }

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.bgColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/icons/logo.png",
              color: Consts.textColor,
              colorBlendMode: BlendMode.modulate,
              width: Consts.getWidth(context) / 4,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Consts.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widgetNavigate),
      );
    });
  }
}
