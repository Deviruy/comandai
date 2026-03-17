import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controlador responsável por gerenciar e persistir os dados do usuário.
/// Utiliza SharedPreferences para garantir que o usuário não precise
/// preencher seus dados em cada novo pedido.
class UserController extends ChangeNotifier {
  String _name = '';
  String _street = '';
  String _number = '';
  String _neighborhood = '';
  bool _isLoaded = false;

  String get name => _name;
  String get street => _street;
  String get number => _number;
  String get neighborhood => _neighborhood;
  bool get isLoaded => _isLoaded;

  /// Chaves para persistência no SharedPreferences
  static const String _keyName = 'user_name';
  static const String _keyStreet = 'user_street';
  static const String _keyNumber = 'user_number';
  static const String _keyNeighborhood = 'user_neighborhood';

  UserController() {
    loadUser();
  }

  /// Carrega os dados do usuário salvos localmente.
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_keyName) ?? '';
    _street = prefs.getString(_keyStreet) ?? '';
    _number = prefs.getString(_keyNumber) ?? '';
    _neighborhood = prefs.getString(_keyNeighborhood) ?? '';
    _isLoaded = true;
    notifyListeners();
  }

  /// Salva os dados do usuário localmente para uso futuro.
  Future<void> saveUser({
    required String name,
    required String street,
    required String number,
    required String neighborhood,
  }) async {
    _name = name;
    _street = street;
    _number = number;
    _neighborhood = neighborhood;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyStreet, street);
    await prefs.setString(_keyNumber, number);
    await prefs.setString(_keyNeighborhood, neighborhood);
    
    notifyListeners();
  }
}
