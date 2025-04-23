import 'package:flutter_application_1/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusRouteScreen extends StatefulWidget {
  const BusRouteScreen({super.key});

  @override
  State<BusRouteScreen> createState() => _BusRouteScreenState();
}

class _BusRouteScreenState extends State<BusRouteScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _busList = [];
  List<Map<String, String>> _filteredBusList = [];

  @override
  void initState() {
    super.initState();
    fetchBusRoutes(); // Fetch data from Firestore on screen load
  }

  // Fetch bus routes data from Firebase Firestore
  Future<void> fetchBusRoutes() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('routes').get();
      final List<Map<String, String>> busList = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        busList.add({
          'routeNumber': doc.id, // Use routeId as route number
          'destination': data['routeName'] ??
              'No Destination', // Use routeName as destination
        });
      }

      setState(() {
        _busList = busList;
        _filteredBusList = busList;
      });

      print("Loaded ${_busList.length} bus routes.");
    } catch (e) {
      debugPrint('Error loading bus routes: $e');
    }
  }

  // Filter buses based on user search query
  void _filterBuses(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBusList = _busList;
      });
    } else {
      setState(() {
        _filteredBusList = _busList
            .where((bus) =>
                bus["routeNumber"]!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                bus["destination"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
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
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cs.primary,
                border: Border.all(width: 1, color: cs.onSurface),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: cs.onPrimary, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          "Автобусны чиглэл",
                          style: TextStyle(
                            color: teal,
                            fontSize: 30,
                            fontFamily: bold,
                            height: 1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh,
                              color: cs.onPrimary, size: 30),
                          onPressed: () {
                            setState(() {
                              _filteredBusList = _busList;
                              _searchController.clear();
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: cs.onPrimary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cs.primary,
                        hintText: "Автобусны чиглэл хайх",
                        hintStyle: TextStyle(
                            color: cs.onPrimary.withOpacity(0.6), fontSize: 20),
                        prefixIcon:
                            Icon(Icons.search, color: cs.onPrimary, size: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: _filterBuses,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bus list
          Expanded(
            child: Container(
              color: cs.surface,
              child: ListView.builder(
                itemCount: _filteredBusList.length,
                itemBuilder: (context, index) {
                  final bus = _filteredBusList[index];
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
                      isFavorite: index % 2 == 0,
                      onFavoriteToggle: (isFav) {
                        setState(() {
                          if (isFav) {
                            FavoritesManager().addBus({
                              "routeNumber": bus["routeNumber"]!,
                              "destination": bus["destination"]!,
                            });
                          } else {
                            FavoritesManager().removeBus({
                              "routeNumber": bus["routeNumber"]!,
                              "destination": bus["destination"]!,
                            });
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
