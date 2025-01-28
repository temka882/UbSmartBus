class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();

  factory FavoritesManager() => _instance;

  FavoritesManager._internal();

  final List<Map<String, String>> _busStops = [];
  final List<Map<String, String>> _buses = [];

  // Getters for both bus stops and buses
  List<Map<String, String>> get busStops => _busStops;
  List<Map<String, String>> get buses => _buses;

  get favorites => null;

  // Add a bus stop to favorites
  void addBusStop(Map<String, String> stop) {
    if (!_busStops.contains(stop)) {
      _busStops.add(stop);
    }
  }

  // Add a bus to favorites
  void addBus(Map<String, String> bus) {
    if (!_buses.contains(bus)) {
      _buses.add(bus);
    }
  }

  // Remove a bus stop from favorites
  void removeBusStop(Map<String, String> stop) {
    _busStops.remove(stop);
  }

  // Remove a bus from favorites
  void removeBus(Map<String, String> bus) {
    _buses.remove(bus);
  }

  // Check if a bus stop is in favorites
  bool isBusStopFavorite(Map<String, String> stop) {
    return _busStops.contains(stop);
  }

  // Check if a bus is in favorites
  bool isBusFavorite(Map<String, String> bus) {
    return _buses.contains(bus);
  }
}
