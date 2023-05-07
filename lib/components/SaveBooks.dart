import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SaveBooks {
  static Future<void> saveBook(String book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> books = prefs.getStringList('savedBooks') ?? [];
    if (books.contains(book)) {
      return;
    }
    books.add(book);
    prefs.setStringList('savedBooks', books);
    log("Saved Books: $books");
  }

  static Future<List<Map<String, dynamic>>> getSavedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> lst = prefs.getStringList('savedBooks') ?? [];
    List<Map<String, dynamic>> decodedLst = [];
    lst.forEach((element) {
      decodedLst.add(Map<String, dynamic>.from(jsonDecode(element)));
    });
    return decodedLst;
  }

  static Future<void> removeSavedBook(String book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> books = prefs.getStringList('savedBooks') ?? [];
    if (!books.contains(book)) {
      return;
    }
    books.remove(book);
    prefs.setStringList('savedBooks', books);
  }

  static Future<void> clearSavedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedBooks', []);
  }
}
