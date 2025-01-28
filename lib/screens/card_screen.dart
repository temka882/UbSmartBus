import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/home_page.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _selectedIndex = 0; // Track the active tab

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings screen not implemented yet.')),
      );
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('location screen not implemented yet.')),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Column(children: [
        Expanded(
          child: Image.asset(
            'assets/images/aa.png', // Replace with the correct path
            fit: BoxFit.cover, // Adjust the fit to cover the screen width
            width: 470, // Use full width
            height: 200, // Set a fixed height for the image
          ),
        ),
      ]),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 70, // Fixed height for the bottom navigation bar
        margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        decoration: BoxDecoration(
          color: blackGrey, // Background color of the container
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: blackGrey.withOpacity(0.5), // Subtle shadow effect
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5), // Shadow position
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: white,
              ), // Adjust icon size
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: white,
              ), // Adjust icon size
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on,
                size: 30,
                color: white,
              ), // Adjust icon size
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.credit_card,
                size: 30,
                color: teal,
              ), // Adjust icon size
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30,
                color: white,
              ), // Adjust icon size
              label: '', // Empty label
            ),
          ],
          backgroundColor: Colors
              .transparent, // Transparent to show custom container background
          // Inactive icon color
          currentIndex: _selectedIndex, // Active tab index
          onTap: _onItemTapped, // Handles navigation
          type: BottomNavigationBarType.fixed, // Equal spacing for all items
          showSelectedLabels: false, // Hides selected labels
          showUnselectedLabels: false, // Hides unselected labels
          elevation: 0, // Removes the bottom shadow
        ),
      ),
    );
  }

  Widget buildCustomButton({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 33, 33, 1),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF0DBA89),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
