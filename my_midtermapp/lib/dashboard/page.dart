import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CloverGramApp());
}

class CloverGramApp extends StatelessWidget {
  const CloverGramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0B),
        // Fix: Ensure GoogleFonts is called correctly
        textTheme: GoogleFonts.philosopherTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MainNavigation(),
    );
  }
}

// --- MAIN NAVIGATION ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  MainNavigationState createState() => MainNavigationState();
}

// FIXED: Removed the underscore '_' so MagicDashboard can find this state
class MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Method to allow other pages to change the active tab
  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const MagicDashboard(),
    const MagicFeedPage(),
    const SquadsPage(),
    const MagicClipsPage(),
    const GrimoireProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex > 4 ? 0 : _selectedIndex,
        onTap: setSelectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F0F11),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.white24,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Squads'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Clips'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Grimoire'),
        ],
      ),
    );
  }
}

// --- NEW DASHBOARD PAGE (Clickable Items) ---
class MagicDashboard extends StatelessWidget {
  const MagicDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text('WIZARD HUB',
                style: GoogleFonts.cinzel(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFFFFD700))),
            const Text('Tap a feature to activate your mana', style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _dashboardCard(context, 'Magic Feed', Icons.auto_awesome, const Color(0xFFC62828), 1),
                  _dashboardCard(context, 'Squads', Icons.shield, const Color(0xFFFFD700), 2),
                  _dashboardCard(context, 'Magic Clips', Icons.play_circle_fill, Colors.blueAccent, 3),
                  _dashboardCard(context, 'My Grimoire', Icons.menu_book, Colors.purpleAccent, 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(BuildContext context, String title, IconData icon, Color color, int pageIndex) {
    return Material(
      color: const Color(0xFF161618),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          // This finds the MainNavigationState and calls the setSelectedIndex method
          final mainNav = context.findAncestorStateOfType<MainNavigationState>();
          if (mainNav != null) {
            mainNav.setSelectedIndex(pageIndex);
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder classes so the code runs
class MagicFeedPage extends StatelessWidget { const MagicFeedPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("Feed")); }
class SquadsPage extends StatelessWidget { const SquadsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("Squads")); }
class MagicClipsPage extends StatelessWidget { const MagicClipsPage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("Clips")); }
class GrimoireProfilePage extends StatelessWidget { const GrimoireProfilePage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text("Profile")); }