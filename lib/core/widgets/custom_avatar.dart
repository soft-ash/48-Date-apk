import 'package:flutter/material.dart';

import '../constant/colors.dart';
// import 'app_color.dart'; // Make sure to import your AppColor class

/// Defines the status badge to display on the bottom right of the avatar.
enum AvatarBadge { none, online, offline, verified }

class CustomAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String? initials;
  final IconData placeholderIcon;
  final AvatarBadge badge;
  final bool hasShadow;
  final bool hasBorder;

  const CustomAvatar({
    Key? key,
    this.size = 48.0, // Default size
    this.imageUrl,
    this.initials,
    this.placeholderIcon = Icons.person_outline,
    this.badge = AvatarBadge.none,
    this.hasShadow = false,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // --- 1. Main Avatar ---
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.gray100, // Background color for placeholders
            border: hasBorder
                ? Border.all(color: Colors.white, width: size * 0.05)
                : null,
            boxShadow: hasShadow
                ? [
                    BoxShadow(
                      color: AppColor.gray900.withValues(alpha: 0.08),
                      blurRadius: size * 0.3,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: _buildAvatarContent(),
        ),

        // --- 2. Status Badge ---
        if (badge != AvatarBadge.none)
          Positioned(bottom: 0, right: 0, child: _buildBadge()),
      ],
    );
  }

  /// Determines whether to show initials, an icon, or nothing (if image is present)
  Widget? _buildAvatarContent() {
    if (imageUrl != null) {
      return null; // Image handles its own rendering via DecorationImage
    }

    if (initials != null && initials!.isNotEmpty) {
      return Center(
        child: Text(
          initials!.toUpperCase(),
          style: TextStyle(
            color: AppColor.gray600,
            fontSize: size * 0.4, // Scales font size based on avatar size
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // Default to Icon Placeholder
    return Center(
      child: Icon(
        placeholderIcon,
        color: AppColor.gray400,
        size: size * 0.5, // Scales icon based on avatar size
      ),
    );
  }

  /// Builds the small status badge with a white cutout border
  Widget _buildBadge() {
    // Dynamically scale the badge size based on the avatar size
    double badgeSize = size * 0.28;
    if (badgeSize < 12) badgeSize = 12; // Minimum badge size

    Color badgeColor;
    Widget? icon;

    switch (badge) {
      case AvatarBadge.online:
        badgeColor = AppColor.success500; // Green dot
        break;
      case AvatarBadge.offline:
        badgeColor = const Color(0xFF7F56D9); // Purple dot
        break;
      case AvatarBadge.verified:
        badgeColor = AppColor.info500; // Blue verified check
        icon = Icon(Icons.check, color: Colors.white, size: badgeSize * 0.7);
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        // The white border creates the "cutout" effect over the avatar
        border: Border.all(color: Colors.white, width: badgeSize * 0.15),
      ),
      child: icon != null ? Center(child: icon) : null,
    );
  }
}
