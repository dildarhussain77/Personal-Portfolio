import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/animations/fade_in_animation.dart';
import 'package:flutter_web_portfolio/animations/slide_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
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
      color: AppColors.surface.withAlpha(75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'About Me'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),

          // Responsive Layout
          Responsive.isMobile(context)
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Profile Image
        FadeInAnimation(
          duration: const Duration(milliseconds: 800),
          child: Container(
            width: 150,
            height: 150,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2
              ),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: const DecorationImage(
                image: AssetImage('images/pic3.jpg'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(75),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            // child: Center(
            //   child: Image.asset(
            //     'assets/images/mypic.jpg',
            //     width: 60,
            //     height: 60,
            //     //fit: BoxFit.contain,
            //   ),
            // ),
          ),
        ),

        // Content
        _buildContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SlideInAnimation(
      beginOffset: const Offset(-50, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          FadeInAnimation(
            duration: const Duration(milliseconds: 800),
            child: Container(
              width: Responsive.responsiveValue(
                context: context,
                mobile: 150,
                tablet: 180,
                desktop: 200,
              ),
              height: Responsive.responsiveValue(
                context: context,
                mobile: 150,
                tablet: 180,
                desktop: 200,
              ),
              margin: EdgeInsets.only(
                right: Responsive.responsiveValue(
                  context: context,
                  mobile: 0,
                  tablet: 24,
                  desktop: 40,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.primary,
                    width: 3
                ),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: const DecorationImage(
                  image: AssetImage('images/pic3.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(75),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              // child:  Center(
              //   child: ClipOval(
              //     child: Image.asset(
              //       'images/mypic.jpg',
              //       width: 80,
              //       height: 80,
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
            ),
          ),

          // Content
          Expanded(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FadeInAnimation(
      duration: const Duration(milliseconds: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professional Mobile App Developer',
            style: TextStyle(
              fontSize: Responsive.responsiveValue(
                context: context,
                mobile: 20,
                tablet: 24,
                desktop: 28,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 12,
            tablet: 16,
            desktop: 20,
          )),

          Text(
            'I am a Software Engineering graduate with hands-on experience in mobile application development, '
                'starting with native Android development using Java and Kotlin, and currently working on cross-platform app development with Flutter.\n\n'
                'I began my professional journey as an Android Developer intern, transitioned into a full-time Android Developer role, and later expanded into Flutter development as part of evolving project requirements.'
                'This progression has strengthened my understanding of mobile architecture, clean code practices, and scalable UI development across platforms.\n\n'
                'I have experience integrating Firebase services, consuming RESTful APIs, and working with MVVM-based architectures while focusing on clean, user-friendly, and maintainable applications.',
            style: TextStyle(
              fontSize: Responsive.responsiveValue(
                context: context,
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),

          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 25,
            tablet: 30,
            desktop: 35,
          )),

          // Responsive Stats - IMPROVED for mobile
          _buildStatsSection(context),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    // Define stats with proper typing
    final List<Map<String, dynamic>> stats = [
      {'value': '11+', 'label': 'Projects', 'asset': 'icons/project.png'},
      {'value': '1+', 'label': 'Years Experience', 'asset': 'icons/experience.png'},
      {'value': '11+', 'label': 'Team Projects Contributed', 'asset': 'icons/team.png'},
      {'value': '100%', 'label': 'Satisfaction', 'asset': 'icons/satisfy.png'},
    ];

    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      // Mobile: 2x2 grid instead of single column
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: stats
            .asMap()
            .entries
            .map((entry) => FadeInAnimation(
          duration: Duration(milliseconds: 800 + entry.key * 150),
          child: _buildStatItem(
            entry.value['value'] as String, // Explicit cast
            entry.value['label'] as String, // Explicit cast
            entry.value['asset'] as String, // Explicit cast
            context,
            isMobile: true,
          ),
        ))
            .toList(),
      );
    } else {
      // Desktop/Tablet: Responsive grid
      final crossAxisCount = Responsive.responsiveGridCount(
        context: context,
        mobile: 2,
        tablet: 2,
        desktop: 4,
      );

      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        childAspectRatio: Responsive.responsiveValue(
          context: context,
          mobile: 1.2,
          tablet: 1.3,
          desktop: 1.0,
        ),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: stats
            .asMap()
            .entries
            .map((entry) => FadeInAnimation(
          duration: Duration(milliseconds: 800 + entry.key * 150),
          child: _buildStatItem(
            entry.value['value'] as String, // Explicit cast
            entry.value['label'] as String, // Explicit cast
            entry.value['asset'] as String, // Explicit cast
            context,
            isMobile: false,
          ),
        ))
            .toList(),
      );
    }
  }

  Widget _buildStatItem(String value, String label, String assetPath, BuildContext context, {required bool isMobile}) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isMobile ? 120 : 140, // Minimum height
        maxHeight: isMobile ? 140 : 160, // Maximum height
      ),
      padding: EdgeInsets.all(isMobile ? 8 : 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withAlpha(125),
        borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
        border: Border.all(color: AppColors.primary.withAlpha(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon on left side
            Container(
              width: isMobile ? 40 : 50,
              height: isMobile ? 40 : 50,
              margin: EdgeInsets.only(right: isMobile ? 8 : 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  assetPath,
                  width: isMobile ? 20 : 24,
                  height: isMobile ? 20 : 24,
                  // color: AppColors.primary,
                ),
              ),
            ),

            // Text content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Value
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ).createShader(bounds),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 22 : Responsive.responsiveValue(
                          context: context,
                          mobile: 22,
                          tablet: 24,
                          desktop: 28,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 2 : 4),

                  // Label
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : Responsive.responsiveValue(
                        context: context,
                        mobile: 12,
                        tablet: 13,
                        desktop: 14,
                      ),
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}