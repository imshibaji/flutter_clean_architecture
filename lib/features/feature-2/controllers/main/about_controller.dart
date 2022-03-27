import 'package:clean_archetructure/features/main_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class AboutController extends StatelessWidget {
  const AboutController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2 about'),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
