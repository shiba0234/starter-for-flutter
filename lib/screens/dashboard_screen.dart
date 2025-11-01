import 'package:flutter/material.dart';
import '../ui/dashboard_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C1E), // dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: const [
              DashboardCard(
                icon: FontAwesomeIcons.chartSimple,
                title: 'Audio Overview',
                backgroundColor: Color(0xFF2B2E33),
                iconColor: Color(0xFFB4E0FF),
              ),
              DashboardCard(
                icon: FontAwesomeIcons.video,
                title: 'Video Overview',
                backgroundColor: Color(0xFF313B35),
                iconColor: Color(0xFFB4FFD8),
              ),
              DashboardCard(
                icon: FontAwesomeIcons.sitemap,
                title: 'Mind Map',
                backgroundColor: Color(0xFF3B2F38),
                iconColor: Color(0xFFFFB8E8),
              ),
              DashboardCard(
                icon: FontAwesomeIcons.fileLines,
                title: 'Reports',
                backgroundColor: Color(0xFF3C3A2E),
                iconColor: Color(0xFFF9FFB4),
              ),
              DashboardCard(
                icon: FontAwesomeIcons.clone,
                title: 'Flashcards',
                backgroundColor: Color(0xFF3A3331),
                iconColor: Color(0xFFFFE7B4),
              ),
              DashboardCard(
                icon: FontAwesomeIcons.circleQuestion,
                title: 'Quiz',
                backgroundColor: Color(0xFF2E3339),
                iconColor: Color(0xFFB4E8FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
