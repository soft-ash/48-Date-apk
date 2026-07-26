import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_header.dart';

class NicknameHeader extends StatelessWidget {
  const NicknameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      title: 'Choose Your Nickname',
      subtitle:
          'This is the only name others will see. Make it mysterious, playful, memorable.',
    );
  }
}
