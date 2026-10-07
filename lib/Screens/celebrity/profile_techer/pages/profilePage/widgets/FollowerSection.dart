import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_follower_items.dart';
import 'package:flutter/material.dart';

class FollowerSection extends StatelessWidget {
  const FollowerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          ProfileSection3Items(title: "109", subTitle: "منشور"),
          ProfileSection3Items(title: "5", subTitle: "فيديوهات"),
          ProfileSection3Items(title: "3", subTitle: "مجلات"),
        ],
      ),
    );
  }
}
