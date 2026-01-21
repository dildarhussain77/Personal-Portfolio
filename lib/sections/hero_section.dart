import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/fade_in_animation.dart';
import '../animations/slide_in_animation.dart';
import '../constants/colors.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart'; // Add this

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
          mobile: 60,
          tablet: 80,
          desktop: 100,
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.surface.withAlpha(125),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Responsive Avatar
          FadeInAnimation(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: Responsive.responsiveValue(
                context: context,
                mobile: 100,
                tablet: 130,
                desktop: 150,
              ),
              height: Responsive.responsiveValue(
                context: context,
                mobile: 100,
                tablet: 130,
                desktop: 150,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: Responsive.responsiveValue(
                    context: context,
                    mobile: 2,
                    tablet: 2.5,
                    desktop: 3,
                  ),
                ),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
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
              // child: const Center(
              //   child: Icon(
              //     Icons.person,
              //     color: Colors.white,
              //   ),
              // ),
            ),
          ),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),


          // Responsive Name
          SlideInAnimation(
            beginOffset: const Offset(0, -50),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
              ).createShader(bounds),
              child: Text(
                'DILDAR HUSSAIN',
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 28,
                    tablet: 36,
                    desktop: 42,
                  ),
                  fontWeight: FontWeight.w900,
                  letterSpacing: Responsive.responsiveValue(
                    context: context,
                    mobile: 1.0,
                    tablet: 1.2,
                    desktop: 1.5,
                  ),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 10,
            tablet: 15,
            desktop: 20,
          )),

          // Responsive Title
          FadeInAnimation(
            duration: const Duration(milliseconds: 1500),
            child: Text(
              'Mobile App Developer | Flutter & Android (Java/Kotlin)',
              style: TextStyle(
                fontSize: Responsive.responsiveValue(
                  context: context,
                  mobile: 16,
                  tablet: 20,
                  desktop: 24,
                ),
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 30,
            tablet: 35,
            desktop: 40,
          )),

          // Responsive Buttons
          SlideInAnimation(
            beginOffset: const Offset(0, 50),
            duration: const Duration(milliseconds: 1200),
            child: Responsive.isMobile(context)
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPrimaryButton(context),
                const SizedBox(height: 16),
                _buildSecondaryButton(context),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPrimaryButton(context),
                SizedBox(width: Responsive.responsiveValue(
                  context: context,
                  mobile: 0,
                  tablet: 16,
                  desktop: 20,
                )),
                _buildSecondaryButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed:()=> _downloadResume(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveValue(
              context: context,
              mobile: 24,
              tablet: 28,
              desktop: 32,
            ),
            vertical: Responsive.responsiveValue(
              context: context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        icon: const Icon(Icons.download,color: Colors.white,),
        label: Text(
          'Download Resume',
          style: TextStyle(
            fontSize: Responsive.responsiveValue(
              context: context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed:()=> _viewResume(context),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveValue(
              context: context,
              mobile: 24,
              tablet: 28,
              desktop: 32,
            ),
            vertical: Responsive.responsiveValue(
              context: context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
          ),
          side: BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        icon: const Icon(Icons.remove_red_eye,color: Colors.white,),
        label: Text(
          'View Resume',
          style: TextStyle(
            fontSize: Responsive.responsiveValue(
              context: context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
              color: Colors.white
          ),
        ),
      ),
    );
  }

// Simple resume methods for web portfolio
  Future<void> _downloadResume(BuildContext context) async {
    const resumeUrl = 'https://drive.google.com/uc?export=download&id=1-DR1muxxGILcDF79izWEl5Z8oXAaVZoS';

    if (await canLaunchUrl(Uri.parse(resumeUrl))) {
      await launchUrl(
        Uri.parse(resumeUrl),
        mode: LaunchMode.externalApplication,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resume download started'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not start download'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _viewResume(BuildContext context) async {
    const viewUrl = 'https://drive.google.com/file/d/1-DR1muxxGILcDF79izWEl5Z8oXAaVZoS/view';

    if (await canLaunchUrl(Uri.parse(viewUrl))) {
      await launchUrl(
        Uri.parse(viewUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open resume'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}