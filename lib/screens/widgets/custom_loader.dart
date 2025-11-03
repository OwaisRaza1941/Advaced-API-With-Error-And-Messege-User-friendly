import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingAnimationWidget.flickr(
        leftDotColor: Colors.purple,
        rightDotColor: Colors.yellow,
        size: 50,
      ),
    );
  }
}
