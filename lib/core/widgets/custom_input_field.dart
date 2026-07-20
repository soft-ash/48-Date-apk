import 'package:flutter/material.dart';

import '../constant/colors.dart';

// Assuming you have this AppColor class from the previous step
// import 'app_color.dart';

class CommonInputField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;

  const CommonInputField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we need to show the error state
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- 1. Label Section ---
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.gray900, // Or Colors.black87
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColor.error500),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // --- 2. Text Field Section ---
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: AppColor.gray900),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColor.gray400, fontSize: 14),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            // Padding based on Figma design (12px top/bottom, 16px sides)
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            // Inactive / Default Border (gray300)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? AppColor.error500 : AppColor.gray300,
                width: 1,
              ),
            ),

            // Focused Border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? AppColor.error500 : AppColor.gray600,
                width: 1,
              ),
            ),
          ),
        ),

        // --- 3. Custom Error Message Section ---
        if (hasError) ...[
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error, // Matches the filled red circle icon in design
                color: AppColor.error500,
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    color: AppColor.error500,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
