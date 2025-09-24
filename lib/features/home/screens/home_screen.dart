// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:profile_hub/core/api/api_exceptions.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';
import 'package:profile_hub/features/home/controller/home_controller.dart';
import 'package:profile_hub/features/home/screens/widgets/error_page.dart';
import 'package:profile_hub/features/home/screens/widgets/user_card.dart';
import 'dart:async';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    // Fetch users when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeControllerProvider.notifier).fetchUsers(search: '');
    });
  }

  //-- variables
  final searchField = StateProvider((ref) => '');

  //-- refresh functions to load users
  Future<void> _refreshData() async {
    await ref.read(homeControllerProvider.notifier).fetchUsers(search: _searchController.text);
  }

  //-- function works when searches
  void _onSearchChanged(String value) {
    _debouncer.run(() {
      ref.read(homeControllerProvider.notifier).fetchUsers(search: value);
    });
  }

  @override
  void dispose() {
    //-- disposing all the controllers
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          //-- backgroundd
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple.shade900, Palette.blackColor],
              ),
            ),
          ),

          Consumer(
            builder: (context, ref, child) {
              return usersState.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.whiteColor),
                  ),
                ),
                error: (error, stackTrace) {
                  String title = "Something went wrong";
                  String description = "Please try again later.";

                  if (error is ApiException) {
                    switch (error.statusCode) {
                      case 404:
                        title = "Users Not Found";
                        description = "No users match your search criteria.";
                        break;
                      case 401:
                      case 403:
                        title = "Authentication Error";
                        description = "Please check your credentials.";
                        break;
                      case 500:
                        title = "Server Error";
                        description = "Our servers are experiencing issues.";
                        break;
                      case 408:
                      case -1:
                        title = "Request Timeout";
                        description = "The request took too long. Please try again.";
                        break;
                      case 0:
                        title = "No Internet Connection";
                        description = "Please check your internet connection.";
                        break;
                      default:
                        title = "Network Error";
                        description = "Failed to connect to the server.";
                    }
                  } else {
                    title = "Unexpected Error";
                    description = "An unexpected error occurred. Please try again.";
                  }

                  return CustomErrorPage(
                    title: title,
                    description: description,
                    onRetry: _refreshData,
                  );
                },
                data: (users) => RefreshIndicator(
                  onRefresh: _refreshData,
                  backgroundColor: Colors.deepPurple,
                  color: Palette.whiteColor,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      //-- App Bar and search field
                      SliverAppBar(
                        expandedHeight: 100,
                        collapsedHeight: 100,
                        floating: true,
                        pinned: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        actionsPadding: EdgeInsets.all(15),
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.only(right: 15),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              cursorColor: Palette.whiteColor,
                              style: TextStyle(color: Palette.whiteColor),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (_searchController.text.isNotEmpty) {
                                      _searchController.clear();
                                      ref
                                          .watch(homeControllerProvider.notifier)
                                          .fetchUsers(search: _searchController.text);
                                    }
                                  },
                                  child: Icon(Icons.close),
                                ),
                                labelText: 'Search User by name',
                                labelStyle: TextStyle(color: Colors.grey.shade300),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepPurple.shade800.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Users List
                      if (users.isEmpty)
                        SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'No users found',
                              style: TextStyle(
                                color: Palette.whiteColor.withOpacity(0.7),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                      //-- sliverpadding and user card
                      if (users.isNotEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              final user = users[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: UserCard(user: user),
                              );
                            }, childCount: users.length),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Content based on state
        ],
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
