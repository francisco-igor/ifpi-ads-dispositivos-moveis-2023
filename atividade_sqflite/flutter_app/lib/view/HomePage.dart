import 'package:flutter/material.dart';
import 'package:flutter_app/view/DataBaseInfos.dart';
import '../controller/DB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(left: 50, top: 0, right: 50, bottom: 50),
            child: Column(
              children: [
                Image.network(
                  'https://imagensemoldes.com.br/wp-content/uploads/2020/10/Imagem-Bank-PNG.png',
                  width: 200,
                ),
                const SizedBox(height: 60),
                TextField(
                  controller: _loginController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        final login = _loginController.text;
                        final senha = _senhaController.text;
                        final db = await openBanco();
                        
                        await db.insert(
                            'contatos', {'login': login, 'senha': senha});

                        _loginController.clear();
                        _senhaController.clear();
                      },
                      child: const Text(
                        'Cadastrar',
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.dataset),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DataBaseInfos(),
            ),
          );
        },
      ),
    );
  }
}
