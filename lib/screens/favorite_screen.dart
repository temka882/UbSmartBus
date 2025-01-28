import 'package:flutter_application_1/consts/consts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Two tabs: Bus Stops and Empty
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busStops = FavoritesManager().busStops;
    final buses = FavoritesManager().buses;

    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: blackGrey,
                border: Border.all(width: 1),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Align back button to the start
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: white, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 100), // Adjust this value to move left
                          child: Text(
                            "Favorite",
                            style: TextStyle(
                                color: teal,
                                fontSize: 30,
                                fontFamily: bold,
                                height: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // Container for TabBar with circular background
          Container(
            decoration: BoxDecoration(
              color: blackGrey, // Set the background color for the TabBar
              borderRadius:
                  BorderRadius.circular(30), // Make the TabBar circular
            ),
            child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Автобусны буудал"),
                  Tab(text: "Автобус"),
                ],
                indicatorColor: teal,
                labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: teal // Color of the active tab label
                    )),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // First Tab: Bus Stops
                busStops.isEmpty
                    ? const Center(
                        child: Text(
                          "No favorites yet",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemCount: busStops.length,
                        itemBuilder: (context, index) {
                          final stop = busStops[index];
                          return Card(
                            color: blackGrey,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                foregroundColor: teal,
                                backgroundColor: Colors.transparent,
                                child: Text(stop["stopNumber"] ?? ""),
                              ),
                              title: Text(
                                stop["stopName"] ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                // Second Tab: Empty Tab
                buses.isEmpty
                    ? const Center(
                        child: Text(
                          "No favorite buses yet",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemCount: buses.length,
                        itemBuilder: (context, index) {
                          final route = buses[index];
                          return Card(
                            color: blackGrey,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                foregroundColor: teal,
                                backgroundColor: Colors.transparent,
                                child: Text(route["routeNumber"] ?? ""),
                              ),
                              title: Text(
                                route["destination"] ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
