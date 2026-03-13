import 'package:flutter/material.dart';

/// Enumera os tipos de temas disponíveis para as lojas
enum StoreThemeType { pizzeria, sweets, acai }

/// Modelo que representa uma loja no sistema
class StoreModel {
  final String id;
  final String name;
  final String slug;
  final StoreThemeType themeType;
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;

  StoreModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.themeType,
    this.openTime,
    this.closeTime,
  });

  bool get isOpen {
    final oTime = openTime ?? const TimeOfDay(hour: 0, minute: 0);
    final cTime = closeTime ?? const TimeOfDay(hour: 23, minute: 59);

    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final openMinutes = oTime.hour * 60 + oTime.minute;
    final closeMinutes = cTime.hour * 60 + cTime.minute;

    if (closeMinutes < openMinutes) {
      // Aberto atravessando a meia-noite
      return nowMinutes >= openMinutes || nowMinutes <= closeMinutes;
    }
    return nowMinutes >= openMinutes && nowMinutes <= closeMinutes;
  }
}
