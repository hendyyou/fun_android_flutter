import 'package:flutter/material.dart';
import 'package:fun_android/config/storage_manager.dart';

class LocaleModel extends ChangeNotifier {
  static const localeNameList = ['跟随系统', '中文', '英文'];
  static const localeValueList = ['', 'zh-CN', 'en'];

  //
  static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex;

  int get localeIndex => _localeIndex;

  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex = StorageManager.sharedPreferences.getInt(kLocaleIndex) ?? 1;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    StorageManager.sharedPreferences.setInt(kLocaleIndex, index);
  }
}
