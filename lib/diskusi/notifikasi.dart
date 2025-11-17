import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildNotificationItem(
            title: "New Reward Available",
            message: "You've earned 100 points for recycling plastic bottles",
            time: "10 mins ago",
            isRead: false,
          ),
          _buildNotificationItem(
            title: "Weekly Recycling Report",
            message: "You recycled 5kg of waste this week",
            time: "2 hours ago",
            isRead: true,
          ),
          // Add more notification items as needed
        ],
      ),
       bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required bool isRead,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: isRead ? Colors.white : const Color(0xFFE8F5E9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF216BC2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        message,
                        style: TextStyle(
                          color: const Color(0xFF7A757D),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(
                color: const Color(0xFF7A757D),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

}