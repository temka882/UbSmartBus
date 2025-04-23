import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/card_screen_2.dart';
import 'package:flutter_application_1/screens/settings.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the appropriate screen based on the index
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoriteScreen()),
      );
    } else if (index == 4) {
      // Navigate to Settings screen (placeholder for now)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Settings()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Settings()),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 270,
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
                    child: Text(
                      'U',
                      style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: teal),
                    ),
                  ),
                  Positioned(
                    top: 58,
                    left: 78,
                    child: Text(
                      'charge'.tr,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface),
                    ),
                  ),
                  const Positioned(
                    top: 75,
                    left: 78,
                    child: Text(
                      'money',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: teal),
                    ),
                  ),
                  Positioned(
                    top: 145, // Adjust top position to move the text upwards
                    left: 25,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "card_text1".tr,
                            style: TextStyle(color: cs.onSurface, fontSize: 15),
                          ),
                          const SizedBox(
                              width: 10), // Space between text and icon
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 144, // Adjust top position to move the text upwards
                    left: 300,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 0),
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.location_pin,
                              color: teal, // Bell icon color
                              size: 30,
                            ),
                            onPressed: () {
                              // Handle bell icon press here
                            },
                          ),
                          const SizedBox(
                              width: 10), // Space between text and icon
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 200,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          color: cs.primary,
                          child: Image.asset(ubpic, fit: BoxFit.fill))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 400,
              width: 550,
              decoration: BoxDecoration(color: cs.primary),
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      height: 370,
                      width: 380,
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 100,
                    child: Text(
                      'card_text2'.tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: teal),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 70,
                    child: Text(
                      'card_text3'.tr,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface),
                    ),
                  ),
                  Positioned(
                    top: 87.5,
                    left: 30,
                    child: Text(
                      'card_text4'.tr,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface),
                    ),
                  ),
                  Positioned(
                      top: 150,
                      bottom: 70,
                      left: 100,
                      right: 90,
                      child: Container(
                          color: cs.primary,
                          child: Image.asset(nfc, fit: BoxFit.fill))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: cs.primary,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CardScreen2()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'scan_card'.tr, // Text after the icon
                      style: TextStyle(
                        color: cs.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30, color: white), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 30, color: white), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on, size: 30, color: white),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card, size: 30, color: teal),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 30, color: white), label: ''),
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
}
