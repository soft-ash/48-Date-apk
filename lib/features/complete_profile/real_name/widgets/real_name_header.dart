import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_header.dart';

class RealNameHeader extends StatelessWidget {
  const RealNameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      title: 'Your Real Name',
      subtitle:
          'Kept 100% private. Used only for verification and your safety never shown to other users.',
    );
  }
}
