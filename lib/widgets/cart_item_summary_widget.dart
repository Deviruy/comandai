import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

/// Widget que exibe o resumo de um item do carrinho,
/// incluindo controles de quantidade (+ e -).
class CartItemSummaryWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemSummaryWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'R\$ ${cartItem.product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    context.read<CartController>().decItem(cartItem.product);
                  },
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    context.read<CartController>().addItem(cartItem.product);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'R\$ ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
