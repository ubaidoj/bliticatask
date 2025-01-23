import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<UserModel> _users = [];
  bool _isLoading = false;
  int _page = 1;
  Position? _currentPosition;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  // Fetch users with pagination
  // Fetch users with pagination
Future<void> fetchUsers({bool isLoadMore = false}) async {
  if (_isLoading) return;

  _isLoading = true;
  notifyListeners();

  try {
    print("Fetching users from API...");
    List<UserModel> fetchedUsers = await _apiService.fetchUsers(_page, 10);

    print("Fetched ${fetchedUsers.length} users from API");

    // Get the current location
    await _getCurrentLocation();
    print("Current Position: $_currentPosition");

    if (_currentPosition != null) {
      fetchedUsers = fetchedUsers.map((user) {
        if (user.latitude != 0.0 && user.longitude != 0.0) {
          user.distance = _calculateDistance(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            user.latitude,
            user.longitude,
          );
          print("User: ${user.name}, Distance: ${user.distance?.toStringAsFixed(2)} km");
        } else {
          print("User: ${user.name} has invalid coordinates");
        }
        return user;
      }).toList();
    } else {
      print("Current location is not available. Skipping distance calculation.");
    }

    _users.addAll(fetchedUsers);
    _page++;
  } catch (e) {
    print("Error fetching users: $e");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

Future<void> _getCurrentLocation() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled. Please enable them.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied by user.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied by user.");
      return;
    }

    // Get the current position
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(
        "Current location fetched successfully: Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}");
  } catch (e) {
    print("Error while fetching location: $e");
  }
}

double _calculateDistance(
    double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
  try {
    double distance = Geolocator.distanceBetween(
          startLatitude, startLongitude, endLatitude, endLongitude) /
        1000;
    print(
        "Distance calculated: Start [Lat: $startLatitude, Long: $startLongitude], End [Lat: $endLatitude, Long: $endLongitude], Distance: $distance km");
    return distance;
  } catch (e) {
    print("Error calculating distance: $e");
    return 0.0;
  }
}

}