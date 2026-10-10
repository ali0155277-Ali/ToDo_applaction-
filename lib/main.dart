import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_day/Features/AddTask/data/Models/model_task.dart';
import 'package:to_day/Features/login/data/Models/user_modle.dart';
import 'package:to_day/core/app_const.dart';

import 'package:to_day/todo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModleAdapter());
  Hive.registerAdapter(ModelTaskAdapter());

  await Hive.openBox<UserModle>(AppConst.userBox);
  await Hive.openBox<ModelTask>(AppConst.taskBox);
  

  runApp(const TodoApp());
}
