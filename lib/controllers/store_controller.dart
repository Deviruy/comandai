import 'package:flutter/material.dart';
import '../models/store_model.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../core/constants/mock_data.dart';

/// Controlador responsável pelo estado da loja atual
class StoreController extends ChangeNotifier {
  StoreModel? currentStore;
  List<ProductModel> storeProducts = [];
  List<CategoryModel> storeCategories = [];
  bool isLoading = true;
  String? errorMessage;

  /// Carrega os dados da loja baseando-se no slug encontrado na URL
  void loadStoreBySlug(String slug) {
    isLoading = true;
    errorMessage = null;
    // O microtask garante que o carregamento da tela do flutter conclua antes de notificar alterações
    Future.microtask(() {
      try {
        final store = MockData.stores.firstWhere((s) => s.slug == slug);
        currentStore = store;
        storeProducts = MockData.products
            .where((p) => p.storeId == store.id)
            .toList();

        // Identificar dinamicamente as categorias baseadas nos produtos disponíveis
        final categoryIds = storeProducts.map((p) => p.categoryId).toSet();
        storeCategories = MockData.categories
            .where((c) => categoryIds.contains(c.id))
            .toList();
      } catch (e) {
        currentStore = null;
        storeProducts = [];
        storeCategories = [];
        errorMessage = 'Loja não encontrada';
      }

      isLoading = false;
      notifyListeners();
    });
  }
}
