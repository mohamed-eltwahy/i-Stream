import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/account_settings_screen.dart';
import 'package:streamit_flutter/screens/edit_profile_screen.dart';
import 'package:streamit_flutter/screens/help_screen.dart';
import 'package:streamit_flutter/screens/terms_conditions_screen.dart';
import 'package:streamit_flutter/utils/app_widgets.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';
import 'package:streamit_flutter/utils/resources/images.dart';
import 'package:streamit_flutter/utils/resources/size.dart';

class MoreFragment extends StatefulWidget {
  static String tag = '/MoreFragment';

  @override
  MoreFragmentState createState() => MoreFragmentState();
}

class MoreFragmentState extends State<MoreFragment> {
  var userName = "";
  var userEmail = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    userName = '${await getString(NAME)} ${await getString(LAST_NAME)}';
    userEmail = await getString(USER_EMAIL);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: toolBarTitle(context, 'More'),
        backgroundColor: Theme.of(context).cardColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Observer(
            builder: (_) => Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.only(left: spacing_standard_new, top: spacing_standard_new, right: 12, bottom: spacing_standard_new),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: spacing_standard_new,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                    child: commonCacheImageWidget(
                      appStore.userProfileImage.validate(),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ).visible(
                      appStore.userProfileImage.isNotEmpty,
                      defaultWidget: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        alignment: Alignment.center,
                        child: Icon(Icons.person_outline_rounded, size: 50, color: Colors.black),
                      ),
                    ),
                  ),
                  20.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        text(context, '${appStore.userFirstName} ${appStore.userLastName}', fontSize: ts_extra_normal, fontFamily: font_bold, textColor: Theme.of(context).textTheme.headline6.color),
                        text(context, userEmail, fontSize: ts_normal, fontFamily: font_medium, textColor: Theme.of(context).textTheme.subtitle2.color)
                      ],
                    ),
                  ),
                  Image.asset(
                    ic_edit_profile,
                    width: 20,
                    height: 20,
                    color: colorPrimary,
                  ).paddingAll(spacing_control).onTap(() {
                    EditProfileScreen().launch(context);
                  })
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(height: 0),
                  itemSubTitle(context, 'General Settings', colorThird: false).paddingOnly(left: spacing_standard_new, right: spacing_standard_new, top: 12, bottom: 12),
                  subType(context, "Account Settings", () {
                    AccountSettingsScreen().launch(context);
                  }, ic_settings),
                  subType(context, "Help", () {
                    HelpScreen().launch(context);
                  }, ic_help),
                  Divider(height: 0),
                  itemSubTitle(context, 'Terms').paddingOnly(left: spacing_standard_new, right: 12, top: spacing_standard_new, bottom: spacing_control),
                  subType(context, "Terms & Conditions", () {
                    TermsConditionsScreen().launch(context);
                  }, null),
                  subType(context, "Privacy & Policy", () {
                    TermsConditionsScreen().launch(context);
                  }, null),
                  subType(context, 'Logout', () async {
                    bool res = await showConfirmDialog(context, 'Do you want to logout?');

                    if (res ?? false) {
                      logout(context);
                    }
                  }, null, showTrailIcon: false),
                ],
              ).paddingBottom(spacing_large),
            ),
          )
        ],
      ),
    );
  }
}
