import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDebugScreen extends StatelessWidget {
  const FirestoreDebugScreen({super.key});

  Future<void> insertRoutesToFirebase() async {
    final firestore = FirebaseFirestore.instance;

    final routesData = [
      {
        'routeId': 'Ч:29Б',
        'routeName': 'Сансарын тунель-Вокзал',
        'busStops': [
          'Сансарын тунель',
          'Чингис хаан зочид буудал',
          'Хөдөлмөрийн яам',
          'МУБИС',
          'Аерофлот',
          'Аерофлотasd',
          'Барс худалдааны төв',
          'Вокзал'
        ],
      },
      {
        'routeId': 'М:1А',
        'routeName': '5 шар - Мөнгөн завьяа',
        'busStops': [
          '5 шар',
          'Хар хорин',
          'Саппоро',
          '3-р эмнэлэг',
          '10-р хороолол',
          'ТБД андууд',
          'Баруун 4 зам',
          'Улсын их дэлгүүр',
          'Мөнгөн завьяа'
        ],
      },
      {
        'routeId': 'М:1Б',
        'routeName': 'Офицеруудын ордон - Сүхбаатарын талбай',
        'busStops': [
          'Офицеруудын ордон',
          'Баянзүрх дүүрэг',
          'Монгол кино үйлдвэр',
          'Жуковын музей',
          'Зүүн 4 зам',
          'МУБИС',
          'Сүхбаатарын талбай'
        ],
      },
    ];

    final busesData = [
      {'busId': '1-001', 'routeName': 'Сансарын тунель-Вокзал'},
      {'busId': '1-002', 'routeName': 'Сансарын тунель-Вокзал'},
      {'busId': '1-003', 'routeName': 'Сансарын тунель-Вокзал'},
      {'busId': '1-004', 'routeName': 'Сансарын тунель-Вокзал'},
      {'busId': '1-005', 'routeName': '5 шар - Мөнгөн завьяа'},
      {'busId': '1-006', 'routeName': '5 шар - Мөнгөн завьяа'},
      {'busId': '1-007', 'routeName': '5 шар - Мөнгөн завьяа'},
      {'busId': '1-008', 'routeName': '5 шар - Мөнгөн завьяа'},
      {'busId': '1-009', 'routeName': 'Офицеруудын ордон - Сүхбаатарын талбай'},
      {'busId': '1-010', 'routeName': 'Офицеруудын ордон - Сүхбаатарын талбай'},
      {'busId': '1-011', 'routeName': 'Офицеруудын ордон - Сүхбаатарын талбай'},
      {'busId': '1-012', 'routeName': 'Офицеруудын ордон - Сүхбаатарын талбай'},
    ];

    for (final route in routesData) {
      await firestore.collection('routes').doc(route['routeId'] as String).set({
        'routeName': route['routeName'],
        'busStops': route['busStops'], // <- Only strings
      });
    }

    for (final bus in busesData) {
      await firestore.collection('buses').doc(bus['busId'] as String).set(bus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Firestore Routes'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            onPressed: () async {
              await insertRoutesToFirebase();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data inserted successfully!')),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('routes').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No routes found.'));
          }

          final routes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              final routeName = route['routeName'];
              final stops = List<String>.from(route['busStops']);
              return ListTile(
                title: Text(routeName),
                subtitle: Text(stops.join(' → ')),
              );
            },
          );
        },
      ),
    );
  }
}
