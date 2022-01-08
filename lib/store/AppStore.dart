import 'package:mobx/mobx.dart';
import 'package:streamit_flutter/utils/constants.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  String selectedLanguage = mDefaultLanguage;

  @observable
  String userProfileImage = '';

  @observable
  String userFirstName = '';

  @observable
  String userLastName = '';

  @action
  void setLanguage(String aLanguage) {
    selectedLanguage = aLanguage;
  }

  @action
  void setUserProfile(String image) {
    userProfileImage = image;
  }

  @action
  void setFirstName(String name) {
    userFirstName = name;
  }

  @action
  void setLastName(String name) {
    userLastName = name;
  }
}
