import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_portfolio/animations/slide_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/data/projects_data.dart';
import 'package:flutter_web_portfolio/models/project_model.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = getProjects();

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
          const SectionTitle(title: 'Featured Projects'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return SlideInAnimation(
                beginOffset: const Offset(50, 0),
                duration: Duration(milliseconds: 500 + (index * 200)),
                child: ProjectCard(project: projects[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

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
            // Project Title and GitHub Link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: TextStyle(
                      fontSize: Responsive.responsiveValue(
                        context: context,
                        mobile: 18,
                        tablet: 22,
                        desktop: 24,
                      ),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => _launchURL(project.githubUrl),
                  icon: Icon(
                    Icons.open_in_new,
                    color: AppColors.primary,
                    size: Responsive.responsiveValue(
                      context: context,
                      mobile: 22,
                      tablet: 24,
                      desktop: 26,
                    ),
                  ),
                  tooltip: 'View on GitHub',
                ),
              ],
            ),
            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 12,
              tablet: 14,
              desktop: 16,
            )),

            // Project Description
            Text(
              project.description,
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
              children: project.technologies
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

            // PROJECT FEATURES - ALWAYS SHOW (with mobile optimization)
            if (project.features.isNotEmpty) ...[
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
                          Icons.star,
                          size: 18,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Key Features:',
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

                    // Mobile: Show as compact list or expandable
                    if (isMobile && project.features.length > 3)
                      _buildMobileFeatures(project.features, context)
                    else
                      _buildFeaturesList(project.features, context),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileFeatures(List<String> features, context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: false,
      collapsedIconColor: AppColors.primary,
      iconColor: AppColors.primary,
      title: Text(
        'Tap to view ${features.length} features',
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      children: [
        _buildFeaturesList(features, context),
      ],
    );
  }

  Widget _buildFeaturesList(List<String> features, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Padding(
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
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                feature,
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

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}