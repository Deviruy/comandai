import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/cart_controller.dart';
import '../widgets/custom_button.dart';

/// Tela de finalização do pedido (Checkout)
class CheckoutScreen extends StatefulWidget {
  final String storeSlug;

  const CheckoutScreen({super.key, required this.storeSlug});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(title: const Text('Finalização do Pedido')),
      body: cartController.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Carrinho vazio',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(label: 'Voltar', onPressed: () => context.pop()),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Form(
                    key: _formKey,
                    child: Flex(
                      direction: isDesktop ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: isDesktop ? 2 : 0,
                          child: _buildFormFields(context),
                        ),
                        if (isDesktop) const SizedBox(width: 48),
                        if (!isDesktop) const SizedBox(height: 32),
                        Container(
                          width: isDesktop ? 350 : double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          child: _buildOrderSummary(context, cartController),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Endereço de Entrega',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Rua',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Complemento',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Forma de Pagamento',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: const [
            DropdownMenuItem(value: 'pix', child: Text('PIX')),
            DropdownMenuItem(value: 'cartao', child: Text('Cartão de Crédito')),
            DropdownMenuItem(
              value: 'dinheiro',
              child: Text('Dinheiro (Pagamento na Entrega)'),
            ),
          ],
          onChanged: (value) {},
          hint: const Text('Selecione'),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    CartController cartController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Resumo do Pedido',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal:'),
            Text(
              'R\$ ${cartController.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Taxa de Entrega:'),
            Text(
              'Grátis',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Divider(height: 32),
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
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        CustomButton(
          label: 'Confirmar Pedido',
          onPressed: () {
            // Simulação de finalização do pedido
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                title: const Text('Pedido Confirmado!'),
                content: const Text(
                  'Seu pedido foi recebido e está sendo preparado.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      cartController.clear();
                      Navigator.pop(ctx);
                      context.go('/${widget.storeSlug}');
                    },
                    child: const Text('Voltar ao início'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
