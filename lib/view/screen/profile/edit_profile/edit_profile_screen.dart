import 'dart:io';

import 'package:capstone_project/utils/components/text_box/read_only_text_box.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/profile/change_password/change_password_screen.dart';
import 'package:capstone_project/view/screen/profile/edit_profile/edit_profile_view_model.dart';
import 'package:capstone_project/view/screen/profile/profilel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/user_model.dart';
import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/text_box/regular_text_box/text_box.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_size.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String routeName = '/edit_profile_screen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late final ProfileViewModel profileProvider;
  late final EditProfileViewModel editProfileProvider;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    profileProvider = Provider.of<ProfileViewModel>(context, listen: false);
    _usernameController.text = profileProvider.userData.username ?? '';
    _nameController.text = profileProvider.userData.name ?? '';
    _phoneController.text = profileProvider.userData.phone ?? '';
    editProfileProvider =
        Provider.of<EditProfileViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        editProfileProvider.initImage();
        profileProvider.initProfile();
        editProfileProvider.changeState(MyState.initial);
      },
    );
    editProfileProvider.addListener(() {
      if (editProfileProvider.state == MyState.loaded) {
        profileProvider.initProfile();
        editProfileProvider.changeState(MyState.initial);
      }
    });
    super.initState();
  }

  void _showAlert(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: MyColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: MyColor.neutralMediumLow, width: .5),
          ),
          title: Text(
            'Are you sure want to make a change?',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: MyColor.neutralHigh,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            PrimaryButton(
              teks: 'Sure',
              onPressed: () {
                editProfileProvider.updateProfile(
                  UserModel(
                    username: _usernameController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    pictureFile: editProfileProvider.imageFile,
                  ),
                );
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            PrimaryButton(
              teks: 'Maybe Latter',
              onPressed: () {
                Navigator.pop(context);
              },
              customBackgroundColor: MyColor.neutralLow,
              customTextColor: MyColor.primaryMain,
            )
          ],
        );
      },
    );
  }

  void _showImage(ImageProvider<Object> imageData) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageData,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Edit Profile',
        home: false,
        searchField: false,
        tabBar: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: MyColor.background,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MySize.screenPadding,
                  top: MediaQuery.of(context).size.height * 0.05,
                  right: MySize.screenPadding),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Update your profile information here.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralMediumLow,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'Photo Profile',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CircleAvatar(
                        radius: 40,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: MyColor.primaryMain,
                              child: Consumer<EditProfileViewModel>(
                                builder: (context, value, child) {
                                  if (value.imageFile == null &&
                                      profileProvider.userData.picturePath ==
                                          '') {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.person,
                                        color: MyColor.white,
                                        size: 50,
                                      ),
                                      onPressed: () {
                                        editProfileProvider.setImageFile();
                                      },
                                    );
                                  } else if (value.imageFile == null &&
                                      profileProvider.userData.picturePath !=
                                          '') {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: GestureDetector(
                                        child: Image.network(
                                          profileProvider
                                                  .userData.picturePath ??
                                              '',
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                        ),
                                        onTap: () {
                                          _showImage(
                                            NetworkImage(
                                              profileProvider
                                                      .userData.picturePath ??
                                                  '',
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: GestureDetector(
                                        child: Image.file(
                                          File(value.imageFile?.path ?? ''),
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                        ),
                                        onTap: () {
                                          _showImage(
                                            FileImage(
                                              File(value.imageFile?.path ?? ''),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: MyColor.neutralHigh,
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: MyColor.white,
                                  size: 15,
                                ),
                                onPressed: () {
                                  editProfileProvider.setImageFile();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ReadOnlyTextBox(
                      value: profileProvider.userData.email ?? '',
                      textColor: MyColor.neutralMediumLow,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextBox(
                      textEditingController: _usernameController,
                      hintText: "Ex : johndoe",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null ||
                            p0.isEmpty ||
                            !RegExp(r'^(?!\s+$)').hasMatch(p0)) {
                          return 'username is required';
                        }
                        if (!RegExp(r'^[^\s]*$').hasMatch(p0)) {
                          return 'username cannot contain spaces';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextBox(
                      textEditingController: _nameController,
                      hintText: "Ex : johndoe",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null ||
                            p0.isEmpty ||
                            !RegExp(r'^(?!\s+$)').hasMatch(p0)) {
                          return 'name is required';
                        }
                        if (!RegExp(r'^[^\s].*').hasMatch(p0)) {
                          return 'invalid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextBox(
                      textEditingController: _phoneController,
                      hintText: "Ex : 08****12397",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'phone number is required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(p0)) {
                          return 'must be a number';
                        }
                        if (!p0.startsWith('0')) {
                          return 'start with 0';
                        }
                        if (p0.length < 8 || p0.length > 15) {
                          return 'minimum 8 number and maximum 15 number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ChangePasswordScreen.routeName);
                      },
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: MyColor.primaryMain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    PrimaryButton(
                      teks: 'Save Changes',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showAlert(context);
                        }
                      },
                      customChild: Consumer<EditProfileViewModel>(
                        builder: (context, value, _) {
                          if (value.state == MyState.loading) {
                            return SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: MyColor.white,
                                strokeWidth: 2,
                              ),
                            );
                          } else {
                            return Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: MyColor.white,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
