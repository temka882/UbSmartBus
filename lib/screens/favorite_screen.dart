import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/bus_stop_view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CardScreen()),
      );
    } else if (index == 4 || index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildTabBar(),
          Expanded(child: _buildTabBarView()),
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
                icon: Icon(Icons.favorite, size: 30, color: teal), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on, size: 30, color: white),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card, size: 30, color: white),
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

  Widget _buildHeader() {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: cs.primary,
          border: Border.all(width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: cs.onSurface, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 45),
              Text(
                'favorites'.tr,
                style: const TextStyle(
                  color: teal,
                  fontSize: 35,
                  fontFamily: bold,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: cs.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: 'bus_stop'.tr),
            Tab(text: 'bus'.tr),
          ],
          indicatorColor: teal,
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: teal,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildBusStopList(),
        _buildBusList(),
      ],
    );
  }

  Widget _buildBusStopList() {
    return ListView.builder(
      itemCount: FavoritesManager().busStops.length,
      itemBuilder: (context, index) {
        var stop = FavoritesManager().busStops[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusStopViewn(
                  stopNumber: stop["stopNumber"] ?? '',
                  stopName: stop["stopName"]!,
                ),
              ),
            );
          },
          child: BusStopItem(
            stopNumber: stop["stopNumber"] ?? '',
            stopName: stop["stopName"]!,
            isFavorite: true,
            onFavoriteToggle: (isFavorite) {
              setState(() {
                FavoritesManager().removeBusStop(stop);
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildBusList() {
    return ListView.builder(
      itemCount: FavoritesManager().buses.length,
      itemBuilder: (context, index) {
        var bus = FavoritesManager().buses[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusRouteView(
                  routeNumber: bus["routeNumber"]!,
                  destination: bus["destination"]!,
                ),
              ),
            );
          },
          child: BusItem(
            routeNumber: bus["routeNumber"]!,
            destination: bus["destination"]!,
            isFavorite: true,
            onFavoriteToggle: (isFavorite) {
              setState(() {
                FavoritesManager().removeBus(bus);
              });
            },
          ),
        );
      },
    );
  }
}
