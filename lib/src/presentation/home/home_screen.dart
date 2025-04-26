import 'package:farm_project/src/presentation/auth/profile/profile_screen.dart';
import 'package:farm_project/src/presentation/farm/farm_screen.dart';
import 'package:farm_project/src/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List<Widget> screens = [];
  @override
  void initState() {
    super.initState();
    screens = [
      FarmScreen(),
      ProfileScreen(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        centerTitle: true,
        leading: const SizedBox.shrink(), // removes back button
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: screenIndex, onTap: (index){
        setState(() {
          screenIndex = index;
        });
      }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: screens[screenIndex],
      ),
    );
  }
}
