import 'package:flutter/material.dart';

class HeaderArea extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isOpen;
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;

  const HeaderArea({
    super.key,
    required this.title,
    this.subtitle,
    required this.isOpen,
    this.openTime,
    this.closeTime,
  });

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '--:--';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final openStr = _formatTime(openTime);
    final closeStr = _formatTime(closeTime);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 960),
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    width: 2,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCsnobo7-XFGX8ZM6DVeivTUJyZ7RVkh4joOpEj1U2AsuDS9gHpwFPqH6M4sk4r0w1gx7_LmMB7yLf0gZgS3zJ9HTANQ5yb0RC2LE8MgeahA3ihJTPDSTW91G0SsVmYnUxgCP4LZD7Qds719UszcKWTHTelOYM1UlBK-ha891t3CMlvN0FoiQ6N5jEr59d253ybALFvBmjKTs40aldSzhQHS3RAaiowam9jUdP4c3r5WX6b0KrssdHZ1yHadVGAwAusq-nVqJHABLU',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                  letterSpacing: -0.5,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isOpen ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isOpen ? Colors.green[200]! : Colors.red[200]!,
                        ),
                      ),
                      child: Text(
                        isOpen ? '🟢 ABERTO' : '🔴 FECHADO',
                        style: TextStyle(
                          color: isOpen ? Colors.green : Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle ?? 'Pizzaria & Hamburgueria',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Hoje • $openStr - $closeStr',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  label: const Text(
                    'Localização',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat, color: Colors.green, size: 20),
                  label: const Text(
                    'WhatsApp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
