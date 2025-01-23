class UserModel {
  final String name;
  final String profilePicture;
  final String location;
  final String phone;
  final String dob;
  final double latitude; 
  final double longitude; 
  double? distance;

  UserModel({
    required this.name,
    required this.profilePicture,
    required this.location,
    required this.phone,
    required this.dob,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

factory UserModel.fromJson(Map<String, dynamic> json) {
  final latitude = json['location']['coordinates']['latitude'];
  final longitude = json['location']['coordinates']['longitude'];
  print("User Coordinates: Latitude: $latitude, Longitude: $longitude");

  return UserModel(
    name: "${json['name']['first']} ${json['name']['last']}",
    profilePicture: json['picture']['large'],
    location: json['location']['city'],
    phone: json['phone'],
    dob: json['dob']['date'],
    latitude: double.tryParse(latitude ?? '0') ?? 0.0,
    longitude: double.tryParse(longitude ?? '0') ?? 0.0,
  );
}

}
