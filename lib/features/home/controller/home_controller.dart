import 'package:flutter_riverpod/legacy.dart';
import 'package:profile_hub/features/home/repository/home_repository.dart';
import 'package:profile_hub/models/user_model.dart';
import 'package:riverpod/riverpod.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue<List<UserModel>>>((ref) {
      return HomeController();
    });

class HomeController extends StateNotifier<AsyncValue<List<UserModel>>> {
  final HomeRepository _repository;

  HomeController() : _repository = HomeRepository(), super(const AsyncValue.loading());

  Future<List<UserModel>> fetchUsers({required String search}) async {
    //-- make the value loading
    state = const AsyncValue.loading();
    try {
      //-- getting data from repo
      final response = await _repository.fetchUsers();

      if (response.data == null || response.data!.isEmpty) {
        state = AsyncValue.data([]);
        return [];
      }

      //-- adding response to filtered users
      List<UserModel> filteredUsers = response.data!;

      //-- checking search is not empty and containes search
      if (search.isNotEmpty) {
        filteredUsers = response.data!
            .where((element) => element.name!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
      //-- make the state with filtered users
      state = AsyncValue.data(filteredUsers);

      //-- return it
      return filteredUsers;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
