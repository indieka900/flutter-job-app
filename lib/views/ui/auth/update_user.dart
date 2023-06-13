import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:flutter_nodejs_app/controllers/exports.dart';
import 'package:flutter_nodejs_app/views/common/app_style.dart';
import 'package:flutter_nodejs_app/views/common/custom_btn.dart';
import 'package:flutter_nodejs_app/views/common/custom_textfield.dart';
import 'package:flutter_nodejs_app/views/common/height_spacer.dart';
import 'package:flutter_nodejs_app/views/common/reusable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginNotifier>(
        builder: (context, notifierValue, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ReusableText(
                    text: "Personal Details",
                    style: appstyle(30, Color(kDark.value), FontWeight.bold),
                  ),
                  Consumer<ImageUpoader>(
                    builder: (context, uploaderValue, child) {
                      return GestureDetector(
                        onTap: () {
                          if (uploaderValue.imageFil.isNotEmpty) {
                            uploaderValue.imageFil.clear();
                            setState(() {});
                            uploaderValue.pickImage();
                          } else {
                            uploaderValue.pickImage();
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: uploaderValue.imageFil.isEmpty
                              ? null
                              : FileImage(File(uploaderValue.imageFil[0])),
                          backgroundColor: Color(kLightBlue.value),
                          child: uploaderValue.imageFil.isEmpty
                              ? const Center(
                                  child: Icon(Icons.photo_filter_rounded),
                                )
                              : null,
                        ),
                      );
                    },
                  )
                ],
              ),
              const HeightSpacer(size: 20),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextField(
                      hintText: 'Location',
                      keyboardType: TextInputType.text,
                      controller: location,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      controller: phone,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 20),
                    ReusableText(
                      text: 'Proffesional Skills',
                      style: appstyle(30, Color(kDark.value), FontWeight.bold),
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      hintText: 'Proffesional Skill',
                      keyboardType: TextInputType.text,
                      controller: skill0,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      hintText: 'Proffesional Skill',
                      keyboardType: TextInputType.text,
                      controller: skill1,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      hintText: 'Proffesional Skill',
                      keyboardType: TextInputType.text,
                      controller: skill2,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      hintText: 'Proffesional Skill',
                      keyboardType: TextInputType.text,
                      controller: skill3,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      hintText: 'Proffesional Skill',
                      keyboardType: TextInputType.text,
                      controller: skill4,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 20),
                    CustomButton(onTap: () {}, text: "Update Profile")
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
