import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../controller/DB.dart';

class DataBaseInfos extends StatefulWidget {
  const DataBaseInfos({super.key});

  @override
  State<DataBaseInfos> createState() => _DataBaseInfosState();
}

class _DataBaseInfosState extends State<DataBaseInfos> {
  List<Map<String, dynamic>> _contatos = [];

  @override
  void initState() {
    super.initState();
    _listar();
  }

  Future<void> _listar() async {
    final contatos = await obterContatos();
    setState(() {
      _contatos = contatos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        actions: [
          IconButton(
            onPressed: () async {
              await apagarBanco();
              setState(() {
                _contatos = [];
              });
            },
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _contatos.length,
          itemBuilder: (context, index) {
            final contato = _contatos[index];
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1.5),
              ),
              child: ListTile(
                leading: Text(
                  contato['id'].toString(),
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
                title: Text(contato['login']),
                subtitle: Text(contato['senha']),
              ),
            );
          },
        ),
      ),
    );
  }
}
