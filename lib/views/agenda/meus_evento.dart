import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MeusEvento extends StatefulWidget {
  const MeusEvento({Key? key}) : super(key: key);

  @override
  State<MeusEvento> createState() => _MeusEventoState();
}

class _MeusEventoState extends State<MeusEvento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda IATec", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent, //Colors.grey[100],
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: false
        ),
      ),
    );
  }
}
