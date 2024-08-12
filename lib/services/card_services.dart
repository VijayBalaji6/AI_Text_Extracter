import 'dart:convert';

import 'package:ai_text_extracter/model/bussiness_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardServices {
  static const _key = 'business_card';

  static Future<void> saveCard(BusinessCard card) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> tasks = pref.getStringList(_key) ?? [];

    tasks.add(card.toJson());

    await pref.setStringList(_key, tasks);
  }

  static Future<List<BusinessCard>> getAllSavedCards() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> cards = pref.getStringList(_key) ?? [];
    try {
      return cards.map((cardJson) {
        final Map<String, dynamic> decodedJson = jsonDecode(cardJson);
        return BusinessCard.fromMap(decodedJson);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
