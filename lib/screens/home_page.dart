import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/settings.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    final screens = [
      null,
      () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const FavoriteScreen())),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Settings())),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CardScreen())),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Settings())),
    ];

    screens[index]?.call();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cs.primary,
                border: Border.all(width: 2),
              ),
              child: Stack(
                children: [
                  const Positioned(
                      top: 60,
                      left: 20,
                      child: CircleAvatar(
                          radius: 25, backgroundImage: AssetImage(icbus2))),
                  Positioned.fill(
                    top: -30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Улаанбаатар ухаалаг автобус',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: teal)),
                        const SizedBox(height: 5),
                        Text('Нийтийн тээвэр',
                            style:
                                TextStyle(fontSize: 17, color: cs.onSurface)),
                      ],
                    ),
                  ),
                  Positioned(
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
          const SizedBox(height: 30),
          CustomButton(
              icon: Image.asset(bas1),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BusRouteScreen()))),
          const SizedBox(height: 20),
          CustomButton(
              icon: Image.asset(bas2),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BusStopScreen()))),
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
                icon: Icon(Icons.home,
                    size: 30, color: _selectedIndex == 0 ? teal : cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite,
                    size: 30, color: _selectedIndex == 1 ? teal : cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on,
                    size: 30, color: _selectedIndex == 2 ? teal : cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card,
                    size: 30, color: _selectedIndex == 3 ? teal : cs.onPrimary),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                    size: 30, color: _selectedIndex == 4 ? teal : cs.onPrimary),
                label: ''),
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
