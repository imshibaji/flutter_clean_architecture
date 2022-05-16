import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AboutController extends StatelessWidget {
  const AboutController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2 about'),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
