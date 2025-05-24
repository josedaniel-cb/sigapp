import 'package:flutter/material.dart';

class FilterResetButton extends StatelessWidget {
  final bool showMandatory;
  final bool showElective;
  final String approvalFilter;
  final VoidCallback onReset;

  const FilterResetButton({
    super.key,
    required this.showMandatory,
    required this.showElective,
    required this.approvalFilter,
    required this.onReset,
  });

  bool get _hasActiveFilters {
    return !showMandatory || !showElective || approvalFilter != 'todos';
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasActiveFilters) return const SizedBox.shrink();

    return TextButton.icon(
      onPressed: onReset,
      icon: const Icon(Icons.clear_all, size: 16),
      label: const Text('Limpiar filtros'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey.shade600,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
