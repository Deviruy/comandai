import 'package:flutter/material.dart';
import '../../models/store_model.dart';
import '../../models/product_model.dart';
import '../../models/category_model.dart';

/// Classe de dados estáticos para simular o backend
class MockData {
  /// Lista de lojas com diferentes temas e horários (Loja 1 abre às 18h)
  static final List<StoreModel> stores = [
    StoreModel(
      id: '1',
      name: 'Ana Pizzaria',
      slug: 'loja-da-ana-1234',
      themeType: StoreThemeType.pizzeria,
      openTime: const TimeOfDay(hour: 18, minute: 0),
      closeTime: const TimeOfDay(hour: 23, minute: 30),
    ),
    StoreModel(
      id: '2',
      name: 'Doces da Maria',
      slug: 'doces-da-maria-5678',
      themeType: StoreThemeType.sweets,
      openTime: const TimeOfDay(hour: 10, minute: 0),
      closeTime: const TimeOfDay(hour: 20, minute: 0),
    ),
    StoreModel(
      id: '3',
      name: 'Açaí do Zé',
      slug: 'acai-do-joao-9012',
      themeType: StoreThemeType.acai,
      openTime: const TimeOfDay(hour: 13, minute: 0),
      closeTime: const TimeOfDay(hour: 22, minute: 0),
    ),
  ];

  /// Lista global de categorias simuladas com 6 novas categorias de pizza.
  static final List<CategoryModel> categories = [
    // Original Categories for Pizza Store (Extended)
    CategoryModel(id: 'c1', name: 'Pizzas Clássicas', icon: Icons.local_pizza),
    CategoryModel(id: 'c_p2', name: 'Pizzas Especiais', icon: Icons.star),
    CategoryModel(id: 'c_p3', name: 'Pizzas Premium', icon: Icons.diamond),
    CategoryModel(id: 'c_p4', name: 'Pizzas Veganas', icon: Icons.eco),
    CategoryModel(id: 'c_p5', name: 'Pizzas Gigantes', icon: Icons.add_circle),
    CategoryModel(
      id: 'c_p6',
      name: 'Pizzas Familiares',
      icon: Icons.family_restroom,
    ),
    CategoryModel(id: 'c_p7', name: 'Promoções Pizza', icon: Icons.local_offer),

    // Other original categories
    CategoryModel(id: 'c2', name: 'Hambúrgueres', icon: Icons.lunch_dining),
    CategoryModel(id: 'c3', name: 'Bebidas', icon: Icons.local_cafe),
    CategoryModel(id: 'c4', name: 'Sobremesas', icon: Icons.icecream),
    CategoryModel(id: 'c5', name: 'Pizzas Doces', icon: Icons.cake),
    CategoryModel(id: 'c6', name: 'Açaí', icon: Icons.ac_unit),

    // New test categories for scrolling
    CategoryModel(id: 'c7', name: 'Entradas', icon: Icons.tapas),
    CategoryModel(id: 'c8', name: 'Porções', icon: Icons.fastfood),
    CategoryModel(id: 'c9', name: 'Calzones', icon: Icons.bakery_dining),
    CategoryModel(id: 'c10', name: 'Combos Especiais', icon: Icons.stars),
  ];

