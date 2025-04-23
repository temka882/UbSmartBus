import '../consts/consts.dart';

class BusItem extends StatefulWidget {
  final String routeNumber;
  final String destination;
  final ValueChanged<bool> onFavoriteToggle;

  const BusItem({
    super.key,
    required this.routeNumber,
    required this.destination,
    required bool isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<BusItem> createState() => _BusItemState();
}

class _BusItemState extends State<BusItem> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context)
          .colorScheme
          .primary, // Card background matches list background
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              widget.routeNumber,
              style: const TextStyle(
                  color: teal, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          title: Text(
            widget.destination,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
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
                  FavoritesManager().addBus({
                    "routeNumber": widget.routeNumber,
                    "destination": widget.destination,
                  });
                } else {
                  // Remove from favorites
                  FavoritesManager().removeBus({
                    "routeNumber": widget.routeNumber,
                    "destination": widget.destination,
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
