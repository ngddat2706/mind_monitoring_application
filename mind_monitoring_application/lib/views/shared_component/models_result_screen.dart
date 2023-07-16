import 'package:flutter/material.dart';

class ModelsResultScreen extends StatefulWidget {
  const ModelsResultScreen({Key? key}) : super(key: key);

  @override
  State<ModelsResultScreen> createState() => _ModelsResultScreenState();
}

class _ModelsResultScreenState extends State<ModelsResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
      ),
    );
  }
}