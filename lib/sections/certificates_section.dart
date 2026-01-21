import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_portfolio/animations/slide_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/data/certificates_data.dart';
import 'package:flutter_web_portfolio/models/certificate_model.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certificates = getCertificates();

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
          const SectionTitle(title: 'Certifications'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),

          // Wrap layout - more flexible
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
            children: certificates.asMap().entries.map((entry) {
              final index = entry.key;
              final certificate = entry.value;
              final cardWidth = _calculateCardWidth(context);

              return SlideInAnimation(
                beginOffset: const Offset(0, 50),
                duration: Duration(milliseconds: 500 + (index * 200)),
                child: SizedBox(
                  width: cardWidth,
                  child: CertificateCard(certificate: certificate),
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

class CertificateCard extends StatelessWidget {
  final Certificate certificate;

  const CertificateCard({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _launchURL(context, certificate.url),
        child: Container(
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
              // Title - responsive
              Text(
                certificate.title,
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 6),

              // Issuer
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  certificate.issuer,
                  style: TextStyle(
                    fontSize: Responsive.responsiveValue(
                      context: context,
                      mobile: 14,
                      tablet: 15,
                      desktop: 16,
                    ),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 12),

              // Compact info section
              _buildInfoSection(context, certificate),

              SizedBox(height: 12),

              // Verify badge - only on desktop/tablet
              if (!isMobile) _buildVerifyBadge(context, certificate),

              // Mobile indicator
              if (isMobile) _buildMobileIndicator(context, certificate),

              SizedBox(height: 12),

              // View button - fixed height
              _buildViewButton(context, certificate, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Certificate certificate) {
    return Column(
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
                'Issued: ${certificate.issueDate}',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // SizedBox(height: 6),
        // Row(
        //   children: [
        //     Icon(
        //       Icons.fingerprint,
        //       size: 14,
        //       color: AppColors.textSecondary,
        //     ),
        //     SizedBox(width: 6),
        //     Expanded(
        //       child: Text(
        //         'ID: ${certificate.credentialId}',
        //         style: TextStyle(
        //           fontSize: 13,
        //           color: AppColors.textSecondary,
        //         ),
        //         overflow: TextOverflow.ellipsis,
        //       ),
        //     ),
        //   ],
        // ),
        if (certificate.expiryDate != null) ...[
          SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.timelapse,
                size: 14,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Expires: ${certificate.expiryDate}',
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
      ],
    );
  }

  Widget _buildVerifyBadge(BuildContext context, Certificate certificate) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 14,
            color: AppColors.accent,
          ),
          SizedBox(width: 6),
          Text(
            'Verified',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileIndicator(BuildContext context, Certificate certificate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.touch_app,
          size: 14,
          color: AppColors.accent,
        ),
        SizedBox(width: 6),
        Text(
          'Tap to view certificate',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildViewButton(BuildContext context, Certificate certificate, bool isMobile) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _launchURL(context, certificate.url),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 10 : 12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.visibility,
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              isMobile ? 'View' : 'View Certificate',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open resume'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}