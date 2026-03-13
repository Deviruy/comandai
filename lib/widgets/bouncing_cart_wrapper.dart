import 'package:flutter/material.dart';

/// A widget that provides a bounce-in/bounce-out animation whenever a trigger
/// value (like the cart count) changes.
class BouncingCartWrapper extends StatefulWidget {
  final Widget child;
  final int triggerValue;

  const BouncingCartWrapper({
    super.key,
    required this.child,
    required this.triggerValue,
  });

  @override
  State<BouncingCartWrapper> createState() => _BouncingCartWrapperState();
}

class _BouncingCartWrapperState extends State<BouncingCartWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant BouncingCartWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.triggerValue > oldWidget.triggerValue) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
