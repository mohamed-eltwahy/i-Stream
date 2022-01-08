import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/network/network_utils.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/images.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

class EditProfileScreen extends StatefulWidget {
  static String tag = '/ProfileScreen';

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool isRemember = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  bool autoValidate = false;

  var userProfile = '';

  File imageFile;
  bool isLoading = false;

  bool loadFromFile = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    firstNameController.text = await getString(NAME);
    lastNameController.text = await getString(LAST_NAME);
    emailController.text = await getString(USER_EMAIL);
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(Icons.add, color: Colors.red),
    );
    if (image != null) {
      setState(() {
        imageFile = image;
        loadFromFile = true;
      });
    }
  }

  Future save() async {
    isLoading = true;
    setState(() {});

    var multiPartRequest = await getMultiPartRequest('streamit-api/api/v1/streamit/update-profile');

    multiPartRequest.fields['first_name'] = firstNameController.text.trim();
    multiPartRequest.fields['last_name'] = lastNameController.text.trim();
    if (imageFile != null) multiPartRequest.fields['profile_image'] = base64Encode(imageFile.readAsBytesSync());

    multiPartRequest.headers.addAll(await buildTokenHeader());

    await multiPartRequest.send().then((res) async {
      isLoading = false;
      setState(() {});

      if (res != null) {
        res.stream.transform(utf8.decoder).listen((value) async {
          log(jsonDecode(value));
          Map res = jsonDecode(value);

          await setString(NAME, res['first_name']);
          await setString(LAST_NAME, res['last_name']);
          if (res['profile_image'] != null) await setString(USER_PROFILE, res['profile_image']);

          if (res['profile_image'] != null) appStore.setUserProfile(res['profile_image']);
          appStore.setFirstName(res['first_name']);
          appStore.setLastName(res['last_name']);

          finish(context);
        });
      }
    }).catchError((e) {
      isLoading = false;
      setState(() {});

      log(e);
      toast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget profilePhoto = Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: spacing_standard_new,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: loadFromFile
                      ? Image.file(imageFile, height: 95, width: 95, fit: BoxFit.cover)
                      : appStore.userProfileImage.validate().isNotEmpty
                          ? commonCacheImageWidget(appStore.userProfileImage,height: 95,width: 95,fit: BoxFit.cover)
                          : commonCacheImageWidget(ic_profile, width: 95, height: 95,fit: BoxFit.cover),
                ),
                text(context, 'Change Avatar', textColor: Theme.of(context).textTheme.headline6.color, fontFamily: font_bold, fontSize: ts_medium).paddingTop(spacing_standard_new)
              ],
            ).paddingOnly(top: 16))
        .onTap(() {
      getImage(ImgSource.Both);
    });

    Widget fields = Form(
      key: formKey,
      autovalidate: autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formField(
            context,
            "First Name",
            controller: firstNameController,
            nextFocus: lastNameFocusNode,
            validator: (value) {
              return value.isEmpty ? 'Name is required' : null;
            },
            suffixIcon: Icons.person_outline,
          ).paddingBottom(spacing_standard_new),
          formField(
            context,
            "Last Name",
            controller: lastNameController,
            focusNode: lastNameFocusNode,
            nextFocus: emailFocusNode,
            validator: (value) {
              return value.isEmpty ? 'Name is required' : null;
            },
            suffixIcon: Icons.person_outline,
          ).paddingBottom(spacing_standard_new),
          formField(
            context,
            "Email",
            controller: emailController,
            focusNode: emailFocusNode,
            suffixIcon: Icons.mail_outline,
            textInputAction: TextInputAction.done,
            isEnabled: false,
          ).paddingBottom(spacing_standard_new),
        ],
      ),
    ).paddingOnly(left: spacing_standard_new, right: spacing_standard_new, top: 36);

    return Scaffold(
      appBar: appBarLayout(context, 'Edit Profile'),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profilePhoto,
                fields,
                SizedBox(
                  width: double.infinity,
                  child: button(
                    context,
                    'Save',
                    onTap: () {
                      if (isLoading) {
                        return;
                      }

                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        save();
                      } else {
                        setState(() => autoValidate = true);
                      }
                    },
                  ).paddingOnly(top: 30, left: 18, right: 18, bottom: 30),
                )
              ],
            ),
          ),
          loadingWidgetMaker().visible(isLoading)
        ],
      ),
    );
  }
}
