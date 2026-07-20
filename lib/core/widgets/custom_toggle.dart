import 'package:flutter/material.dart';
// import 'app_color.dart'; // Ensure you import your color palette

/// Defines the size variants for the toggle switch.
enum CustomToggleSize { small, medium }

class CustomToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool hasFocus;
  final CustomToggleSize size;

  const CustomToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.hasFocus = false,
    this.size = CustomToggleSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    // If onChanged is null, the toggle is considered disabled
    final bool isDisabled = onChanged == null;

    // --- Dimension setup based on size ---
    final double width = size == CustomToggleSize.medium ? 44.0 : 36.0;
    final double height = size == CustomToggleSize.medium ? 24.0 : 20.0;
    final double thumbSize = size == CustomToggleSize.medium ? 20.0 : 16.0;
    final double trackPadding = 2.0;

    // --- Color setup ---
    // Assuming AppColor.gray900 for active, AppColor.gray200 for inactive track
    final Color activeTrackColor = const Color(0xFF181D27);
    final Color inactiveTrackColor = const Color(0xFFE9EAEB);
    final Color focusRingColor = const Color(
      0xFF9E77ED,
    ); // The purple focus ring

    Color getTrackColor() {
      if (isDisabled) {
        return value
            ? activeTrackColor.withValues(alpha: 0.4)
            : inactiveTrackColor.withValues(alpha: 0.5);
      }
      return value ? activeTrackColor : inactiveTrackColor;
    }

    return GestureDetector(
      onTap: () {
        if (!isDisabled && onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        // The outer container handles the purple focus ring
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: hasFocus ? focusRingColor : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: width,
          height: height,
          padding: EdgeInsets.all(trackPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            color: getTrackColor(),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  if (!isDisabled)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
