import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/screens/home_screen.dart';
import 'package:streamit_flutter/screens/splash_screen.dart';
import 'package:streamit_flutter/store/AppStore.dart';
import 'package:streamit_flutter/utils/app_theme.dart';
import 'package:streamit_flutter/utils/constants.dart';

AppStore appStore = AppStore();
int mAPIQueueCount = 0;
bool mIsLoggedIn = false;
int mUserId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  mUserId = await getInt(USER_ID);
  appStore.setUserProfile(await getString(USER_PROFILE));
  appStore.setFirstName(await getString(NAME));
  appStore.setLastName(await getString(LAST_NAME));

  setOrientationPortrait();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    updateGlobalColors(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        HomeScreen.tag: (BuildContext context) => HomeScreen(),
      },
      builder: scrollBehaviour(),
    );
  }
}

void updateGlobalColors(BuildContext context) {
  textPrimaryColorGlobal = Theme.of(context).textTheme.headline6.color;
}
