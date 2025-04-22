import 'package:farm_project/core/utils/custom_extension_and_checkers.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> list = ['25 فدان مجدول', '25 فدان مجدول', '25 فدان مجدول'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ألرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الصفحة الشخصية',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        leading: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: sizedH(context) * 0.12),
        itemCount: 4,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.9,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'قطاع ${i + 1} ',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text('32 x 31', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
