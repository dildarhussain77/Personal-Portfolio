import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_portfolio/animations/fade_in_animation.dart';
import 'package:flutter_web_portfolio/animations/slide_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Formspree configuration - USE YOUR FORM ID HERE
  final String formspreeFormId = 'xzdddbel'; // Your Formspree form ID
  bool _isSending = false;

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.background.withAlpha(225),
          ],
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(title: 'Get In Touch'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 30,
            desktop: 40,
          )),
          Text(
            'Interested in working together or have a project in mind?\nI\'d love to hear from you.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.responsiveValue(
                context: context,
                mobile: 16,
                tablet: 17,
                desktop: 18,
              ),
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 30,
            tablet: 40,
            desktop: 50,
          )),

          // Contact cards
          Responsive.isMobile(context)
              ? _buildMobileContactCards(context)
              : _buildDesktopContactCards(context),

          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 40,
            tablet: 50,
            desktop: 60,
          )),

          // CONTACT FORM - NOW SHOWS ON ALL DEVICES
          _buildContactForm(context),

          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 40,
            tablet: 50,
            desktop: 40,
          )),
          const Divider(color: AppColors.textSecondary),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 16,
            tablet: 20,
            desktop: 20,
          )),
          Text(
            '© ${DateTime.now().year} Dildar Hussain. All rights reserved.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: Responsive.responsiveValue(
                context: context,
                mobile: 12,
                tablet: 13,
                desktop: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContactCards(BuildContext context) {
    return Column(
      children: [
        _buildContactCard(
          context: context,
          assetPath: 'icons/email.png',
          title: 'Email',
          subtitle: 'dildarhussain876543@gmail.com',
          onTap: () => _launchEmail(),
          color: AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          context: context,
          assetPath: 'icons/linkedin.png',
          title: 'LinkedIn',
          subtitle: 'linkedin.com/in/dildar-hussain-bhutto',
          onTap: () => _launchLinkedIn(),
          color: AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          context: context,
          assetPath: 'icons/githubContact.png',
          title: 'GitHub',
          subtitle: 'github.com/dildarhussain77',
          onTap: () => _launchGitHub(),
          color: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildDesktopContactCards(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: Responsive.responsiveValue(
        context: context,
        mobile: 16,
        tablet: 20,
        desktop: 30,
      ),
      runSpacing: Responsive.responsiveValue(
        context: context,
        mobile: 16,
        tablet: 20,
        desktop: 24,
      ),
      children: [
        _buildContactCard(
          context: context,
          assetPath: 'icons/email.png',
          title: 'Email',
          subtitle: 'dildarhussain876543@gmail.com',
          onTap: () => _launchEmail(),
          color: AppColors.primary
        ),
        _buildContactCard(
          context: context,
          assetPath: 'icons/linkedin.png',
          title: 'LinkedIn',
          subtitle: 'linkedin.com/in/dildar-hussain-bhutto',
          onTap: () => _launchLinkedIn(),
          color: AppColors.primary
        ),
        _buildContactCard(
          context: context,
          assetPath: 'icons/githubContact.png',
          title: 'GitHub',
          subtitle: 'github.com/dildarhussain77',
          onTap: () => _launchGitHub(),
          color: AppColors.primary
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required String assetPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return FadeInAnimation(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: Responsive.responsiveValue(
            context: context,
            mobile: double.infinity,
            tablet: 180,
            desktop: 200,
          ),
          padding: EdgeInsets.all(Responsive.responsiveValue(
            context: context,
            mobile: 20,
            tablet: 22,
            desktop: 24,
          )),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withAlpha(75)),
          ),
          child: Column(
            children: [
              Image.asset(
                assetPath,
                width: Responsive.responsiveValue(
                  context: context,
                  mobile: 32,
                  tablet: 36,
                  desktop: 40,
                ),
                height: Responsive.responsiveValue(
                  context: context,
                  mobile: 32,
                  tablet: 36,
                  desktop: 40,
                ),
              ),
              SizedBox(height: Responsive.responsiveValue(
                context: context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              )),
              Text(
                title,
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
              ),
              SizedBox(height: Responsive.responsiveValue(
                context: context,
                mobile: 4,
                tablet: 6,
                desktop: 8,
              )),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 13,
                    tablet: 13,
                    desktop: 14,
                  ),
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SlideInAnimation(
      beginOffset: const Offset(0, 50),
      child: Container(
        width: isMobile ? double.infinity : 500,
        padding: EdgeInsets.all(Responsive.responsiveValue(
          context: context,
          mobile: 20,
          tablet: 24,
          desktop: 28,
        )),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Send me a message',
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 20,
                    tablet: 22,
                    desktop: 24,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,

                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.responsiveValue(
                context: context,
                mobile: 20,
                tablet: 25,
                desktop: 30,
              )),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.textSecondary.withAlpha(75)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.textSecondary.withAlpha(75)),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: EdgeInsets.all(isMobile ? 16 : 18),
                ),
                style: TextStyle(
                  fontSize: isMobile ? 15 : 16,
                  color: AppColors.textPrimary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Responsive.responsiveValue(
                context: context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              )),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.textSecondary.withAlpha(75)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.textSecondary.withAlpha(75)),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: EdgeInsets.all(isMobile ? 16 : 18),
                ),
                style: TextStyle(
                  fontSize: isMobile ? 15 : 16,
                  color: AppColors.textPrimary,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: Responsive.responsiveValue(
                context: context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              )),

              // Message Field
              TextFormField(
                controller: _messageController,
                maxLines: isMobile ? 3 : 4,
                decoration: InputDecoration(
                  labelText: 'Your Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.textSecondary.withAlpha(75)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.textSecondary.withAlpha(75)),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: EdgeInsets.all(isMobile ? 16 : 18),
                  alignLabelWithHint: true,
                ),
                style: TextStyle(
                  fontSize: isMobile ? 15 : 16,
                  color: AppColors.textPrimary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  if (value.length < 10) {
                    return 'Message should be at least 10 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: Responsive.responsiveValue(
                context: context,
                mobile: 24,
                tablet: 28,
                desktop: 30,
              )),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSending ? null : _submitContactForm, // Disable when sending
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: Responsive.responsiveValue(
                        context: context,
                        mobile: 16,
                        tablet: 17,
                        desktop: 18,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: _isSending
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Sending...',
                        style: TextStyle(
                          fontSize: Responsive.responsiveValue(
                            context: context,
                            mobile: 16,
                            tablet: 17,
                            desktop: 18,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                      : Text(
                    'Send Message',
                    style: TextStyle(
                      fontSize: Responsive.responsiveValue(
                        context: context,
                        mobile: 16,
                        tablet: 17,
                        desktop: 18,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Note for mobile users
              if (isMobile) ...[
                SizedBox(height: 16),
                Text(
                  'You can also email me directly using the email button above.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _sendEmailWithFormspree({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      // Formspree endpoint using your form ID
      final String url = 'https://formspree.io/f/$formspreeFormId';

      // Prepare the request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'message': message,
          '_subject': 'New Portfolio Message from $name',
          '_replyto': email,
        }),
      );

      // Check response
      if (response.statusCode == 200) {
        print('Form submitted successfully!');
        return true;
      } else {
        print('Formspree Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Formspree Exception: $e');
      return false;
    }
  }

  Future<void> _submitContactForm() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Prevent multiple submissions
    if (_isSending) return;

    setState(() {
      _isSending = true;
    });

    // Get form data
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String message = _messageController.text.trim();

    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(width: 12),
            Text(
              'Sending message...',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 10), // Longer duration for sending
      ),
    );

    try {
      // Send email using Formspree
      final bool success = await _sendEmailWithFormspree(
        name: name,
        email: email,
        message: message,
      );

      // Hide loading snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Message sent successfully! I\'ll get back to you soon.',
              style: TextStyle(color: AppColors.textPrimary),
            ),
            backgroundColor: AppColors.accent,
            duration: const Duration(seconds: 5),
          ),
        );

        // Clear form after successful submission
        _clearForm();
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to send message. Please try again or email me directly.',
              style: TextStyle(color: AppColors.textPrimary),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      // Hide loading snackbar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred: $e',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }


  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    _formKey.currentState?.reset();
  }


  Future<void> _launchEmail() async {
    final String email = 'dildarhussain876543@gmail.com';

    // Option 1: Try direct Gmail Web URL (opens browser)
    final String gmailWebUrl = 'https://mail.google.com/mail/?view=cm&fs=1&to=$email';

    // Option 2: Standard mailto link
    final Uri mailtoUri = Uri.parse('mailto:$email');

    // final url = Uri.parse('mailto:dildarhussain876543@gmail.com');


    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // }

    // Try Gmail Web first (opens in browser)
    if (await canLaunchUrl(Uri.parse(gmailWebUrl))) {
      await launchUrl(
        Uri.parse(gmailWebUrl),
        mode: LaunchMode.externalApplication,
      );
    }
    // Fallback to standard mailto
    else if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    } else {
      // Last resort: Copy to clipboard
      await Clipboard.setData(ClipboardData(text: email));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email copied to clipboard: $email'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _launchLinkedIn() async {
    const url = 'https://linkedin.com/in/dildar-hussain-bhutto';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _launchGitHub() async {
    const url = 'https://github.com/dildarhussain77';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}