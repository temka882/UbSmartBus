import 'package:flutter_application_1/consts/consts.dart';

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

    // Initialize bus list
    _busList = List.generate(
      8,
      (index) => {
        "routeNumber": "Ч:${index + 1}",
        "destination": "Чиглэл",
      },
    );
    _filteredBusList = _busList;
  }

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
    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: blackGrey,
                border: Border.all(width: 1),
              ),
              child: Column(
                children: [
                  // App Bar Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Navigate back
                          },
                        ),

                        // Title
                        const Text(
                          "Автобусны чиглэл",
                          style: TextStyle(
                              color: teal,
                              fontSize: 30,
                              fontFamily: bold,
                              height: 1),
                        ),

                        // Refresh Button
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 30,
                          ),
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

                  // Search Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: blackGrey,
                        hintText: "Автобусны чиглэл хайх",
                        hintStyle:
                            const TextStyle(color: lightGrey, fontSize: 20),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: white,
                          size: 30,
                        ),
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
          // Add spacing
          Expanded(
            child: Container(
              color: black, // Background color for the list
              child: ListView.builder(
                itemCount: _filteredBusList.length,
                itemBuilder: (context, index) {
                  final bus = _filteredBusList[index];
                  return InkWell(
                    onTap: () {
                      // Pass data to BusRouteView
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
                      isFavorite: index % 2 == 0, // Sample favorite condition
                      onFavoriteToggle: (isFav) {
                        setState(() {
                          if (isFav) {
                            FavoritesManager().addBusStop({
                              "routeNumber": bus["routeNumber"]!,
                              "destination": bus["destination"]!,
                            });
                          } else {
                            FavoritesManager().removeBusStop({
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
