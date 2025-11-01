import 'package:appwrite_flutter_starter_kit/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MasterjiApp extends StatelessWidget {
  const MasterjiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masterji Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const MasterjiWelcome(),
    );
  }
}

class MasterjiWelcome extends StatelessWidget {
  const MasterjiWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    // Grab screen metrics for responsive sizing
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    // Buttons width (responsive)
    final buttonWidth = width * 0.88;
    final outlineButtonWidth = width * 0.86;

    // Logo size tuned to the screenshot
    final logoSize = (width < 400) ? width * 0.28 : width * 0.22;

    // Typography sizes
    final titleSize = (width < 400) ? 28.0 : 34.0;
    final subtitleSize = (width < 400) ? 12.0 : 14.0;
    final welcomeSize = (width < 400) ? 20.0 : 22.0;
    final buttonTextSize = (width < 400) ? 16.0 : 18.0;

    const orange =
        Color(0xFFF97316); // matches the orange used in the screenshot

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              // top space like screenshot
              SizedBox(height: constraints.maxHeight * 0.06),

              // Logo
              Center(
                child: SizedBox(
                  width: logoSize,
                  height: logoSize,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: constraints.maxHeight * 0.03),

              // Title "Masterji"
              Text(
                'Masterji',
                style: GoogleFonts.poppins(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: 0.2,
                ),
              ),

              SizedBox(height: 8),

              // Subtitle under title
              Text(
                'Master coding with challenges that inspire',
                style: GoogleFonts.inter(
                  fontSize: subtitleSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[500],
                ),
              ),

              // Space before "Welcome"
              SizedBox(height: constraints.maxHeight * 0.06),

              Text(
                'Welcome',
                style: GoogleFonts.poppins(
                  fontSize: welcomeSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              // Space before buttons
              SizedBox(height: constraints.maxHeight * 0.035),

              // Filled Google button
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()),
                    );
                  },
                  icon: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFFF97316),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: buttonTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),

              SizedBox(height: 14),

              // Outlined GitHub button
              SizedBox(
                width: outlineButtonWidth,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // hook up GitHub sign-in here
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.github,
                    size: 20,
                    // color will be set by style below
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      'Continue with GitHub',
                      style: TextStyle(
                        fontSize: buttonTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: orange,
                    side: const BorderSide(color: orange, width: 2.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                  ).copyWith(
                    // Ensure the icon uses the same orange color when enabled
                    foregroundColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      return orange;
                    }),
                  ),
                ),
              ),

              // Fill remaining space similar to screenshot
              Expanded(child: Container()),
            ],
          );
        }),
      ),
    );
  }
}
