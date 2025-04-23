import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/home_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 4;
  String selectedLanguage = 'English';
  final ThemeController _themeController = Get.find<ThemeController>();

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    final screens = [
      const HomePage(),
      const FavoriteScreen(),
      null,
      const CardScreen(),
      const Settings(),
    ];

    if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('location_screen_not_ready'.tr)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screens[index]!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          _buildHeader(cs),
          Expanded(
            child: ListView(
              children: [
                // Language Selector
                Container(
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListTile(
                    title: Text('language'.tr,
                        style: TextStyle(color: cs.onPrimary)),
                    trailing: DropdownButton<Locale>(
                      value: selectedLanguage == 'English'
                          ? const Locale('en', 'US')
                          : const Locale('mn', 'MN'),
                      dropdownColor: cs.primary,
                      onChanged: (Locale? newLocale) {
                        if (newLocale != null) {
                          setState(() {
                            selectedLanguage = newLocale.languageCode == 'en'
                                ? 'English'
                                : 'Монгол';
                          });
                          Get.updateLocale(newLocale);
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: Locale('en', 'US'),
                          child:
                              Text("English", style: TextStyle(color: white)),
                        ),
                        DropdownMenuItem(
                          value: Locale('mn', 'MN'),
                          child: Text("Монгол", style: TextStyle(color: white)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 1),

                // Dark Mode Toggle
                Container(
                  color: cs.primary,
                  child: ListTile(
                    title: Text('dark_mode'.tr,
                        style: TextStyle(color: cs.onPrimary)),
                    trailing: Switch(
                      value: _themeController.isDarkMode.value,
                      onChanged: _themeController.toggleTheme,
                    ),
                  ),
                ),
                const SizedBox(height: 1),

                // Report an Issue
                Container(
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: ListTile(
                    title: Text('report_issue'.tr,
                        style: TextStyle(color: cs.onPrimary)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: cs.onPrimary),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: cs.primary,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30, color: cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 30, color: cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on, size: 30, color: cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card, size: 30, color: cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 30, color: teal), label: ''),
          ],
          backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: cs.primary,
          border: Border.all(width: 1),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 40,
              left: 25,
              child: Text('U',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: teal,
                  )),
            ),
            Positioned(
              top: 58,
              left: 78,
              child: Text(
                'settings'.tr,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimary,
                ),
              ),
            ),
            const Positioned(
              top: 75,
              left: 78,
              child: Text('money',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: teal,
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: cs.primary,
                child: Image.asset(ubpic, fit: BoxFit.fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
