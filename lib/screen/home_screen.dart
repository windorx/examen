/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/ejemplo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final listado = Provider.of<EjemplosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: ListView.separated(
        itemCount: listado.ListadoProductos.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.inventory),
          title: Text(listado.ListadoProductos[index].productName),
        ),
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
*/