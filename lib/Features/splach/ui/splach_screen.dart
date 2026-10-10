import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:to_day/Features/home/Ui/home_screen.dart';
import 'package:to_day/Features/login/data/Models/user_modle.dart';
import 'package:to_day/Features/login/ui/login_screen.dart';
import 'package:to_day/core/app_const.dart';
import 'package:to_day/theme/app_text_stly.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  nextRoud()),
      );
    });
  }

  Widget nextRoud() {
    if( Hive.box<UserModle>(AppConst.userBox).isEmpty)
{
 return LoginScreen();
    }
    else{
      return HomeScreen();
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icon/Splach_icons.json'),
            const SizedBox(height: 20),
            const Text('Welcome to My App', style: AppTextStyle.hintline),
          ],
        ),
      ),
    );
  }
}