  /// Lista global de produtos simulados
  static final List<ProductModel> products = [
    // --- PRODUTOS: LOJA ANA PIZZARIA ---

    // 1. Pizzas Clássicas
    ProductModel(
      id: 'p1',
      name: 'Pizza Marguerita Média',
      description: 'Molho de tomate fresco, mussarela especial e manjericão.',
      price: 54.90,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c1',
      category: 'Pizzas Clássicas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p2',
      name: 'Pizza Calabresa Média',
      description: 'Molho artesanal, queijo mussarela, calabresa e cebola.',
      price: 49.90,
      imageUrl:
          'https://images.unsplash.com/photo-1541745537411-b8046f4d86eb?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c1',
      category: 'Pizzas Clássicas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p3',
      name: 'Pizza Mussarela',
      description: 'Muito queijo mussarela e orégano.',
      price: 42.90,
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c1',
      category: 'Pizzas Clássicas',
      storeId: '1',
    ),

    // 2. Pizzas Especiais
    ProductModel(
      id: 'p4',
      name: 'Pizza Pepperoni Especial',
      description: 'Mussarela, fatias de pepperoni premium e borda recheada.',
      price: 79.90,
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p2',
      category: 'Pizzas Especiais',
      storeId: '1',
    ),
    ProductModel(
      id: 'p5',
      name: 'Pizza Quatro Queijos',
      description: 'Mussarela, provolone, parmesão e gorgonzola.',
      price: 75.90,
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p2',
      category: 'Pizzas Especiais',
      storeId: '1',
    ),
    ProductModel(
      id: 'p6',
      name: 'Pizza Frango com Catupiry',
      description: 'Frango desfiado temperado coberto pelo legítimo catupiry.',
      price: 69.90,
      imageUrl:
          'https://images.unsplash.com/photo-1541745537411-b8046f4d86eb?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p2',
      category: 'Pizzas Especiais',
      storeId: '1',
    ),

    // 3. Pizzas Premium
    ProductModel(
      id: 'p_p1',
      name: 'Pizza Parma com Rúcula',
      description:
          'Molho pelati, mussarela de búfala, presunto parma, rúcula e tomate seco.',
      price: 95.90,
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p3',
      category: 'Pizzas Premium',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_p2',
      name: 'Pizza Burrata',
      description:
          'Molho artesanal, burrata inteira no meio, pesto e manjericão.',
      price: 98.90,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p3',
      category: 'Pizzas Premium',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_p3',
      name: 'Pizza Camarão Especial',
      description: 'Camarões refogados no azeite, alho poró e cream cheese.',
      price: 110.00,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p3',
      category: 'Pizzas Premium',
      storeId: '1',
    ),

    // 4. Pizzas Veganas
    ProductModel(
      id: 'p_v1',
      name: 'Pizza Marguerita Vegana',
      description:
          'Queijo de castanhas, molho fresco, tomate cereja e manjericão.',
      price: 69.90,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p4',
      category: 'Pizzas Veganas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_v2',
      name: 'Pizza Cogumelos',
      description: 'Shitake, shimeji e champignon no shoyu com alho poró.',
      price: 82.90,
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p4',
      category: 'Pizzas Veganas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_v3',
      name: 'Pizza Brócolis e Alho Fresco',
      description:
          'Brócolis frescos puxados no azeite com lâminas de alho e requeijão vegano.',
      price: 74.90,
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p4',
      category: 'Pizzas Veganas',
      storeId: '1',
    ),

    // 5. Pizzas Gigantes (45cm)
    ProductModel(
      id: 'p_g1',
      name: 'Gigante Napolitana',
      description:
          '45cm de pura mussarela, tomate fresco, alho frito e parmesão.',
      price: 115.00,
      imageUrl:
          'https://images.unsplash.com/photo-1541745537411-b8046f4d86eb?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p5',
      category: 'Pizzas Gigantes',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_g2',
      name: 'Gigante Calabresa com Catupiry',
      description: '45cm de calabresa defumada acebolada coberta com catupiry.',
      price: 125.00,
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p5',
      category: 'Pizzas Gigantes',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_g3',
      name: 'Gigante Mista',
      description: 'Escolha até 4 sabores inteiros de nossas pizzas clássicas.',
      price: 135.00,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p5',
      category: 'Pizzas Gigantes',
      storeId: '1',
    ),

    // 6. Pizzas Familiares (Até 5 Pessoas)
    ProductModel(
      id: 'p_f1',
      name: 'Familiar Portuguesa',
      description: 'Presunto, queijo, ovos, cebola, ervilha, azeitonas. 50cm.',
      price: 140.00,
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p6',
      category: 'Pizzas Familiares',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_f2',
      name: 'Familiar Frango Suprema',
      description: 'Frango, bacon, milho, catupiry e mussarela dupla.',
      price: 145.00,
      imageUrl:
          'https://images.unsplash.com/photo-1541745537411-b8046f4d86eb?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p6',
      category: 'Pizzas Familiares',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_f3',
      name: 'Familiar Baiana Apimentada',
      description:
          'Peperoni, pimenta calabresa, cebola e ovos em 50cm de massa.',
      price: 142.00,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p6',
      category: 'Pizzas Familiares',
      storeId: '1',
    ),

    // 7. Promoções Pizza
    ProductModel(
      id: 'p_pr1',
      name: 'Combo 2x Pizzas Clássicas',
      description: 'Compre 2 pizzas do menu clássico por um preço especial.',
      price: 89.90,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p7',
      category: 'Promoções Pizza',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_pr2',
      name: 'Pizza Especial + Guaraná 2L',
      description: 'Qualquer pizza especial acompanhada de Guaraná.',
      price: 82.90,
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p7',
      category: 'Promoções Pizza',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_pr3',
      name: 'Promo Universitária',
      description: 'Pizzinha brotinho de calabresa e lata de refri.',
      price: 29.90,
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c_p7',
      category: 'Promoções Pizza',
      storeId: '1',
    ),

    // BEBIDAS (Store 1)
    ProductModel(
      id: 'p7_b',
      name: 'Coca-Cola 2L',
      description: 'Refrigerante gelado grande.',
      price: 12.00,
      imageUrl:
          'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c3',
      category: 'Bebidas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p8_b',
      name: 'Guaraná Antarctica 2L',
      description: 'Refrigerante gelado grande.',
      price: 11.50,
      imageUrl:
          'https://images.unsplash.com/photo-1556881286-fc6915169721?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c3',
      category: 'Bebidas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p9_b',
      name: 'Suco de Laranja Natural',
      description: '500ml de suco de laranja natural feito na hora.',
      price: 8.50,
      imageUrl:
          'https://images.unsplash.com/photo-1613478223719-2ab802602423?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c3',
      category: 'Bebidas',
      storeId: '1',
    ),

    // NEW CATEGORIES - DUMMY PRODUCTS FOR STORE 1
    ProductModel(
      id: 'p_new1',
      name: 'Pão de Alho Supremo',
      description: 'Pão de alho recheado com creme de queijo.',
      price: 18.90,
      imageUrl:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c7',
      category: 'Entradas',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_new2',
      name: 'Batata Frita Rústica',
      description: 'Porção de 500g de batata com cheddar e bacon.',
      price: 35.00,
      imageUrl:
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c8',
      category: 'Porções',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_new3',
      name: 'Calzone de Calabresa',
      description: 'Massa fechada recheada com queijo, calabresa e catupiry.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1541745537411-b8046f4d86eb?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c9',
      category: 'Calzones',
      storeId: '1',
    ),
    ProductModel(
      id: 'p_new4',
      name: 'Mega Combo Sextou',
      description: '2 Pizzas Gigantes + 1 Porção de Batata + Refri 2L.',
      price: 189.90,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c10',
      category: 'Combos Especiais',
      storeId: '1',
    ),

    // --- PRODUTOS: LOJA DOCES DA MARIA ---
    ProductModel(
      id: 'p10',
      name: 'Pizza de Chocolate com Morango',
      description: 'Massa doce com creme de avelã e morangos frescos.',
      price: 49.90,
      imageUrl:
          'https://images.unsplash.com/photo-1541745537411-b8046f4d86eb?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c5',
      category: 'Pizzas Doces',
      storeId: '2',
    ),
    ProductModel(
      id: 'p13',
      name: 'Bolo de Morango com Chantilly',
      description:
          'Fatia generosa de bolo de massa branca com recheio de morango.',
      price: 18.00,
      imageUrl:
          'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c4',
      category: 'Sobremesas',
      storeId: '2',
    ),
    ProductModel(
      id: 'p16',
      name: 'Fanta Laranja Lata',
      description: 'Fanta laranja 350ml super gelada.',
      price: 6.00,
      imageUrl:
          'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c3',
      category: 'Bebidas',
      storeId: '2',
    ),

    // --- PRODUTOS: LOJA AÇAÍ DO ZÉ ---
    ProductModel(
      id: 'p19',
      name: 'Açaí Tradicional 500ml',
      description: 'Açaí batido com xarope, acompanhado de banana e granola.',
      price: 24.90,
      imageUrl:
          'https://images.unsplash.com/photo-1559811814-e2c349be8bf7?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c6',
      category: 'Açaí',
      storeId: '3',
    ),
    ProductModel(
      id: 'p22',
      name: 'Creme de Cupuaçu',
      description: 'Creme super gelado de cupuaçu com frutas.',
      price: 26.00,
      imageUrl:
          'https://images.unsplash.com/photo-1563805042-7684c8a9e9ce?q=80&w=400&auto=format&fit=crop',
      categoryId: 'c4',
      category: 'Sobremesas',
      storeId: '3',
    ),
  ];
}
