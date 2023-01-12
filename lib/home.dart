import 'package:flutter/material.dart';
import 'package:nutribase/homepage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const Scaffold(
        body: SafeArea(child: Homepage()),
      ),
    );
  }
}
