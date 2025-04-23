import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/screens/bus_stop_view.dart';

class BusStopScreen extends StatefulWidget {
  const BusStopScreen({super.key});

  @override
  State<BusStopScreen> createState() => _BusStopScreenState();
}

class _BusStopScreenState extends State<BusStopScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _busStopList = [];
  List<String> _filteredBusStopList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllStopNamesFromRoutes();
  }

  Future<void> fetchAllStopNamesFromRoutes() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('routes').get();

      final Set<String> allStops = {}; // use Set to avoid duplicates

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final busStops = List<String>.from(data['busStops'] ?? []);
        allStops.addAll(busStops);
      }

      setState(() {
        _busStopList = allStops.toList();
        _filteredBusStopList = _busStopList;
        _isLoading = false;
      });

      print("Loaded ${_busStopList.length} unique stop names.");
    } catch (e) {
      debugPrint('Error loading stop names: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterBusStops(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBusStopList = _busStopList;
      });
    } else {
      setState(() {
        _filteredBusStopList = _busStopList
            .where((stop) => stop.toLowerCase().contains(query.toLowerCase()))
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
                border: Border.all(width: 1),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: cs.onSurface,
                            size: 30,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          "Автобусны буудал",
                          style: TextStyle(
                            color: teal,
                            fontSize: 30,
                            fontFamily: bold,
                            height: 1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: cs.onSurface,
                            size: 30,
                          ),
                          onPressed: () {
                            fetchAllStopNamesFromRoutes();
                            _searchController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: cs.onSurface),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cs.primary,
                        hintText: "Автобусны буудал хайх",
                        hintStyle: TextStyle(
                          color: cs.onSurface,
                          fontSize: 20,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: cs.onSurface,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: _filterBusStops,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Bus Stop List Section
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredBusStopList.isEmpty
                    ? Center(
                        child: Text(
                          "No bus stops found",
                          style: TextStyle(color: cs.onSurface),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredBusStopList.length,
                        itemBuilder: (context, index) {
                          final stopName = _filteredBusStopList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BusStopViewn(
                                    stopNumber: "", // no number needed
                                    stopName: stopName,
                                  ),
                                ),
                              );
                            },
                            child: BusStopItem(
                              stopNumber: "", // not shown
                              stopName: stopName,
                              isFavorite: index % 2 == 0,
                              onFavoriteToggle: (isFav) {
                                setState(() {
                                  if (isFav) {
                                    FavoritesManager().addBusStop({
                                      "stopName": stopName,
                                    });
                                  } else {
                                    FavoritesManager().removeBusStop({
                                      "stopName": stopName,
                                    });
                                  }
                                });
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
