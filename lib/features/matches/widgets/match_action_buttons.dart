import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/matches_controller.dart';
import '../models/match_model.dart';

class MatchActionButtons extends StatelessWidget {
  final MatchModel match;

  const MatchActionButtons({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();
    final status = match.status;

    List<Widget> buttons = [];

    if (status == MatchStatus.active || status == MatchStatus.expiringSoon) {
      buttons = [
        _buildActionButton(
          label: "Message",
          icon: Icons.chat_bubble_outline,
          color: AppColor.gray800,
          onTap: () => controller.openMessage(match),
        ),
        _buildDivider(),
        _buildActionButton(
          label: "Plan Date",
          icon: Icons.calendar_today_rounded,
          color: AppColor.primary500,
          isBold: true,
          onTap: () => controller.planDate(match),
        ),
        _buildDivider(),
        _buildActionButton(
          label: "View Details",
          color: AppColor.gray600,
          onTap: () => controller.viewDetails(match),
        ),
      ];
    } else if (status == MatchStatus.dateSet) {
      buttons = [
        _buildActionButton(
          label: "Cancel",
          icon: Icons.settings_outlined,
          color: AppColor.gray700,
          onTap: () => controller.cancelDate(match),
        ),
        _buildDivider(),
        _buildActionButton(
          label: "Rate Date",
          icon: Icons.star_rounded,
          color: AppColor.warning500,
          textColor: AppColor.warning600,
          isBold: true,
          onTap: () => controller.rateDate(match),
        ),
        _buildDivider(),
        _buildActionButton(
          label: "View Details",
          color: AppColor.gray600,
          onTap: () => controller.viewDetails(match),
        ),
      ];
    } else {
      // dateComplete or cancelled
      buttons = [
        _buildActionButton(
          label: "Rate Date",
          icon: Icons.star_rounded,
          color: AppColor.warning500,
          textColor: AppColor.warning600,
          isBold: true,
          onTap: () => controller.rateDate(match),
        ),
        _buildDivider(),
        _buildActionButton(
          label: "View Details",
          color: AppColor.gray600,
          onTap: () => controller.viewDetails(match),
        ),
      ];
    }

    return SizedBox(
      height: 48.h,
      child: Row(
        children: buttons,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 24.h,
      color: AppColor.gray200,
    );
  }

  Widget _buildActionButton({
    required String label,
    IconData? icon,
    required Color color,
    Color? textColor,
    bool isBold = false,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16.sp, color: color),
                SizedBox(width: 6.w),
              ],
              Text(
                label,
                style: AppTextStyle.bodySmall(
                  weight: isBold ? AppTextStyle.bold : AppTextStyle.medium,
                ).copyWith(
                  color: textColor ?? color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
