import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginAppScreen(),
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}

class LoginAppScreen extends StatelessWidget {
  const LoginAppScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: LoginAppForm(),
          ),
        ),
      ),
    );
  }
}

class LoginAppForm extends StatefulWidget {
  const LoginAppForm();

  @override
  _LoginAppFormState createState() => _LoginAppFormState();
}

class _LoginAppFormState extends State<LoginAppForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        //LinearProgressIndicator(value: _formProgress),
        AnimatedProgressIndicator(value: _formProgress),
        Text('Log in', style: Theme.of(context).textTheme.headline4),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(hintText: 'username'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'password'),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? null
                  : Colors.white;
            }),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? null
                  : Colors.cyan[800];
            }),
          ),
          onPressed: _formProgress == 1 ? _showWelcomeScreen : null,
          child: const Text('Log in'),
        ),
      ]),
    );
  }

//il seguente metodo serve per tenere traccia dello stato dell'utente nell'inserimento dei dati nel form
//se l'utente non compila i campi, il bottone non è attivo
  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [_usernameController, _passwordController];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

//collegato a onPressed del bottone
  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }
}

//classe per schermata di benvenuto
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Benvenuto!', style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}

//class per animazione
class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnim;
  late Animation<double> _curveAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnim = _controller.drive(colorTween);
    _curveAnim = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => LinearProgressIndicator(
              value: _curveAnim.value,
              valueColor: _colorAnim,
              backgroundColor: _colorAnim.value?.withOpacity(0.4),
            ));
  }
}
