import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Gradient line
        Container(
          width: Responsive.responsiveValue(
            context: context,
            mobile: 30,
            tablet: 40,
            desktop: 50,
          ),
          height: Responsive.responsiveValue(
            context: context,
            mobile: 2,
            tablet: 2.5,
            desktop: 3,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        SizedBox(width: Responsive.responsiveValue(
          context: context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        )),

        // Flexible title that wraps on small screens
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: Responsive.responsiveValue(
                context: context,
                mobile: 22,
                tablet: 26,
                desktop: 32,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: Responsive.responsiveValue(
                context: context,
                mobile: 0.5,
                tablet: 1.0,
                desktop: 1.5,
              ),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}