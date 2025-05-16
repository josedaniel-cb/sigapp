import 'package:flutter/material.dart';

class FilterChipsWidget extends StatelessWidget {
  final bool showMandatory;
  final bool showElective;
  final ValueChanged<bool> onMandatoryChanged;
  final ValueChanged<bool> onElectiveChanged;
  const FilterChipsWidget({
    super.key,
    required this.showMandatory,
    required this.showElective,
    required this.onMandatoryChanged,
    required this.onElectiveChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: const Text('Obligatorios'),
          selected: showMandatory,
          onSelected: onMandatoryChanged,
          padding: const EdgeInsets.all(4),
        ),
        FilterChip(
          label: const Text('Electivos'),
          selected: showElective,
          onSelected: onElectiveChanged,
          padding: const EdgeInsets.all(4),
        ),
      ],
    );
  }
}
