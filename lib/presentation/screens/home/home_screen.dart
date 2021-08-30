import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/theme/theme_bloc.dart';
import 'package:stunning_tribble/presentation/screens/home/components/switch_mode_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitched = false;

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
