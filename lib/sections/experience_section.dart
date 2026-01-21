import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/animations/slide_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/data/experiences_data.dart';
import 'package:flutter_web_portfolio/models/experience_model.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = getExperiences();

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
          const SectionTitle(title: 'Work Experience'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),

          // Timeline for experiences
          Column(
            children: experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final experience = entry.value;
              return SlideInAnimation(
                beginOffset: const Offset(50, 0),
                duration: Duration(milliseconds: 500 + (index * 200)),
                child: ExperienceCard(experience: experience),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Card(
      margin: EdgeInsets.only(
        bottom: Responsive.responsiveValue(
          context: context,
          mobile: 20,
          tablet: 24,
          desktop: 28,
        ),
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.all(Responsive.responsiveValue(
          context: context,
          mobile: 16,
          tablet: 20,
          desktop: 24,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company and Duration Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.role,
                        style: TextStyle(
                          fontSize: Responsive.responsiveValue(
                            context: context,
                            mobile: 18,
                            tablet: 20,
                            desktop: 22,
                          ),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Responsive.responsiveValue(
                        context: context,
                        mobile: 4,
                        tablet: 6,
                        desktop: 8,
                      )),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ).createShader(bounds),
                        child: Text(
                          experience.company,
                          style: TextStyle(
                            fontSize: Responsive.responsiveValue(
                              context: context,
                              mobile: 16,
                              tablet: 17,
                              desktop: 18,
                            ),
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      experience.duration,
                      style: TextStyle(
                        fontSize: Responsive.responsiveValue(
                          context: context,
                          mobile: 14,
                          tablet: 15,
                          desktop: 16,
                        ),
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: Responsive.responsiveValue(
                      context: context,
                      mobile: 4,
                      tablet: 6,
                      desktop: 8,
                    )),
                    Text(
                      experience.location,
                      style: TextStyle(
                        fontSize: Responsive.responsiveValue(
                          context: context,
                          mobile: 13,
                          tablet: 14,
                          desktop: 15,
                        ),
                        color: AppColors.textSecondary.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 12,
              tablet: 16,
              desktop: 20,
            )),

            // Description
            Text(
              experience.description,
              style: TextStyle(
                fontSize: Responsive.responsiveValue(
                  context: context,
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            )),

            // Tech Stack Tags
            Wrap(
              spacing: Responsive.responsiveValue(
                context: context,
                mobile: 8,
                tablet: 10,
                desktop: 12,
              ),
              runSpacing: Responsive.responsiveValue(
                context: context,
                mobile: 6,
                tablet: 8,
                desktop: 8,
              ),
              children: experience.technologies
                  .map<Widget>((tech) => Chip(
                label: Text(
                  tech,
                  style: TextStyle(
                    fontSize: Responsive.responsiveValue(
                      context: context,
                      mobile: 11,
                      tablet: 12,
                      desktop: 13,
                    ),
                  ),
                ),
                backgroundColor: AppColors.primary.withAlpha(25),
                labelStyle: const TextStyle(color: AppColors.primary),
                visualDensity: VisualDensity.compact,
              ))
                  .toList(),
            ),
            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            )),

            // Achievements
            if (experience.achievements.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.workspace_premium,
                          size: 18,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Key Achievements:',
                          style: TextStyle(
                            fontSize: Responsive.responsiveValue(
                              context: context,
                              mobile: 15,
                              tablet: 16,
                              desktop: 17,
                            ),
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    if (isMobile && experience.achievements.length > 3)
                      _buildMobileAchievements(experience.achievements, context)
                    else
                      _buildAchievementsList(experience.achievements,AppColors.accent, context),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileAchievements(List<String> achievements, context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: false,
      collapsedIconColor: AppColors.primary,
      iconColor: AppColors.primary,
      title: Text(
        'Tap to view ${achievements.length} achievements',
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      children: [
        _buildAchievementsList(achievements, AppColors.accent, context),
      ],
    );
  }

  Widget _buildAchievementsList(List<String> achievements, Color color, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: achievements
          .map((achievement) => Padding(
        padding: EdgeInsets.only(
          bottom: Responsive.responsiveValue(
            context: context,
            mobile: 8,
            tablet: 10,
            desktop: 12,
          ),
          left: 4,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.check_circle,
                size: Responsive.responsiveValue(
                  context: context,
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                achievement,
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 13,
                    tablet: 14,
                    desktop: 15,
                  ),
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ))
          .toList(),
    );
  }
}