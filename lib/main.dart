import 'package:flutter/material.dart';
import 'models/operadora.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta Empresa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OperadoraSearchPage(),
    );
  }
}

class OperadoraSearchPage extends StatefulWidget {
  @override
  _OperadoraSearchPageState createState() => _OperadoraSearchPageState();
}

class _OperadoraSearchPageState extends State<OperadoraSearchPage> {
  final TextEditingController _controller = TextEditingController();
  late Future<Operadora?> futureOperadora;

  @override
  void initState() {
    super.initState();
    futureOperadora = Future.value(null);
  }

  void _searchOperadora() {
    setState(() {
      futureOperadora = ApiService().fetchOperadoraBySigla(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
         child: Text( 'Consulta Empresa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
     ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: 300, // Largura desejada para a caixa de pesquisa
              height: 50.0,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Sigla da Operadora',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: 150, // Largura desejada para o botão
              height: 50.0,
              child: ElevatedButton(
                onPressed: _searchOperadora,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo), // Cor azul escuro
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cor do texto branco
                ),
                child: Text(
                  'Pesquisar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<Operadora?>(
                future: futureOperadora,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final operadora = snapshot.data!;
                    return Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.count(
                            shrinkWrap: true, // Para não ocupar todo o espaço
                            physics: NeverScrollableScrollPhysics(), // Desativa a rolagem do GridView
                            crossAxisCount: 3, // Número de colunas
                            childAspectRatio: 3.5, // Proporção dos filhos
                            crossAxisSpacing: 15.0, // Espaçamento entre colunas
                            mainAxisSpacing: 15.0, // Espaçamento entre linhas
                            children: [
                              _buildFormField('Sigla', operadora.sg_operadora),
                              _buildFormField('Nome Operadora', operadora.nm_operadora),
                              _buildFormField('CPF/CNPJ', operadora.cpf_cnpj),
                              _buildFormField('Razão Social', operadora.razao_social),
                              _buildFormField('Representante Legal', operadora.nm_rep_legal),
                              _buildFormField('UF', operadora.uf),
                              _buildFormField('Logradouro', operadora.tx_logradouro),
                              _buildFormField('Localidade', operadora.tx_localidade),
                              _buildFormField('CEP', operadora.nr_cep.toString()), // Convertendo int para String
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    return Center(child: Text('Nenhuma operadora encontrada.'));
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
