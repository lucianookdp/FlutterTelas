import 'package:flutter/material.dart';
import 'Tela02.dart';
import 'Tela03.dart';
import 'Tela04.dart';
import 'Tela05.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  bool _isCrazyTheme = false;
  late AnimationController _controller;
  late Color _backgroundColor;
  late Color _textColor;
  late Color _iconColor;
  late double _fontSize;
  late FontStyle _fontStyle;
  IconData _currentIcon = Icons.sentiment_very_satisfied; // Ícone inicial

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        if (_isCrazyTheme) {
          setState(() {
            _backgroundColor = _randomColor();
            _textColor = _randomColor();
            _iconColor = _randomColor();
            _fontSize = _randomFontSize();
            _fontStyle = _randomFontStyle();
            _currentIcon = _randomIcon();
          });
        }
      });

    _backgroundColor = Colors.black;
    _textColor = Colors.white;
    _iconColor = Colors.red;
    _fontSize = 24.0;
    _fontStyle = FontStyle.normal;
  }

  Color _randomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  double _randomFontSize() {
    final random = Random();
    return 20 + random.nextInt(16).toDouble(); // Tamanhos entre 20 e 36
  }

  FontStyle _randomFontStyle() {
    return Random().nextBool() ? FontStyle.italic : FontStyle.normal;
  }

  IconData _randomIcon() {
    return Random().nextBool()
        ? Icons.sentiment_very_satisfied // Ícone de risadinha
        : Icons.emoji_emotions; // Ícone de palhaço
  }

  void _toggleCrazyTheme() {
    setState(() {
      _isCrazyTheme = !_isCrazyTheme;
      if (_isCrazyTheme) {
        _controller.repeat(); // Começa a animação
      } else {
        _controller.stop(); // Para a animação
        _resetTheme(); // Reseta o tema para o padrão
      }
    });
  }

  void _resetTheme() {
    setState(() {
      _backgroundColor = Colors.black;
      _textColor = Colors.white;
      _iconColor = Colors.red;
      _fontSize = 24.0;
      _fontStyle = FontStyle.normal;
      _currentIcon = Icons.sentiment_very_satisfied; // Reseta para ícone inicial
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controlador ao sair
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(
        onChangeTheme: _toggleCrazyTheme,
        isCrazyTheme: _isCrazyTheme,
        backgroundColor: _backgroundColor,
        textColor: _textColor,
        iconColor: _iconColor,
        fontSize: _fontSize,
        fontStyle: _fontStyle,
        currentIcon: _currentIcon,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final VoidCallback onChangeTheme;
  final bool isCrazyTheme;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double fontSize;
  final FontStyle fontStyle;
  final IconData currentIcon;

  const MyHomePage({
    Key? key,
    required this.onChangeTheme,
    required this.isCrazyTheme,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.fontSize,
    required this.fontStyle,
    required this.currentIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Principal'),
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(), // Mantém o espaço no topo fixo
            Icon(
              currentIcon, // Ícone alternado
              color: iconColor,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              isCrazyTheme
                  ? 'Tema Maluco Ativado! Clique para voltar ao normal!'
                  : 'Pressione o botão para ativar o tema maluco!',
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontStyle: fontStyle,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(), // Mantém os botões fixos na parte inferior
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: onChangeTheme,
                    child: Text('Alternar Tema'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tela02()),
                      );
                    },
                    child: Text('Ir para a Segunda Tela'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
