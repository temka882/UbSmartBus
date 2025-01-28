import 'package:flutter_application_1/consts/consts.dart';

class BusStopScreen extends StatefulWidget {
  const BusStopScreen({super.key});

  @override
  State<BusStopScreen> createState() => _BusStopScreenState();
}

class _BusStopScreenState extends State<BusStopScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _busStopList = [];
  List<Map<String, String>> _filteredBusStopList = [];

  @override
  void initState() {
    super.initState();

    // Initialize bus stop list
    _busStopList = List.generate(
      8,
      (index) => {
        "stopNumber": "${index + 1}",
        "stopName": "Буудлын нэр",
      },
    );
    _filteredBusStopList = _busStopList;
  }

  void _filterBusStops(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBusStopList = _busStopList;
      });
    } else {
      setState(() {
        _filteredBusStopList = _busStopList
            .where((stop) =>
                stop["stopNumber"]!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                stop["stopName"]!.toLowerCase().contains(query.toLowerCase()))
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
                          "Автобусны буудал",
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
                              _filteredBusStopList = _busStopList;
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
                        hintText: "Автобусны буудал хайх",
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
                      onChanged: _filterBusStops,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add spacing
          Expanded(
            child: Container(
              color: Colors.black, // Background color for the list
              child: ListView.builder(
                itemCount: _filteredBusStopList.length,
                itemBuilder: (context, index) {
                  final stop = _filteredBusStopList[index];
                  return InkWell(
                    onTap: () {
                      // Handle item tap here
                      print("Tapped on: ${stop["stopName"]}");
                    },
                    child: BusStopItem(
                      stopNumber: stop["stopNumber"]!,
                      stopName: stop["stopName"]!,
                      isFavorite: index % 2 == 0, // Sample favorite condition
                      onFavoriteToggle: (isFav) {
                        setState(() {
                          if (isFav) {
                            FavoritesManager().addBusStop({
                              "stopNumber": stop["stopNumber"]!,
                              "stopName": stop["stopName"]!,
                            });
                          } else {
                            FavoritesManager().removeBusStop({
                              "stopNumber": stop["stopNumber"]!,
                              "stopName": stop["stopName"]!,
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
