import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/screens/profile_otp_scrren/profile_otp_screen.dart';
import 'package:flutter_app/utils/helpers.dart';
import 'package:flutter_app/widgets/click.dart';
import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:images_picker/images_picker.dart';

class EditProfileScreen extends HookWidget {
  static const String id = 'editprofile';
  final AuthController authController = Get.find(tag: 'auth_controller');

  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = authController.user();
    final name = useState(user.name);
    final email = useState(user.email);
    final profilePicture = useState(user.getImageUrl());
    final isNewsletterSubscribed = useState(user.isNewsletterSubscribed);

    openGallery() async {
      List<Media> res = await ImagesPicker.pick(
        count: 1,
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 500,
      );
      print({"path": res[0].path, "size": res[0].size});
      profilePicture.value = res[0].path;
    }

    openCamera() async {
      List<Media> res = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 500,
      );
      print({"path": res[0].path, "size": res[0].size});
      profilePicture.value = res[0].path;
    }

    selectImage() {
      showAlertDialog(
        context,
        title: 'Select Profile Picture',
        text: "",
        onPressedNo: openGallery,
        onPressedYes: openCamera,
        no: "Gallery",
        yes: "Camera",
      );
    }

    save() {
      if (formKey.currentState.validate()) {
        authController.editProfile(
            profilePicture: user.getImageUrl() != profilePicture.value
                ? profilePicture.value
                : null,
            email: email.value,
            name: name.value,
            isNewsletterSubscribed: isNewsletterSubscribed.value,
            onSuccess: (navigateToOtp) {
              if (navigateToOtp) {
                Navigator.of(context)
                    .pushReplacementNamed(ProfileOtpScreen.id, arguments: {
                  "email": email.value,
                  "originalEmail": user.email,
                  "name": name.value,
                  "isNewsletterSubscribed": isNewsletterSubscribed.value,
                  ...(user.getImageUrl() != profilePicture.value
                      ? {"profilePicture": profilePicture.value}
                      : {})
                });
              } else {
                popupDialog(context,
                    text: "Profile Update Successful", onTap: () {});
              }
            });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(
        context,
        text: "Edit Profile",
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            scaler.scalerH(25.0),
            0,
            scaler.scalerH(25.0),
            scaler.scalerV(30.0),
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        0, scaler.scalerV(30.0), 0, scaler.scalerV(10.0)),
                    height: scaler.scalerH(140.0),
                    width: scaler.scalerH(140.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scaler.scalerH(70.0)),
                      border: Border.all(
                          width: scaler.scalerH(4.5), color: Color(0xFFFFD5D5)),
                      image: DecorationImage(
                        image: profilePicture.value != null
                            ? profilePicture.value.indexOf("http") == -1
                                ? FileImage(File(profilePicture.value))
                                : NetworkImage(profilePicture.value)
                            : AssetImage(
                                "assets/images/Users.jpeg",
                              ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey.shade300,
                    ),
                  ),
                  onTap: selectImage,
                ),
                GestureDetector(
                  child: Text(
                    "Change Profile Photo",
                    style: textStyle(),
                  ),
                  onTap: selectImage,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, scaler.scalerV(35.0), 0, scaler.scalerV(30.0)),
                  child: Input(
                    obscureText: false,
                    labelText: 'Enter your name',
                    textCapitalization: TextCapitalization.words,
                    initialValue: name.value,
                    onChanged: (String text) {
                      name.value = text;
                    },
                    validator: (value) => Helpers.validateEmpty(
                      value,
                      "Name",
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      nameNode.unfocus();
                      emailNode.requestFocus();
                    },
                    focusNode: nameNode,
                  ),
                ),
                Input(
                  obscureText: false,
                  labelText: 'Enter email',
                  initialValue: email.value,
                  onChanged: (String text) {
                    email.value = text;
                  },
                  validator: Helpers.validateEmail,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    emailNode.unfocus();
                    save();
                  },
                  focusNode: emailNode,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, scaler.scalerV(70.0), 0, scaler.scalerV(55.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: DayTheme.primaryColor,
                        value: isNewsletterSubscribed.value,
                        onChanged: (bool value) {
                          isNewsletterSubscribed.value = value;
                        },
                      ),
                      Text(
                        "Subscribe to our newsletter!",
                        style: textStyle(
                          color: DayTheme.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        scaler.scalerH(25.0), 0, scaler.scalerH(25.0), 0),
                    child: Obx(
                      () => Click(
                          loading: authController.loading.value,
                          text: "SAVE",
                          onPressed: save),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
