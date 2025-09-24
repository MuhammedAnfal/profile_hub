import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_hub/core/api/api_client.dart';
import 'package:profile_hub/core/api/api_response.dart';
import 'package:profile_hub/core/api/endpoints.dart';
import 'package:profile_hub/models/user_model.dart';

final homeRepositoryProvider = Provider((ref) {
  return HomeRepository();
});

class HomeRepository {
  final ApiClient _apiClient;
  HomeRepository() : _apiClient = ApiClient();

  Future<ApiResponse<List<UserModel>>> fetchUsers() async {
    try {
      //-- fetching and convert to usermodel
      return await _apiClient.get(
        fromJson: (json) => (json as List).map((e) => UserModel.fromJson(e)).toList(),
        Endpoints.users,
      );
    } catch (e) {
      rethrow;
    }
  }
}
