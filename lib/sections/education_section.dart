import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/animations/slide_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/data/education_data.dart';
import 'package:flutter_web_portfolio/models/education_model.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final educationList = getEducation();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveValue(
          context: context,
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        vertical: Responsive.responsiveValue(
          context: context,
          mobile: 40,
          tablet: 60,
          desktop: 80,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Education'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),

          // Wrap layout - much more flexible than GridView
          Wrap(
            spacing: Responsive.responsiveValue(
              context: context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
            runSpacing: Responsive.responsiveValue(
              context: context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
            children: educationList.asMap().entries.map((entry) {
              final index = entry.key;
              final education = entry.value;
              final cardWidth = _calculateCardWidth(context);

              return SlideInAnimation(
                beginOffset: const Offset(0, 50),
                duration: Duration(milliseconds: 500 + (index * 200)),
                child: SizedBox(
                  width: cardWidth,
                  child: EducationCard(education: education),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _calculateCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerPadding = Responsive.responsiveValue(
      context: context,
      mobile: 32, // 16 * 2
      tablet: 48, // 24 * 2
      desktop: 64, // 32 * 2
    );

    final wrapSpacing = Responsive.responsiveValue(
      context: context,
      mobile: 16,
      tablet: 20,
      desktop: 24,
    );

    if (screenWidth < 600) {
      return screenWidth - containerPadding; // Full width on mobile
    } else if (screenWidth < 1024) { // Increased from 900 to 1024
      // For 2 cards: (screenWidth - padding - spacing) / 2
      return (screenWidth - containerPadding - wrapSpacing) / 2;
    } else {
      // For 3 cards: (screenWidth - padding - (spacing * 2)) / 3
      return (screenWidth - containerPadding - (wrapSpacing * 2)) / 3;
    }
  }
}

class EducationCard extends StatelessWidget {
  final Education education;

  const EducationCard({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.surface,
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.all(Responsive.responsiveValue(
            context: context,
            mobile: 16,
            tablet: 18,
            desktop: 20,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Degree - Single line with ellipsis
              Text(
                education.degree,
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 16,
                    tablet: 17,
                    desktop: 18,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 6),

              // Institution
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  education.institution,
                  style: TextStyle(
                    fontSize: Responsive.responsiveValue(
                      context: context,
                      mobile: 14,
                      tablet: 15,
                      desktop: 16,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 12),

              // Duration and Location in compact row
              _buildCompactInfoRow(context, education),

              SizedBox(height: 12),

              // GPA badge if available
              if (education.gpa != null) _buildGPABadge(context, education),

              SizedBox(height: 12),

              // Highlights - Collapsible on mobile/tablet, always shown on desktop
              _buildHighlightsSection(context, education, isMobile, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactInfoRow(BuildContext context, Education education) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      education.duration,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      education.location,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGPABadge(BuildContext context, Education education) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 14,
            color: AppColors.accent,
          ),
          SizedBox(width: 6),
          Text(
            'GPA: ${education.gpa}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsSection(BuildContext context, Education education, bool isMobile, bool isTablet) {
    // On desktop, always show highlights (full width cards)
    // On mobile/tablet, use expandable section
    if (isMobile || isTablet) {
      return ExpansionTile(
        tilePadding: EdgeInsets.zero,
        initiallyExpanded: false,
        collapsedIconColor: AppColors.primary,
        iconColor: AppColors.primary,
        title: Text(
          'Highlights (${education.highlights.length})',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        children: [
          SizedBox(height: 8),
          _buildHighlightsList(education.highlights, AppColors.accent),
        ],
      );
    } else {
      // Desktop - show highlights inline
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Highlights:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          _buildHighlightsList(education.highlights, AppColors.accent),
        ],
      );
    }
  }

  Widget _buildHighlightsList(List<String> highlights, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: highlights
          .map((highlight) => Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.circle,
                size: 6,
                color: color,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                highlight,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ))
          .toList(),
    );
  }
}