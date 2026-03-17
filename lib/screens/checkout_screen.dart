import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/cart_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_button.dart';

/// Tela de finalização do pedido (Checkout) redesenhada com Stitch.
/// Esta tela coleta os dados do cliente, endereço e forma de pagamento
/// antes de enviar o pedido final via WhatsApp.
class CheckoutScreen extends StatefulWidget {
  final String storeSlug;

  const CheckoutScreen({super.key, required this.storeSlug});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para os campos do formulário
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _neighborhoodController = TextEditingController();

  String _paymentMethod = 'pix';

  @override
  void initState() {
    super.initState();
    // Inicia a escuta das mudanças no UserController para preencher os campos
    // assim que os dados forem carregados do SharedPreferences.
    final userController = context.read<UserController>();
    
    if (userController.isLoaded) {
      _populateFields(userController);
    } else {
      userController.addListener(_onUserLoaded);
    }
  }

  /// Callback chamado quando os dados do usuário terminam de carregar.
  void _onUserLoaded() {
    final userController = context.read<UserController>();
    if (userController.isLoaded) {
      _populateFields(userController);
      userController.removeListener(_onUserLoaded);
    }
  }

  /// Preenche os campos de texto com os dados do controlador.
  void _populateFields(UserController userController) {
    if (mounted) {
      setState(() {
        _nameController.text = userController.name;
        _streetController.text = userController.street;
        _numberController.text = userController.number;
        _neighborhoodController.text = userController.neighborhood;
      });
    }
  }

  @override
  void dispose() {
    // Garante que o listener seja removido para evitar vazamento de memória
    context.read<UserController>().removeListener(_onUserLoaded);
    // Libera os recursos dos controladores ao fechar a tela
    _nameController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _neighborhoodController.dispose();
    super.dispose();
  }

  /// Gera a mensagem formatada e abre o WhatsApp para o número configurado.
  Future<void> _sendWhatsApp() async {
    if (!_formKey.currentState!.validate()) return;

    final cartController = context.read<CartController>();
    final userController = context.read<UserController>();
    final phoneNumber = '67999027513';

    // Salva os dados atuais do usuário localmente para os próximos pedidos
    await userController.saveUser(
      name: _nameController.text,
      street: _streetController.text,
      number: _numberController.text,
      neighborhood: _neighborhoodController.text,
    );

    // Formata a lista de itens do carrinho
    String itemsText = cartController.items
        .map((item) {
          return '*${item.quantity}x ${item.product.name}* - R\$ ${(item.product.price * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}';
        })
        .join('\n');

    // Mapeia o ID do método de pagamento para um nome amigável
    String paymentDisplay = '';
    switch (_paymentMethod) {
      case 'pix':
        paymentDisplay = 'PIX';
        break;
      case 'cartao':
        paymentDisplay = 'Cartão (Entrega)';
        break;
      case 'dinheiro':
        paymentDisplay = 'Dinheiro';
        break;
    }

    // Constrói a mensagem completa do pedido
    String message = '*NOVO PEDIDO*\n'
        '--------------------------\n\n'
        '*CLIENTE*\n'
        'Nome: ${_nameController.text}\n\n'
        '*ENTREGA*\n'
        'Endereço: ${_streetController.text}, ${_numberController.text}\n'
        'Bairro: ${_neighborhoodController.text}\n\n'
        '*ITENS*\n'
        '$itemsText\n\n'
        '*PAGAMENTO*\n'
        'Método: $paymentDisplay\n\n';

    if (cartController.orderDescription.isNotEmpty) {
      message += '*OBSERVAÇÕES*\n'
          '${cartController.orderDescription}\n\n';
    }

    message += '💰 *TOTAL: R\$ ${cartController.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}*';

    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o WhatsApp')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Finalizar Pedido',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: cartController.items.isEmpty
          ? Center(child: const Text('Seu carrinho está vazio.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Seção de dados pessoais
                        _buildSectionCard(
                          title: 'Seus Dados',
                          icon: Icons.person_outline,
                          children: [
                            _buildTextField(
                              label: 'Nome Completo',
                              controller: _nameController,
                              validator: (v) =>
                                  v!.isEmpty ? 'Obrigatório' : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Seção de endereço
                        _buildSectionCard(
                          title: 'Endereço de Entrega',
                          icon: Icons.location_on_outlined,
                          children: [
                            _buildTextField(
                              label: 'Rua / Logradouro',
                              controller: _streetController,
                              validator: (v) =>
                                  v!.isEmpty ? 'Obrigatório' : null,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildTextField(
                                    label: 'Nº',
                                    controller: _numberController,
                                    validator: (v) =>
                                        v!.isEmpty ? 'Obrigatório' : null,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: _buildTextField(
                                    label: 'Bairro',
                                    controller: _neighborhoodController,
                                    validator: (v) =>
                                        v!.isEmpty ? 'Obrigatório' : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Seção de pagamento
                        _buildSectionCard(
                          title: 'Forma de Pagamento',
                          icon: Icons.payment_outlined,
                          children: [
                            _buildPaymentOption(
                              id: 'pix',
                              label: 'PIX (Instante)',
                              icon: Icons.qr_code_scanner,
                            ),
                            _buildPaymentOption(
                              id: 'cartao',
                              label: 'Cartão na Entrega',
                              icon: Icons.credit_card,
                            ),
                            _buildPaymentOption(
                              id: 'dinheiro',
                              label: 'Dinheiro',
                              icon: Icons.payments_outlined,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Resumo financeiro
                        _buildSummary(cartController, colorScheme),
                        const SizedBox(height: 32),
                        // Botão de ação principal
                        CustomButton(
                          label: 'Concluir Pedido no WhatsApp',
                          onPressed: _sendWhatsApp,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  /// Constrói um cartão de seção com ícone e título.
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  /// Constrói um campo de texto estilizado.
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
    );
  }

  /// Constrói uma opção de pagamento selecionável.
  Widget _buildPaymentOption({
    required String id,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _paymentMethod == id;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.05) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? primaryColor : Colors.grey[600]),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primaryColor : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: primaryColor, size: 20),
          ],
        ),
      ),
    );
  }

  /// Constrói o resumo de valores (subtotal, taxa, total).
  Widget _buildSummary(CartController cartController, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(color: Colors.grey)),
              Text(
                'R\$ ${cartController.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Taxa de Entrega', style: TextStyle(color: Colors.grey)),
              Text(
                'Grátis',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

