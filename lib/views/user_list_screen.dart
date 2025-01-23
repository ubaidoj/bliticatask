import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/user_view_model.dart';
import 'widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dating List"),
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Column(
        children: [

          Container(
            color: Colors.purple,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !userViewModel.isLoading) {
                  userViewModel.fetchUsers(isLoadMore: true);
                }
                return true;
              },
              child: ListView.builder(
                itemCount: userViewModel.users.length +
                    (userViewModel.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < userViewModel.users.length) {
                    return UserCard(user: userViewModel.users[index]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}

