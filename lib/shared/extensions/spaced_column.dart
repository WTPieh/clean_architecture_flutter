import 'package:flutter/material.dart';

extension SpacedColumn on List<Widget> {
  Widget spacedColumn(
      {double spacing = 16,
      CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: spaced(spacing),
    );
  }

  List<Widget> spaced(double spacing) {
    return [
      for (int i = 0; i < length; i++) ...[
        this[i],
        if (i < length - 1) SizedBox(height: spacing),
      ],
    ];
  }
}

extension SpacedRow on List<Widget> {
  Widget spacedRow(
      {double spacing = 16,
      CrossAxisAlignment alignment = CrossAxisAlignment.center}) {
    return Row(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: spaced(spacing),
    );
  }

  List<Widget> spaced(double spacing) {
    return [
      for (int i = 0; i < length; i++) ...[
        this[i],
        if (i < length - 1) SizedBox(width: spacing),
      ],
    ];
  }
}
