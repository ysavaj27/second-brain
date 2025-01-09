import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  Future<void> setData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      context.replace('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
