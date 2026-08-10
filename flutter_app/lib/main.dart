import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const NeoLifeApp());

class NeoLifeApp extends StatelessWidget {
  const NeoLifeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoLife',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String total = "Chargement...";

  @override
  void initState() {
    super.initState();
    fetchTotal();
  }

  Future<void> fetchTotal() async {
    final res = await http.get(Uri.parse("http://localhost:5000/depenses"));
    final data = jsonDecode(res.body);
    setState(() => total = "${data['total']} Ar");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NeoLife")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Total des dépenses :"),
            Text(total, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
