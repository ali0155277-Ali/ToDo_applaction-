import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_day/Features/home/Ui/home_screen.dart';
import 'package:to_day/Features/login/data/Models/user_modle.dart';
import 'package:to_day/core/app_const.dart';

import 'package:to_day/core/custom_app_bottom.dart';
import 'package:to_day/core/custom_filed_file.dart';
import 'package:to_day/theme/app_text_stly.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void pickCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 180),

                  InkWell(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Select Image"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text("Camera"),
                                  onTap: () {
                                    pickCamera();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text("Gallery"),
                                  onTap: () {
                                    pickImage();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: image != null
                          ? FileImage(File(image!.path))
                          : null,
                      child: image == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),

                  SizedBox(height: 30),
                  Text("Create Your Profile", style: AppTextStyle.headline),
                  SizedBox(height: 12),

                  Text(
                    "Add your name and profile picture ",
                    style: AppTextStyle.bodyText,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 30),
                  CustomFiledFile(controller: namecontroller,validator: (value) {
              if (value == null || value.isEmpty) {
                return "Place Enter The Name";
              } else if (value.length < 3) {
                return " Name Must be is Greater than 3 ";
              }
            },),
                  SizedBox(height: 30),
                  CustomAppBottom(
                    title: "Continue",
                    onTap: () {
                      if (image == null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text("Image is required"),
                          ),
                        );
                        return;
                      }
                      if (formKey.currentState?.validate() ?? false) {
                        Hive.box<UserModle>(AppConst.userBox)
                            .add(
                              UserModle(
                                image: image?.path ?? "",
                                name: namecontroller.text,
                              ),
                            )
                            .then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              ).catchError((error) {
                                print(error);
                              });
                            });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
