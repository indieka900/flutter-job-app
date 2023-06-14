import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:flutter_nodejs_app/controllers/exports.dart';
import 'package:flutter_nodejs_app/models/request/auth/profile_update_model.dart';
import 'package:flutter_nodejs_app/views/common/app_style.dart';
import 'package:flutter_nodejs_app/views/common/custom_textfield.dart';
import 'package:flutter_nodejs_app/views/common/height_spacer.dart';
import 'package:flutter_nodejs_app/views/common/reusable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/custom_btn.dart';

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
          notifierValue.getPrefs();
          bool loading = notifierValue.loading;
          Future.delayed(const Duration(seconds: 5)).then((value) {
            if (loading) {
              setState(() async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool('loading', false);
              });
            }
          });
          return Stack(
            children: [
              Form(
                key: notifierValue.updateFormKey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ReusableText(
                          text: "Personal Details",
                          style:
                              appstyle(30, Color(kDark.value), FontWeight.bold),
                        ),
                        Consumer<ImageUpoader>(
                          builder: (context, uploaderValue, child) {
                            return GestureDetector(
                              onTap: () {
                                if (uploaderValue.images.isNotEmpty) {
                                  uploaderValue.images.clear();
                                  setState(() {});
                                  uploaderValue.pickImage();
                                } else {
                                  uploaderValue.pickImage();
                                }
                              },
                              child: CircleAvatar(
                                backgroundImage: uploaderValue.images.isEmpty
                                    ? null
                                    : FileImage(
                                        File(uploaderValue.images[0].path)),
                                backgroundColor: Color(kLightBlue.value),
                                child: uploaderValue.images.isEmpty
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
                            style: appstyle(
                                30, Color(kDark.value), FontWeight.bold),
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
                          Consumer<ImageUpoader>(
                            builder: (context, value, child) {
                              return CustomButton(
                                onTap: () {
                                  if (value.images.isEmpty &&
                                      value.imageUrl == null) {
                                    Get.snackbar(
                                      'Image Missing',
                                      'Please select image',
                                      colorText: Color(kLight.value),
                                      backgroundColor: Colors.red,
                                      icon: const Icon(Icons.add_alert),
                                    );
                                  } else {
                                    ProfileUpdateReq model = ProfileUpdateReq(
                                      location: location.text,
                                      profile: value.imageUrl.toString(),
                                      skills: [
                                        skill0.text,
                                        skill1.text,
                                        skill2.text,
                                        skill3.text,
                                        skill4.text,
                                      ],
                                    );
                                    notifierValue.updateProfile(model);
                                    notifierValue.firstTime = true;
                                  }
                                },
                                text: "Update Profile",
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              loading
                  ? Container(
                      color: Colors.white.withOpacity(0.5),
                      height: hieght,
                      width: width,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(kOrange.value),
                          strokeWidth: 6,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
