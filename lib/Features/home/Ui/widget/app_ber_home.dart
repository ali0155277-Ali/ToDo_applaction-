import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_day/Features/login/data/Models/user_modle.dart';
import 'package:to_day/core/app_const.dart';
import 'package:to_day/theme/app_text_stly.dart';

class AppBerHome extends StatelessWidget {
     

  const AppBerHome({super.key});

  @override
  Widget build(BuildContext context) {
     var userData = Hive.box<UserModle>(AppConst.userBox).getAt(0);
    return Row(
      children: [
        CircleAvatar(radius: 40,
         backgroundImage: Image.file(File(userData?.image??"")).image),
        SizedBox(width: 15),
       
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
            
            Text("Good Morning😘",style: AppTextStyle.hintline,),
            Text(userData?.name??"",style: AppTextStyle.headline,),
          ],),
        ),
          
            Icon(Icons.notifications_active_outlined,size: 35,),
      ],
    );
  }
}
