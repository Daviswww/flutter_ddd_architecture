import 'package:flutter/material.dart';
import 'package:stunning_tribble/presentation/screens/home/components/switch_mode_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        actions: [
          SwtichModeButton(),
        ],
      ),
      body: Center(
        child: Text(
          "Hello",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
