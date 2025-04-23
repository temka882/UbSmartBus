class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Map<String, String>> _busStops = [];
  final List<Map<String, String>> _buses = [];

  List<Map<String, String>> get busStops => _busStops;
  List<Map<String, String>> get buses => _buses;

  void addBusStop(Map<String, String> stop) {
    if (!_busStops.any((item) => item["stopName"] == stop["stopName"])) {
      _busStops.add(stop);
    }
  }

  void removeBusStop(Map<String, String> stop) {
    _busStops.removeWhere((item) => item["stopName"] == stop["stopName"]);
  }

  bool isFavoriteStop(Map<String, String> stop) {
    return _busStops.any((item) => item["stopName"] == stop["stopName"]);
  }

  void addBus(Map<String, String> bus) {
    if (!_buses.any((item) =>
        item["routeNumber"] == bus["routeNumber"] &&
        item["destination"] == bus["destination"])) {
      _buses.add(bus);
    }
  }

  void removeBus(Map<String, String> bus) {
    _buses.removeWhere((item) =>
        item["routeNumber"] == bus["routeNumber"] &&
        item["destination"] == bus["destination"]);
  }

  bool isFavoriteBus(Map<String, String> bus) {
    return _buses.any((item) =>
        item["routeNumber"] == bus["routeNumber"] &&
        item["destination"] == bus["destination"]);
  }
}
