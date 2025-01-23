import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Reduced margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity Header
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.restaurant, color: Colors.purple),
              title:
                  Text("Dinner", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.more_horiz),
            ),
            SizedBox(height: 8),

            // User Info
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePicture),
                radius: 28,
              ),
              title: Text(
                user.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, // Prevent text overflow
              ),
              subtitle: Text(
                "${user.location} - ${user.distance != null && user.distance! > 0 ? '${user.distance!.toStringAsFixed(2)} km' : 'Distance not available'}",
                style: TextStyle(color: Colors.grey[600]),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Wrap(
                spacing: 8,
                children: [
                  Icon(Icons.message, color: Colors.blue),
                  Icon(Icons.phone, color: Colors.green),
                ],
              ),
            ),
            SizedBox(height: 12),

            // Date and Location Info
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Date: Sun, Jul 17 2024",
                    style: TextStyle(color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
                Icon(Icons.location_on, color: Colors.grey, size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    user.location,
                    style: TextStyle(color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
