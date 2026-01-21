import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/sections/about_section.dart';
import 'package:flutter_web_portfolio/sections/certificates_section.dart';
import 'package:flutter_web_portfolio/sections/contact_section.dart';
import 'package:flutter_web_portfolio/sections/education_section.dart';
import 'package:flutter_web_portfolio/sections/experience_section.dart';
import 'package:flutter_web_portfolio/sections/hero_section.dart';
import 'package:flutter_web_portfolio/sections/projects_section.dart';
import 'package:flutter_web_portfolio/sections/skills_section.dart';
import 'package:flutter_web_portfolio/utils/responsive.dart';
import 'constants/colors.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dildar Hussain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAdaptiveAppBar(context),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(key: _sectionKeys[0]),
            AboutSection(key: _sectionKeys[1]),
            ExperienceSection(key: _sectionKeys[2]), // New
            SkillsSection(key: _sectionKeys[3]),
            ProjectsSection(key: _sectionKeys[4]),
            EducationSection(key: _sectionKeys[5]), // New
            CertificatesSection(key: _sectionKeys[6]), // New
            ContactSection(key: _sectionKeys[7]),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAdaptiveAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Show hamburger menu when screen is too narrow for all buttons
    if (screenWidth < 800) {
      return _buildMobileAppBar();
    }

    // Show condensed AppBar when moderately sized
    if (screenWidth < 1000) {
      return _buildTabletAppBar();
    }

    // Show full desktop AppBar
    return _buildDesktopAppBar();
  }

  // Desktop AppBar (full width)
  PreferredSizeWidget _buildDesktopAppBar() {
    return AppBar(
      title: const Text(
        'DILDAR HUSSAIN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      actions: [
        _buildNavButton('Home', 0),
        _buildNavButton('About', 1),
        _buildNavButton('Experience', 2), // New
        _buildNavButton('Skills', 3),
        _buildNavButton('Projects', 4),
        _buildNavButton('Education', 5), // New
        _buildNavButton('Certificates', 6), // New
        _buildNavButton('Contact', 7),
        const SizedBox(width: 20),
      ],
    );
  }

  // Tablet AppBar (condensed)
  PreferredSizeWidget _buildTabletAppBar() {
    return AppBar(
      title: const Text(
        'Dildar Hussain',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      actions: [
        // Show only icons on tablet
        _buildIconNavButton(Icons.home, 'Home', 0),
        _buildIconNavButton(Icons.person, 'About', 1),
        _buildIconNavButton(Icons.work, 'Experience', 2), // New
        _buildIconNavButton(Icons.star, 'Skills', 3),
        _buildIconNavButton(Icons.work_outline, 'Projects', 4),
        _buildIconNavButton(Icons.school, 'Education', 5), // New
        _buildIconNavButton(Icons.verified, 'Certificates', 6), // New
        _buildIconNavButton(Icons.contact_mail, 'Contact', 7),
        const SizedBox(width: 10),
      ],
    );
  }

  // Mobile AppBar
  PreferredSizeWidget _buildMobileAppBar() {
    return AppBar(
      title: const Text(
        'Dildar Hussain',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 1.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),

    );
  }

  Widget? _buildDrawer(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Show drawer only on mobile and narrow tablet
    return screenWidth < 800 ? _buildNavigationDrawer() : null;
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.primary,
                ),
                SizedBox(height: 10),
                Text(
                  'DILDAR HUSSAIN\nBHUTTO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          _buildDrawerItem('Home', Icons.home, 0),
          _buildDrawerItem('About', Icons.person, 1),
          _buildDrawerItem('Experience', Icons.work, 2), // New
          _buildDrawerItem('Skills', Icons.star, 3),
          _buildDrawerItem('Projects', Icons.work_outline, 4),
          _buildDrawerItem('Education', Icons.school, 5), // New
          _buildDrawerItem('Certificates', Icons.verified, 6), // New
          _buildDrawerItem('Contact', Icons.contact_mail, 7),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, int index) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      onTap: () {
        _scrollToSection(index);
        Navigator.pop(context); // Close drawer
      },
    );
  }

  Widget _buildNavButton(String text, int index) {
    return TextButton(
      onPressed: () => _scrollToSection(index),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildIconNavButton(IconData icon, String tooltip, int index) {
    return IconButton(
      onPressed: () => _scrollToSection(index),
      icon: Icon(icon),
      tooltip: tooltip,
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    // Show FAB only on larger screens
    if (MediaQuery.of(context).size.width < 600) return null;

    return FloatingActionButton(
      onPressed: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.arrow_upward, color: Colors.white),
    );
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}