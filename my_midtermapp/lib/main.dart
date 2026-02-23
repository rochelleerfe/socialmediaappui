import 'package:flutter/material.dart';
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

class MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // This is the "Magic" method that allows Dashboard cards to change the page
  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // DEFINING THE PAGES
  final List<Widget> _pages = [
    const MagicDashboard(),      // Index 0
    const MagicFeedPage(),       // Index 1
    const SquadsPage(),          // Index 2
    const MagicClipsPage(),      // Index 3
    const GrimoireProfilePage(), // Index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: setSelectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F0F11),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.white24,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.shield_rounded), label: 'Squads'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Clips'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Grimoire'),
        ],
      ),
    );
  }
}

// --- 0. DASHBOARD PAGE ---
class MagicDashboard extends StatelessWidget {
  const MagicDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WIZARD HUB', style: GoogleFonts.cinzel(color: const Color(0xFFFFD700))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 1, // Changed to 1 for a "List Card" look, or keep 2 for Grid
        childAspectRatio: 2.5, // Adjusts height of the cards
        mainAxisSpacing: 15,
        children: [
          // 1. INPUT FEED DATA HERE
          _buildCard(
            context,
            "Magic Feed",
            "See the latest magic scrolls and updates.", // Description
            "https://fictionhorizon.com/wp-content/uploads/2022/08/ElementalMagic.jpg", // Image URL
            1, // Navigation Index
          ),

          // 2. INPUT SQUADS DATA HERE
          _buildCard(
            context,
            "Squads",
            "Join a magic knight squad and earn merit.", // Description
            "https://tse3.mm.bing.net/th/id/OIP.azNyqp5R-_xgct5onAh0FQAAAA?rs=1&pid=ImgDetMain&o=7&rm=3", // Image URL
            2,
          ),

          // 3. INPUT CLIPS DATA HERE
          _buildCard(
            context,
            "Magic Clips",
            "Watch intense combat mana highlights.", // Description
            "https://th.bing.com/th/id/OIP.pjjWtrR-2UeOWLqa4yR6ewHaEK?w=308&h=180&c=7&r=0&o=7&pid=1.7&rm=3", // Image URL
            3,
          ),
        ],
      ),
    );
  }

  // UPDATED BUILD CARD: Now accepts description and image
  Widget _buildCard(BuildContext context, String title, String description, String imageUrl, int index) {
    return GestureDetector(
      onTap: () {
        final navState = context.findAncestorStateOfType<MainNavigationState>();
        navState?.setSelectedIndex(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken), // Darkens image so text is readable
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.philosopher(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFFFFD700))),
              const SizedBox(height: 5),
              Text(description,
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}


// --- 1. FEED PAGE ---
// --- 1. MAGIC FEED PAGE ---
class MagicFeedPage extends StatefulWidget {
  const MagicFeedPage({super.key});

  @override
  State<MagicFeedPage> createState() => _MagicFeedPageState();
}

class _MagicFeedPageState extends State<MagicFeedPage> {
  // 1. Controller para makuha ang text sa input box
  final TextEditingController _spellController = TextEditingController();

  // 2. Listahan ng mga posts (Dito nanggagaling ang output)
  final List<String> _magicPosts = [
    "Exploring the forbidden forest...",
    "Learning a new fireball spell!",
  ];

  // 3. Function para magdagdag ng post
  void _castSpell() {
    if (_spellController.text.isNotEmpty) {
      setState(() {
        // Nagdadagdag sa unahan ng listahan (index 0)
        _magicPosts.insert(0, _spellController.text);
        _spellController.clear(); // Nililinis ang box pagkatapos mag-post
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Magic Feed")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _spellController, // I-connect ang controller
              decoration: InputDecoration(
                hintText: "Cast a spell (post an update)...",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.auto_fix_high),
                // Button sa loob ng TextField para mapindot
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: _castSpell,
                ),
              ),
              onSubmitted: (_) => _castSpell(), // Gagana rin pag pinindot ang 'Enter'
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _magicPosts.length, // Dynamic na bilang base sa listahan
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: const Text("Mage Update"),
                    subtitle: Text(_magicPosts[index]), // Output na nababago
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _magicPosts.removeAt(index); // Option para makapag-delete
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// --- 2. SQUADS PAGE ---

class SquadsPage extends StatelessWidget {
  const SquadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Squads & Guilds"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSquadCard(
              "Golden Dawn",
              "125 Stars • 10 Members",
              "https://staticg.sportskeeda.com/editor/2022/03/437c2-16474506238788-1920.jpg"
          ),
          const SizedBox(height: 16),
          _buildSquadCard(
              "Black Bulls",
              "101 Stars • 15 Members",
              "https://wallpapers.com/images/hd/black-bull-members-black-clover-anime-wisn6p4celnaavo9.jpg"
          ),
        ],
      ),
    );
  }

  // Dito dapat nakalagay ang method sa loob ng class
  Widget _buildSquadCard(String name, String stats, String imageUrl) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias, // Siguradong maka-clip ang image sa card corners
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CLIPABLE IMAGE AREA
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
              // Optional: Gradient overlay para mas madaling basahin ang text kung lalagyan mo
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stats,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("JOIN"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
// Huling brace ng class
}// --- 3. CLIPS PAGE ---
class MagicClipsPage extends StatelessWidget {
  const MagicClipsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Clips")),
    body: const Center(child: Icon(Icons.play_circle_fill, size: 100, color: Colors.purple)),
  );
}

// --- 4. PROFILE PAGE ---
class GrimoireProfilePage extends StatelessWidget {
  const GrimoireProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Grimoire"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Para hindi mag-error sa maliit na screen
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- 1. PROFILE IMAGE ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.indigo,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/e4/aa/da/e4aada8aa6cec61d761ca36fd038fb5d.jpg',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star, color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- 2. PROFILE TEXT (NAME & TITLE) ---
            const Text(
              "Asta of the Black Bulls",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Level 99 Archmage",
              style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1.5),
            ),

            const SizedBox(height: 30),

            // --- 3. STATS SECTION (IMAGE + TEXT) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem("Mana", "9999", Icons.bolt),
                  _buildStatItem("Rank", "Grand", Icons.workspace_premium),
                  _buildStatItem("Wins", "450", Icons.sunny),
                ],
              ),
            ),

            const Divider(height: 50, thickness: 1, indent: 40, endIndent: 40),

            // --- 4. BIO / DESCRIPTION ---
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "My magic is never giving up! I will become the Wizard King and protect everyone in the Clover Kingdom.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method para sa Stats
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo, size: 30),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}