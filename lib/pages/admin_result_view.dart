import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminResultView extends StatefulWidget {
  const AdminResultView({super.key});

  @override
  State<AdminResultView> createState() => _AdminResultViewState();
}

class _AdminResultViewState extends State<AdminResultView> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allResults = [];
  List<Map<String, dynamic>> filteredResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('examenes')
          .orderBy('fecha', descending: true)
          .get();

      final List<Map<String, dynamic>> loadedResults = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'nombre': data['nombre'] ?? '',
          'dni': data['dni'] ?? '',
          'resultado': data['aprobado'] == true ? 'Aprobado' : 'Desaprobado',
          'correctas': data['correctas'] ?? 0,
          'total': data['total'] ?? 0,
          'fecha': data['fecha']?.toDate(),
        };
      }).toList();

      setState(() {
        allResults = loadedResults;
        filteredResults = loadedResults;
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar resultados: $e');
      setState(() => isLoading = false);
    }
  }

  void _search(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredResults = allResults.where((res) {
        final nombre = res['nombre'].toString().toLowerCase();
        final dni = res['dni'].toString();
        return nombre.contains(lowerQuery) || dni.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados registrados')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: _search,
                    decoration: const InputDecoration(
                      labelText: 'Buscar por nombre o DNI',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: filteredResults.isEmpty
                        ? const Center(child: Text('No hay resultados.'))
                        : ListView.builder(
                            itemCount: filteredResults.length,
                            itemBuilder: (context, index) {
                              final result = filteredResults[index];
                              final fecha = result['fecha'] != null
                                  ? '${result['fecha'].day}/${result['fecha'].month}/${result['fecha'].year}'
                                  : 'Fecha desconocida';

                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.person),
                                  title: Text('${result['nombre']} (${result['dni']})'),
                                  subtitle: Text(
                                    'Resultado: ${result['resultado']}\n'
                                    'Correctas: ${result['correctas']} / ${result['total']} - Fecha: $fecha',
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
