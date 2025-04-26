import 'package:flutter/material.dart';

class SquareCard extends StatelessWidget {
  final String title;
  final String gridSize;
  final VoidCallback onTap;

  const SquareCard({
    super.key,
    required this.title,
    required this.gridSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withAlpha(100),
              theme.colorScheme.primary.withAlpha(180),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withAlpha(80),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.agriculture,
              size: theme.iconTheme.size ?? 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              gridSize,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onPrimary.withAlpha(220),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
