// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'calc.dart';

void main() {
  runApp(Calculator());
}

String choosenOperation = '+';
String result = '0.0';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int a = 0;

  int b = 0;

  void choosenOperationfunc() {
    if (choosenOperation == '+') {
      result = CalculatorFunctions(fno: a, sno: b).add().toString();
    } else if (choosenOperation == '-') {
      result = CalculatorFunctions(fno: a, sno: b).sub().toString();
    } else if (choosenOperation == '*') {
      result = CalculatorFunctions(fno: a, sno: b).multiply().toString();
    } else if (choosenOperation == '/') {
      result = double.parse(
              CalculatorFunctions(fno: a, sno: b).divide().toStringAsFixed(2))
          .toString();
    } else if (choosenOperation == '**') {
      num ans = CalculatorFunctions(fno: a, sno: b).exp();
      if (ans>999999999 || ans<-999999999) {
        result = 'Too Large To Display';
      } else {
        result = ans.toStringAsFixed(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(color: Color(0xFF0D0021)),
          scaffoldBackgroundColor: Color(0xFF0D0021)),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.calculate),
          title: Text(
            'Calc',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: NumTextField(
                        onchanged: (value) {
                          a = int.parse(value);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: OperationMenu(
                        choosenOPfunc: choosenOperationfunc,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: NumTextField(
                        onchanged: (value) {
                          b = int.parse(value);
                        },
                      ),
                      flex: 2,
                    )
                  ],
                ),
                EqualButton(
                  onpressed: () {
                    setState(() {
                      choosenOperationfunc();
                    });
                  },
                ),
                Text(
                  
                  result,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EqualButton extends StatefulWidget {
  Function onpressed;
  EqualButton({required this.onpressed});

  @override
  State<EqualButton> createState() => _EqualButtonState();
}

class _EqualButtonState extends State<EqualButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          widget.onpressed();
        });
      },
      child: FaIcon(FontAwesomeIcons.equals),
    );
  }
}

class OperationMenu extends StatefulWidget {
  Function choosenOPfunc;

  OperationMenu({required this.choosenOPfunc});

  @override
  State<OperationMenu> createState() => _OperationMenuState();
}

class _OperationMenuState extends State<OperationMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: choosenOperation,
      dropdownColor: Color(0xFF290C83),
      alignment: Alignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        DropdownMenuItem(
          value: '+',
          child: Icon(Icons.add),
        ),
        DropdownMenuItem(
          value: '-',
          child: FaIcon(FontAwesomeIcons.minus),
        ),
        DropdownMenuItem(
          value: '*',
          child: Icon(Icons.close),
        ),
        DropdownMenuItem(
          value: '/',
          child: FaIcon(FontAwesomeIcons.divide),
        ),
        DropdownMenuItem(
          value: '**',
          child: FaIcon(FontAwesomeIcons.superscript),
        ),
      ],
      onChanged: (value) {
        setState(
          () {
            choosenOperation = value.toString();
            widget.choosenOPfunc();
          },
        );
      },
    );
  }
}

class NumTextField extends StatelessWidget {
  NumTextField({required this.onchanged});
  Function onchanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onchanged(value);
      },
      decoration: InputDecoration(
          filled: true,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF0D0021),
            ),
          ),
          fillColor: Colors.deepPurple[900]),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
