import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/store_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/header_area.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/bouncing_cart_wrapper.dart';
import '../core/constants/mock_data.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

/// Tela principal do cardápio digital (responsiva e fiel ao Stitch web com categorias isoladas e ícones)
class MenuScreen extends StatefulWidget {
  final String storeSlug;

  const MenuScreen({super.key, required this.storeSlug});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreController>().loadStoreBySlug(widget.storeSlug);
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeController = context.watch<StoreController>();
    final cartController = context.watch<CartController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    if (storeController.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (storeController.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/error');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final store = storeController.currentStore!;
    final products = storeController.storeProducts;

    // Calcula as categorias que de fato tem produtos nessa loja e os filtra
    final Set<String> activeCategoryIds = products
        .map((p) => p.categoryId)
        .toSet();
    final List<CategoryModel> storeCategories = MockData.categories
        .where((cat) => activeCategoryIds.contains(cat.id))
        .toList();

    final bool hasSearchResults =
        _searchQuery.isEmpty ||
        products.any((p) => p.name.toLowerCase().contains(_searchQuery));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // HEADER AREA
              SliverToBoxAdapter(
                child: Center(
                  child: HeaderArea(
                    title: store.name,
                    subtitle: 'Pizzaria & Hamburgueria',
                    isOpen: store.isOpen,
                    openTime: store.openTime,
                    closeTime: store.closeTime,
                  ),
                ),
              ),

              // PROMO CAROUSEL (Combo Família)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildPromoCard(
                          context,
                          'Combo Família',
                          '2 Pizzas + Refri',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAS0wEeJpQTs9R38Gt-CjUObMxTsq_aJTwTLXYWt4EAhgO0MsaGwfjk6LAYs_VFnXnsvn7DEKzd9VE9Cmwe8r3BBieJGWb-FBMbMcpIjvnRTP37wsHuHxfvW7b_GVvdH4a8WNlOOP0sCkvPQLSZ_ZLWwdjZW_of1Kgb8ZsD6KSnJndjaMdNO73kxWJN3QPiSmrYnd0ZHEPAIBXYAh3oJkTVWgDj3IDmo9aVKuCU0zfs_nMUcZ8urEKxdD-8q1ZnJMkyCvLgsL_6njk',
                          isDesktop,
                        ),
                        const SizedBox(width: 16),
                        _buildPromoCard(
                          context,
                          '15% OFF',
                          'Promoção do Dia',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuD0y9nl_d6q8nNbzxEThlalQLphEEXiAp3aGb05CrysC2o-2wzKyNSSIOsRCJ2gjupjeIb1Xf-U1nUXMLja603Wwim2D9NiZbzBQRwbwgs4vshqeE25junwNraQc91xbHmukSnOoEx292ppetfxRhaB2jk5qaGoLng8MCjHFK3TQjgHprCGKiF3PYslHTotfYHhsH4N-Huczk3P91rMMkDp-5W6Q5-0CEoMmmyG2WZQIeXrtmOFr8ygFJcMNmHbSgSkUzwlcsXbcqk',
                          isDesktop,
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              ),

              // SEARCH FIELD
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'O que você quer comer hoje?',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          // Subtle shadow
                          // The easiest way to add a shadow to a TextField is wrapping it in a Material or Container,
                          // but since it's asked to have a pleasant design:
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // DYNAMIC PRODUCT SECTIONS BASED ON CATEGORIES
              // Mostra todas as categorias presentes na loja sequencialmente
              ...storeCategories
                  .map((cat) {
                    final catProducts = products
                        .where(
                          (p) =>
                              p.categoryId == cat.id &&
                              p.name.toLowerCase().contains(_searchQuery),
                        )
                        .toList();

                    if (catProducts.isEmpty) {
                      return <Widget>[]; // If empty, don't return anything
                    }

                    return [
                      // PRODUCTS TITLE FOR THIS CATEGORY (Center-aligned)
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 960),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                32,
                                16,
                                16,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Left-aligned title
                                children: [
                                  Container(
                                    width: 6,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    cat.icon,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    cat.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // PRODUCTS LIST/GRID FOR THIS CATEGORY (Center-aligned)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: SliverToBoxAdapter(
                          child: Align(
                            alignment: isDesktop
                                ? Alignment.centerLeft
                                : Alignment
                                      .centerLeft, // Left aligned grid/list
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 960),
                              child: isDesktop
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 2.5,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            mainAxisExtent:
                                                140, // Fixed height for exact Stitch spacing
                                          ),
                                      itemCount: catProducts.length,
                                      itemBuilder: (context, index) =>
                                          ProductCardWidget(
                                            product: catProducts[index],
                                            onTap: () => _showProductDetails(
                                              context,
                                              catProducts[index],
                                            ),
                                          ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: catProducts.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16.0,
                                        ),
                                        child: ProductCardWidget(
                                          product: catProducts[index],
                                          onTap: () => _showProductDetails(
                                            context,
                                            catProducts[index],
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  })
                  .expand((i) => i),

              if (!hasSearchResults)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum resultado encontrado.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // BOTTOM SPACING FOR FLOATING BUTTON
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // FLOATING CART BUTTON (Stitch style)
          if (cartController.itemCount > 0)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: BouncingCartWrapper(
                triggerValue: cartController.itemCount,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: InkWell(
                      onTap: () => context.push('/${store.slug}/cart'),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Carrinho',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${cartController.itemCount} itens',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'R\$ ${cartController.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoCard(
    BuildContext context,
    String title,
    String subtitle,
    String imageUrl,
    bool isDesktop,
  ) {
    return Container(
      width: isDesktop ? 400 : MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.black.withValues(alpha: 0.2),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context, ProductModel product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(ctx).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                        color: Theme.of(ctx).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Theme.of(ctx).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.read<CartController>().addItem(product);
                        Navigator.pop(ctx);
                      },
                      child: const Text(
                        'Adicionar ao Carrinho',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
