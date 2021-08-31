import 'package:flutter/material.dart';
import 'package:stunning_tribble/config/config_reader.dart';
import 'package:stunning_tribble/config/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initializeApp(Environment.dev);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
