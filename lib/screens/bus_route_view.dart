// Ensure you have the correct imports
import 'package:flutter_application_1/consts/consts.dart';

class BusRouteView extends StatefulWidget {
  const BusRouteView({
    super.key,
    required this.routeNumber,
    required this.destination,
  });

  final String routeNumber;
  final String destination;

  @override
  State<BusRouteView> createState() => _BusRouteViewState();
}

class _BusRouteViewState extends State<BusRouteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          // Top Section
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: blackGrey,
                border: Border.all(width: 1),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 60,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Live Direction",
                          style: TextStyle(
                            color: teal,
                            fontSize: 30,
                            fontFamily: bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Move this '5 min later' container to a fixed place in the stack
                  Positioned(
                    top: 115, // Adjust top position to move the text upwards
                    left: 80,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "5 min later",
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                          const SizedBox(
                              width: 10), // Space between text and icon
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: white, // Bell icon color
                              size: 25,
                            ),
                            onPressed: () {
                              // Handle bell icon press here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Map or Image Section
          Expanded(
            child: Stack(
              children: [
                // Image as the background
                Image.asset(
                  pic1,
                  fit: BoxFit.fill, // Changed to cover for a consistent look
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Bottom Navigation Bar overlay
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50, // Fixed height for the bottom navigation bar
                    margin: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      color: blackGrey, // Background color of the container
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                          color: blackGrey
                              .withOpacity(0.5), // Subtle shadow effect
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 5), // Shadow position
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusRouteView2()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: teal,
                          ),
                          SizedBox(width: 10), // Space between icon and text
                          Text(
                            "Эхлэх цэг", // Text after the icon
                            style: TextStyle(
                              color: teal,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
