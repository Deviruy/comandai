/// Modelo que representa um produto no cardápio de uma loja
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String
  category; // Categoria descritiva (ex: Pizzas, Bebidas, Sobremesas)
  final String storeId;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.category,
    required this.storeId,
  });
}
