import 'package:flutter_application_1/consts/consts.dart';

class BusStopItem extends StatefulWidget {
  final String stopNumber;
  final String stopName;
  final ValueChanged<bool> onFavoriteToggle;

  const BusStopItem({
    super.key,
    required this.stopNumber,
    required this.stopName,
    required this.onFavoriteToggle,
    required bool isFavorite,
  });

  @override
  State<BusStopItem> createState() => _BusStopItemState();
}

class _BusStopItemState extends State<BusStopItem> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false; // Initialize as not favorite (inactive)
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.primary, // Card background matches list background
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: cs.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: teal,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  "", // or dynamic `widget.stopNumber` here
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            widget.stopName,
            style: TextStyle(color: cs.onSurface, fontSize: 20),
          ),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite; // Toggle the favorite state
                if (isFavorite) {
                  // Add to favorites
                  FavoritesManager().addBusStop({
                    "stopNumber": widget.stopNumber,
                    "stopName": widget.stopName,
                  });
                } else {
                  // Remove from favorites
                  FavoritesManager().removeBusStop({
                    "stopNumber": widget.stopNumber,
                    "stopName": widget.stopName,
                  });
                }
              });
              widget.onFavoriteToggle(isFavorite); // Notify the parent widget
            },
          ),
        ),
      ),
    );
  }
}
