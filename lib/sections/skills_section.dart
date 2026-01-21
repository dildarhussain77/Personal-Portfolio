import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/animations/fade_in_animation.dart';
import 'package:flutter_web_portfolio/constants/colors.dart';
import 'package:flutter_web_portfolio/data/skills_data.dart';
import 'package:flutter_web_portfolio/models/skill_model.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'package:flutter_web_portfolio/widgets/section_title.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Skill> skills;
  late ScrollController _scrollController;
  bool _isUserInteracting = false;
  Timer? _autoScrollTimer;
  Timer? _interactionTimer;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    skills = getSkills();
    _scrollController = ScrollController();

    // Auto scroll animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 50),
      vsync: this,
    )..repeat();

    // Listen to scroll changes for progress bar
    _scrollController.addListener(_updateScrollProgress);

    // Start auto-scroll animation after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _updateScrollProgress() {
    if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0) {
      final currentOffset = _scrollController.offset;
      final maxScroll = _scrollController.position.maxScrollExtent;
      setState(() {
        _scrollProgress = (currentOffset / maxScroll).clamp(0.0, 1.0);
      });
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();

    // Calculate adaptive scroll speed based on number of skills
    // With 11 skills, speed should be faster than with 19 skills
    final baseSpeed = 0.8;
    final skillCount = skills.length;

    // Adaptive speed: fewer skills = faster, more skills = slower
    // You can adjust these values as needed
    double scrollSpeed;
    if (skillCount <= 10) {
      scrollSpeed = 1.5; // Fast for 10 or fewer skills
    } else if (skillCount <= 15) {
      scrollSpeed = 1.0; // Medium for 11-15 skills
    } else {
      scrollSpeed = 0.8; // Slow for 16+ skills
    }

    // Or use a formula: scrollSpeed = 15.0 / skillCount;

    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_isUserInteracting && _scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        if (maxScroll > 0) {
          final currentOffset = _scrollController.offset;
          final newOffset = currentOffset + scrollSpeed;

          if (newOffset >= maxScroll) {
            // Jump back to start for seamless loop
            _scrollController.jumpTo(0);
          } else {
            _scrollController.jumpTo(newOffset);
          }
        }
      }
    });
  }

  void _onUserInteraction() {
    if (!_isUserInteracting) {
      setState(() {
        _isUserInteracting = true;
      });
    }

    // Cancel any existing interaction timer
    _interactionTimer?.cancel();

    // Set a new timer to resume auto-scroll after 3 seconds of inactivity
    _interactionTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isUserInteracting = false;
        });
      }
    });
  }

  Widget _buildProgressBar() {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
      child: AnimatedFractionallySizedBox(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.centerLeft,
        widthFactor: _scrollProgress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

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
          const SectionTitle(title: 'Technical Skills'),
          SizedBox(height: Responsive.responsiveValue(
            context: context,
            mobile: 30,
            tablet: 40,
            desktop: 50,
          )),

          // All Technical Skills - Horizontal Scrolling Carousel
          _buildAllTechnicalSkills(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildAllTechnicalSkills(BuildContext context, bool isMobile) {
    // Responsive card heights
    final cardHeight = Responsive.responsiveValue(
      context: context,
      mobile: 140, // More compact for mobile
      tablet: 160,
      desktop: 180,
    );

    final containerHeight = Responsive.responsiveValue(
      context: context,
      mobile: cardHeight + 80, // Compact container
      tablet: cardHeight + 100,
      desktop: cardHeight + 120,
    );

    return FadeInAnimation(
      duration: const Duration(milliseconds: 800),
      child: Container(
        height: containerHeight,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface.withOpacity(0.3),
              AppColors.surface.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Technical Skills',
                  style: TextStyle(
                    fontSize: Responsive.responsiveValue(
                      context: context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

              ],
            ),

            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 12,
              tablet: 16,
              desktop: 20,
            )),

            // Progress Bar
            _buildProgressBar(),

            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 12,
              tablet: 16,
              desktop: 20,
            )),

            // Horizontal scrolling skills
            Expanded(
              child: ClipRect(
                child: Stack(
                  children: [
                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.background.withOpacity(0.9),
                              Colors.transparent,
                              Colors.transparent,
                              AppColors.background.withOpacity(0.9),
                            ],
                            stops: const [0.0, 0.05, 0.95, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Interactive skills list
                    _buildInteractiveSkills(context, isMobile, cardHeight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveSkills(BuildContext context, bool isMobile, double cardHeight) {
    // Responsive card widths
    final cardWidth = Responsive.responsiveValue(
      context: context,
      mobile: 110, // More compact for mobile
      tablet: 140,
      desktop: 170,
    );

    // Create skill items
    final skillItems = skills.map((skill) => _buildSkillItem(
      skill,
      context,
      isMobile,
      cardHeight,
      cardWidth,
    )).toList();

    return GestureDetector(
      onHorizontalDragStart: (details) {
        _onUserInteraction();
      },
      onHorizontalDragUpdate: (details) {
        _onUserInteraction();
      },
      onHorizontalDragEnd: (details) {
        _onUserInteraction();
      },
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final skillIndex = index % skillItems.length;
          return skillItems[skillIndex];
        },
      ),
    );
  }

  Widget _buildSkillItem(Skill skill, BuildContext context, bool isMobile,
      double cardHeight, double cardWidth) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Container(
        margin: EdgeInsets.only(
          right: Responsive.responsiveValue(
            context: context,
            mobile: 10,
            tablet: 12,
            desktop: 14,
          ),
        ),
        padding: EdgeInsets.all(Responsive.responsiveValue(
          context: context,
          mobile: 10,
          tablet: 12,
          desktop: 14,
        )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              skill.color.withOpacity(0.15),
              skill.color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(Responsive.responsiveValue(
            context: context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          )),
          border: Border.all(
            color: skill.color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: skill.color.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: Responsive.responsiveValue(
                context: context,
                mobile: 40,
                tablet: 50,
                desktop: 60,
              ),
              height: Responsive.responsiveValue(
                context: context,
                mobile: 40,
                tablet: 50,
                desktop: 60,
              ),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    skill.color.withOpacity(0.3),
                    skill.color.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  skill.iconPath,
                  width: Responsive.responsiveValue(
                    context: context,
                    mobile: 20,
                    tablet: 24,
                    desktop: 28,
                  ),
                  height: Responsive.responsiveValue(
                    context: context,
                    mobile: 20,
                    tablet: 24,
                    desktop: 28,
                  ),
                  // color: skill.color,
                ),
              ),
            ),

            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 8,
              tablet: 10,
              desktop: 12,
            )),

            // Skill name
            Expanded(
              child: Text(
                skill.name,
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 12,
                    tablet: 13,
                    desktop: 14,
                  ),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: Responsive.responsiveValue(
              context: context,
              mobile: 4,
              tablet: 6,
              desktop: 8,
            )),

            // Category
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveValue(
                  context: context,
                  mobile: 6,
                  tablet: 8,
                  desktop: 10,
                ),
                vertical: Responsive.responsiveValue(
                  context: context,
                  mobile: 3,
                  tablet: 4,
                  desktop: 5,
                ),
              ),
              decoration: BoxDecoration(
                color: skill.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Responsive.responsiveValue(
                  context: context,
                  mobile: 6,
                  tablet: 8,
                  desktop: 10,
                )),
              ),
              child: Text(
                skill.category,
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context: context,
                    mobile: 10,
                    tablet: 11,
                    desktop: 12,
                  ),
                  color: skill.color,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.removeListener(_updateScrollProgress);
    _scrollController.dispose();
    _autoScrollTimer?.cancel();
    _interactionTimer?.cancel();
    super.dispose();
  }
}