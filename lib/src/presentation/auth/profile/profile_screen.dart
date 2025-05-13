import 'package:farm_project/src/presentation/auth/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:farm_project/core/cubits/auth/auth_cubit.dart';
import 'package:farm_project/core/utils/snackbar_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit();
    final user = authCubit.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: user == null
          ? const Center(child: Text("لا يوجد مستخدم"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _infoRow("رقم الهاتف:", user.phone),
                  const Divider(),
                  _infoRow("نوع الحساب:", user.role == 'admin' ? 'مسؤول' : 'مستخدم'),
                  const Divider(),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () async {
                        await authCubit.logout();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const SignInScreen()),
                            (route) => false,
                          );
                          SnackBarHelper.showMySnackbar(context, 'تم تسجيل الخروج بنجاح');
                        }
                      },
                      child: const Text('تسجيل الخروج'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10),
         Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
       
      ],
    );
  }
}
