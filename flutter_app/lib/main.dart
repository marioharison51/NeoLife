import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const NeoLifeApp());

// 🛒 Liste de courses intelligente
class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});
  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List<dynamic> produits = [];
  final controller = TextEditingController();
  static const String baseUrl = "http://127.0.0.1:5000";

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    final res = await http.get(Uri.parse("$baseUrl/courses"));
    setState(() => produits = jsonDecode(res.body));
  }

  Future<void> ajouter() async {
    if (controller.text.isEmpty) return;
    await http.post(
      Uri.parse("$baseUrl/courses"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"produit": controller.text}),
    );
    controller.clear();
    fetchCourses();
  }

  Future<void> supprimer(int index) async {
    await http.delete(Uri.parse("$baseUrl/courses/$index"));
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste de courses')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: "Nouveau produit"),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: ajouter),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: produits.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(produits[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => supprimer(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ❤️ Suivi de santé
class HealthPage extends StatefulWidget {
  const HealthPage({super.key});
  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  List<dynamic> entrees = [];
  final controller = TextEditingController();
  static const String baseUrl = "http://127.0.0.1:5000";

  @override
  void initState() {
    super.initState();
    fetchSante();
  }

  Future<void> fetchSante() async {
    final res = await http.get(Uri.parse("$baseUrl/sante"));
    setState(() => entrees = jsonDecode(res.body));
  }

  Future<void> ajouter() async {
    if (controller.text.isEmpty) return;
    await http.post(
      Uri.parse("$baseUrl/sante"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"description": controller.text}),
    );
    controller.clear();
    fetchSante();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suivi de santé')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: "Activité ou repas"),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: ajouter),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entrees.length,
              itemBuilder: (context, index) => ListTile(title: Text(entrees[index])),
            ),
          ),
        ],
      ),
    );
  }
}

// 📅 Agenda personnel
class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});
  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  List<dynamic> rdvList = [];
  final dateController = TextEditingController();
  final descController = TextEditingController();
  static const String baseUrl = "http://127.0.0.1:5000";

  @override
  void initState() {
    super.initState();
    fetchAgenda();
  }

  Future<void> fetchAgenda() async {
    final res = await http.get(Uri.parse("$baseUrl/agenda"));
    setState(() => rdvList = jsonDecode(res.body));
  }

  Future<void> ajouter() async {
    if (dateController.text.isEmpty || descController.text.isEmpty) return;
    await http.post(
      Uri.parse("$baseUrl/agenda"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"date": dateController.text, "description": descController.text}),
    );
    dateController.clear();
    descController.clear();
    fetchAgenda();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda personnel')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Date (jj/mm/aaaa)"),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                ElevatedButton(onPressed: ajouter, child: const Text("Ajouter")),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rdvList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(rdvList[index]["description"]),
                subtitle: Text(rdvList[index]["date"]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 📝 Carnet de notes rapide
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<dynamic> notesList = [];
  final contenuController = TextEditingController();
  final tagController = TextEditingController();
  static const String baseUrl = "http://127.0.0.1:5000";

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final res = await http.get(Uri.parse("$baseUrl/notes"));
    setState(() => notesList = jsonDecode(res.body));
  }

  Future<void> ajouter() async {
    if (contenuController.text.isEmpty) return;
    await http.post(
      Uri.parse("$baseUrl/notes"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"contenu": contenuController.text, "tag": tagController.text}),
    );
    contenuController.clear();
    tagController.clear();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carnet de notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: contenuController,
                  decoration: const InputDecoration(labelText: "Note"),
                ),
                TextField(
                  controller: tagController,
                  decoration: const InputDecoration(labelText: "Tag"),
                ),
                ElevatedButton(onPressed: ajouter, child: const Text("Ajouter")),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(notesList[index]["contenu"]),
                subtitle: Text(notesList[index]["tag"]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
