
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himanish/home_sereen.dart';

class screen2 extends StatelessWidget {
  screen2({super.key});
  final TextEditingController _cityContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Flutter WorkShop")),
        body: Column(
          children: [
            TextField(
              controller: _cityContoller,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                // );
                Get.to(() => HomeScreen(
                      cityName: _cityContoller.text,
                    ));
              },
              child: const Text('Check the weather'),
            )
          ],
        ));
  }
}