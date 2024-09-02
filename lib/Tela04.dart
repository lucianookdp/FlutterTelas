import 'package:flutter/material.dart';
import 'Tela05.dart';
import 'package:intl/intl.dart'; // Importa para formatação de números

class Tela04 extends StatefulWidget {
  @override
  _Tela04State createState() => _Tela04State();
}

class _Tela04State extends State<Tela04> {
  final TextEditingController _realController = TextEditingController();
  final TextEditingController _dolarController = TextEditingController();
  double _exchangeRate = 5.63; // Taxa de câmbio fixa: 1 USD = 5.63 BRL
  bool _isRealToDollar = true; // Controla a direção da conversão

  void _convertCurrency() {
    if (_isRealToDollar) {
      _convertRealToDollar();
    } else {
      _convertDollarToReal();
    }
  }

  void _convertRealToDollar() {
    if (_realController.text.isNotEmpty) {
      double realValue = double.parse(_realController.text);
      double dollarValue = realValue / _exchangeRate;
      _dolarController.text = NumberFormat.currency(locale: 'en_US', symbol: '')
          .format(dollarValue);
    }
  }

  void _convertDollarToReal() {
    if (_dolarController.text.isNotEmpty) {
      double dollarValue = double.parse(_dolarController.text);
      double realValue = dollarValue * _exchangeRate;
      _realController.text = NumberFormat.currency(locale: 'pt_BR', symbol: '')
          .format(realValue);
    }
  }

  void _invertConversion() {
    setState(() {
      _isRealToDollar = !_isRealToDollar;
      _realController.clear();
      _dolarController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moedas'),
      ),
      resizeToAvoidBottomInset: true, // Permite redimensionar para evitar o teclado
      body: SingleChildScrollView( // Permite rolar quando o teclado está aberto
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.attach_money, // Ícone de moedas
              size: 50,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _realController,
              decoration: InputDecoration(
                labelText: _isRealToDollar ? 'Valor em Reais (BRL)' : 'Valor em Dólares (USD)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              enabled: _isRealToDollar, // Habilita somente quando a conversão é de real para dólar
            ),
            SizedBox(height: 20),
            TextField(
              controller: _dolarController,
              decoration: InputDecoration(
                labelText: _isRealToDollar ? 'Valor em Dólares (USD)' : 'Valor em Reais (BRL)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              enabled: !_isRealToDollar, // Habilita somente quando a conversão é de dólar para real
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _invertConversion,
                  child: Text('Inverter Conversão'),
                ),
                ElevatedButton(
                  onPressed: _convertCurrency,
                  child: Text('Converter Moeda'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tela05()),
                );
              },
              child: Text('Ir para a Quinta Tela'),
            ),
          ],
        ),
      ),
    );
  }
}
