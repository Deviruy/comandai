import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_summary_widget.dart';
import '../widgets/custom_button.dart';

/// Tela do carrinho de compras
class CartScreen extends StatelessWidget {
  final String storeSlug;

  const CartScreen({super.key, required this.storeSlug});

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Carrinho')),
      body: cartController.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Seu carrinho está vazio.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    label: 'Voltar ao Cardápio',
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isDesktop ? 2 : 1,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cartController.items.length,
                    itemBuilder: (context, index) {
                      final item = cartController.items[index];
                      return CartItemSummaryWidget(cartItem: item);
                    },
                  ),
                ),
                if (isDesktop)
                  Expanded(
                    flex: 1,
                    child: _buildSummaryPanel(context, cartController),
                  ),
              ],
            ),
      bottomNavigationBar: !isDesktop && cartController.items.isNotEmpty
          ? BottomAppBar(
              height: 120,
              child: _buildSummaryPanel(
                context,
                cartController,
                isMobile: true,
              ),
            )
          : null,
    );
  }

  Widget _buildSummaryPanel(
    BuildContext context,
    CartController cartController, {
    bool isMobile = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isMobile
            ? Colors.transparent
            : Theme.of(context).colorScheme.surface,
        border: isMobile
            ? null
            : Border(
                left: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'R\$ ${cartController.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            label: 'Finalizar Pedido',
            onPressed: () {
              context.push('/$storeSlug/checkout');
            },
          ),
        ],
      ),
    );
  }
}
