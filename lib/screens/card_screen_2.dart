import 'package:flutter_application_1/consts/consts.dart';

class CardScreen2 extends StatefulWidget {
  const CardScreen2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardScreen2State createState() => _CardScreen2State();
}

class _CardScreen2State extends State<CardScreen2> {
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
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cs.primary,
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 40,
                    left: 25,
                    child: Text(
                      'U',
                      style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: teal),
                    ),
                  ),
                  Positioned(
                    top: 58,
                    left: 78,
                    child: Text(
                      'charge'.tr,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface),
                    ),
                  ),
                  const Positioned(
                    top: 75,
                    left: 78,
                    child: Text(
                      'money',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: teal),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 330,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_presentation_rounded,
                            color: teal,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Apply rounding
            child: Container(
              height: 250,
              width: 500,
              decoration: BoxDecoration(color: cs.primary),
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 15,
                    child: ClipRRect(
                      // Ensure the image itself is rounded
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 220,
                        width: 380,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20), // Ensure rounded corners
                        ),
                        child: Image.asset(
                          card1,
                          fit: BoxFit.cover, // Ensure it covers properly
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                color: cs.primary,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirestoreDebugScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "charge".tr, // Text after the icon
                      style: TextStyle(
                        color: cs.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Ensures it stays left
            children: [
              SizedBox(
                  width: 20), // Adjust this value to shift text slightly right
              Text(
                "card_text5".tr,
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.history, color: teal, size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Суусан",
                                  style: TextStyle(
                                      color: cs.onSurface, fontSize: 18)),
                              Text("2025.03.15 20:06",
                                  style: TextStyle(
                                      color: cs.onSurface, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("-1'000₮",
                              style:
                                  TextStyle(color: cs.onSurface, fontSize: 18)),
                          Text("2'000₮",
                              style:
                                  TextStyle(color: cs.onSurface, fontSize: 14)),
                        ],
                      ),
                    ],
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
