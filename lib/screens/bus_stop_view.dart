import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';

class BusStopViewn extends StatefulWidget {
  final String stopNumber;
  final String stopName;

  const BusStopViewn({
    super.key,
    required this.stopNumber,
    required this.stopName,
  });

  @override
  State<BusStopViewn> createState() => _BusStopViewnState();
}

class _BusStopViewnState extends State<BusStopViewn> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredBusList = [];

  @override
  void initState() {
    super.initState();
    fetchRoutesForBusStop(widget.stopName);
  }

  Future<void> fetchRoutesForBusStop(String stopName) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('routes').get();
    final List<Map<String, String>> matchedRoutes = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final List<dynamic> stops = data['busStops'] ?? [];

      if (stops.contains(stopName)) {
        matchedRoutes.add({
          'routeNumber': doc.id,
          'destination': data['routeName'],
        });
      }
    }

    setState(() {
      _filteredBusList = matchedRoutes;
    });
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
                          icon: Icon(Icons.arrow_back,
                              color: cs.onSurface, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          'bus_stops'.tr,
                          style: const TextStyle(
                            color: teal,
                            fontSize: 25,
                            fontFamily: bold,
                            height: 1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh,
                              color: cs.onSurface, size: 30),
                          onPressed: () {
                            fetchRoutesForBusStop(widget.stopName);
                            _searchController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.stopName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: cs.surface,
              child: _filteredBusList.isEmpty
                  ? const Center(
                      child: Text(
                        'No routes found for this stop.',
                        style: TextStyle(color: white),
                      ),
                    )
                  : ListView.builder(
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
                            isFavorite: FavoritesManager().isFavoriteBus(bus),
                            onFavoriteToggle: (isFav) {
                              setState(() {
                                if (isFav) {
                                  FavoritesManager().addBus(bus);
                                } else {
                                  FavoritesManager().removeBus(bus);
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
