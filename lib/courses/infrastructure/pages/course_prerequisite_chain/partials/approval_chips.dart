import 'package:flutter/material.dart';

class ApprovalChipsWidget extends StatelessWidget {
  final String approvalFilter;
  final ValueChanged<String> onApprovalChanged;
  const ApprovalChipsWidget({
    super.key,
    required this.approvalFilter,
    required this.onApprovalChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ChoiceChip(
          label: const Text('Todos'),
          selected: approvalFilter == 'todos',
          onSelected: (v) => onApprovalChanged('todos'),
          padding: const EdgeInsets.all(4),
        ),
        ChoiceChip(
          label: const Text('Aprobados'),
          selected: approvalFilter == 'aprobado',
          onSelected: (v) => onApprovalChanged('aprobado'),
          padding: const EdgeInsets.all(4),
        ),
        ChoiceChip(
          label: const Text('No aprobados'),
          selected: approvalFilter == 'no_aprobado',
          onSelected: (v) => onApprovalChanged('no_aprobado'),
          padding: const EdgeInsets.all(4),
        ),
      ],
    );
  }
}
