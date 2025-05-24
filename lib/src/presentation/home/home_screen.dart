import 'package:farm_project/core/cubits/app/app_config_cubit.dart';
import 'package:farm_project/core/cubits/app/app_config_states.dart';
import 'package:farm_project/core/cubits/sector/sector_cubit.dart';
import 'package:farm_project/core/services/dummy_data_uploader_service.dart';
import 'package:farm_project/core/utils/router.dart';
import 'package:farm_project/src/presentation/admin/general_calculation_screen.dart';
import 'package:farm_project/src/presentation/auth/profile/profile_screen.dart';
import 'package:farm_project/src/presentation/farm/farm_screen.dart';
import 'package:farm_project/src/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    DummyDataUploaderService().uploadDummyData();
    super.initState();
    screens = [FarmScreen(), ProfileScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SectorCubit(),
      child: Builder(
        builder: (ctx) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("الصفحة الرئيسية"),
              centerTitle: true,
              leading: const SizedBox.shrink(), // removes back button
              actions: [
                IconButton(onPressed: (){
                  push(context, GeneralCalculationScreen());
                }, icon: Icon(Icons.settings))
              ],
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: screenIndex,
              onTap: (index) {
                setState(() {
                  screenIndex = index;
                });
              },
            ),
            body: BlocBuilder<AppConfigCubit,AppConfigStates>(
              builder: (context,state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: screens[screenIndex],
                );
              }
            ),
          );
        },
      ),
    );
  }
}
