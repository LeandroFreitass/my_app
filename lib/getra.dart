import 'package:flutter/material.dart';
import 'dados.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String URL = "https://www.slmm.com.br/CTC/ctcApi.php";

Future<List<Dados>> fetchData() async {
  var response =
      await http.get(Uri.parse(URL), headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Dados.fromJson(data)).toList();
  } else {
    throw Exception('Erro inesperado...');
  }
}

class getRa extends StatefulWidget {
  const getRa({Key? key}) : super(key: key);

  @override
  _getRaState createState() => _getRaState();
}

class _getRaState extends State<getRa> {
  late Future<List<Dados>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("lista RA")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<Dados>>(
          future: futureData,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Dados> data = snapshot.data!;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(data[index].ra),
                        subtitle: Text(data[index].data),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
