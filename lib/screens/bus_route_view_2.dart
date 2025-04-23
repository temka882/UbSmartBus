import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';

class BusRouteView2 extends StatefulWidget {
  final String routeNumber;

  const BusRouteView2({super.key, required this.routeNumber});

  @override
  State<BusRouteView2> createState() => _BusRouteView2State();
}

class _BusRouteView2State extends State<BusRouteView2> {
  List<String> busStops = [];
  int currentStopIndex = 0;
  Timer? _busTimer;
  bool _alertEnabled = true;

  @override
  void initState() {
    super.initState();
    fetchBusStops();
  }

  @override
  void dispose() {
    _busTimer?.cancel();
    super.dispose();
  }

  void startBusAnimation() {
    _busTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted && busStops.isNotEmpty) {
        setState(() {
          currentStopIndex = (currentStopIndex + 1) % busStops.length;
        });

        final currentStop = busStops[currentStopIndex];

        if (_alertEnabled && currentStop == "10-р хороолол") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Анхааруулга"),
              content: const Text("Автобус 10-р хороолол буудалд хүрлээ."),
              actions: [
                TextButton(
                  child: const Text("Ойлголоо"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  Future<void> fetchBusStops() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('routes')
          .doc(widget.routeNumber)
          .get();

      final data = doc.data();
      if (data != null && data.containsKey('busStops')) {
        setState(() {
          busStops = List<String>.from(data['busStops']).reversed.toList();
          currentStopIndex = 0;
        });
        startBusAnimation();
      }
    } catch (e) {
      debugPrint('Error loading route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, cs),
            busStops.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: teal),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: ListView.builder(
                        itemCount: busStops.length,
                        itemBuilder: (context, index) {
                          final isCurrent = index == currentStopIndex;
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      if (index != 0)
                                        Container(
                                            height: 25,
                                            width: 3,
                                            color: cs.onSurface),
                                      AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Icon(
                                          Icons.directions_bus,
                                          key: ValueKey(isCurrent),
                                          color:
                                              isCurrent ? teal : cs.onSurface,
                                          size: 35,
                                        ),
                                      ),
                                      if (index != busStops.length - 1)
                                        Container(
                                            height: 50,
                                            width: 3,
                                            color: cs.onSurface),
                                    ],
                                  ),
                                  const SizedBox(width: 28),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          busStops[index],
                                          style: TextStyle(
                                            color: cs.onSurface,
                                            fontSize: 25,
                                            fontWeight: isCurrent
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                        if (index % 3 == 0)
                                          const Text(
                                            ' Ачаалал ихтэй',
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, size: 30, color: teal),
                        SizedBox(width: 10),
                        Text(
                          "Эхлэх цэг",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme cs) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 200,
        width: double.infinity,
        color: cs.primary,
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
                      color: cs.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: cs.onSurface.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon:
                          Icon(Icons.arrow_back, color: cs.onSurface, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 115,
              left: 80,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cs.onSurface.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text("5 min later",
                        style: TextStyle(color: cs.onSurface, fontSize: 20)),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        _alertEnabled
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        color: cs.onSurface,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          _alertEnabled = !_alertEnabled;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _alertEnabled
                                  ? 'Сануулагч идэвхжсэн'
                                  : 'Сануулагч идэвхгүй болсон',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
