import 'package:flutter/material.dart';
import '../models/product_model.dart';

/// Define o modelo de um item dentro do carrinho de compras
class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

/// Controlador responsável pelo carrinho de compras do usuário
class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];
  String _orderDescription = '';

  List<CartItem> get items => _items;
  String get orderDescription => _orderDescription;

  set orderDescription(String value) {
    _orderDescription = value;
    notifyListeners();
  }

  /// Valor total dos itens no carrinho
  double get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  /// Contador de itens totais no carrinho
  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Adiciona um produto ao carrinho. Se o item já existe, aumenta a quantidade.
  void addItem(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  /// Diminui a quantidade de um item. Caso seja 1, o item é removido do carrinho.
  void decItem(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }

  /// Remove totalmente um item do carrinho
  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  /// Limpa todos os itens do carrinho (ex: finalização do pedido)
  void clear() {
    _items.clear();
    _orderDescription = '';
    notifyListeners();
  }
}
