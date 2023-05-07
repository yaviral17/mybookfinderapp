import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  static Future<List<String>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('searchHistory') ?? [];
  }

  static Future<void> setSearchHistory(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyList = prefs.getStringList('searchHistory') ?? [];
    if (historyList.contains(search)) {
      return;
    }
    historyList.add(search);

    prefs.setStringList('searchHistory', historyList);
  }

  static Future<void> removeSearchHistory(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyList = prefs.getStringList('searchHistory') ?? [];
    historyList.remove(search);
    prefs.setStringList('searchHistory', historyList);
  }
}
