import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

 Future<List<UserModel>> fetchUsers(int page, int results) async {
  try {
    final response = await _dio.get(
      "https://randomuser.me/api/",
      queryParameters: {"page": page, "results": results},
    );
    print("API Response: ${response.data}");
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['results'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  } catch (e) {
    print("Error fetching users from API: $e");
    rethrow;
  }
}

}

