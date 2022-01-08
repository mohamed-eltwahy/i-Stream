import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/home_screen.dart';
import 'package:streamit_flutter/screens/onboarding_screen.dart';
import 'package:streamit_flutter/screens/signin.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/images.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  void navigationPage() async {
    mIsLoggedIn = await getBool(isLoggedIn);

    if (mIsLoggedIn) {
      await validateToken().then((res) async {
        if (await getBool(isFirstTime, defaultValue: true)) {
          await setBool(isFirstTime, false);

          OnBoardingScreen().launch(context, isNewTask: true);
        } else {
          HomeScreen().launch(context, isNewTask: true);
        }
      }).catchError((e) async {
        log('Token Refreshing');

        Map req = {
          "username": await getString(USER_EMAIL),
          "password": await getString(PASSWORD),
        };

        await token(req).then((value) {
          HomeScreen().launch(context, isNewTask: true);
        }).catchError((e) {
          SignInScreen().launch(context, isNewTask: true);
        });
      });
    } else {
      HomeScreen().launch(context, isNewTask: true);
    }
  }

  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).splashColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              SizedBox(),
              Image.asset(ic_logo, height: 53),
              Loader(),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
