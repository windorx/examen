/*import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/example_product_list_rest.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EjemplosProvider extends ChangeNotifier {
  String APIUSER = 'test';
  String APIPASS = 'test2023';
  String BASEURL = '143.198.118.203:8100';
  List<Listado> ListadoProductos = [];
  //Contructor
  EjemplosProvider() {
    getListEjemplos();
  }
  //crearemos los métodos para consumir los endPoint
  getListEjemplos() async {
    var url = Uri.http(
      BASEURL,
      'ejemplos/product_list_rest/',
    );
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$APIUSER:$APIPASS'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    //print(response.body);
    //creearemos un mapa
    final Map<String, dynamic> dataDecode = json.decode(response.body);
    //print(dataDecode['Listado']);
    final example_product_list_rest =
        ExampleProductListRest.fromJson(dataDecode);
    ListadoProductos = example_product_list_rest.listado;
    notifyListeners(); //notifica a los widgets cuando hay un cambio en la data
  }
}
*/