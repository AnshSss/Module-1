import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Calculator()
));
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation='0';
  String result='0';
  String expression='';
  double eqnfontsize=100;
  double resultfontsize=70;


  buttonPressed(String btntext){
    setState(() {
      if(btntext=='AC'){
        equation='0';
        result='0';
        eqnfontsize=100;
        resultfontsize=70;

      }else if(btntext=='⌫'){
        eqnfontsize=100;
        resultfontsize=70;

        equation=equation.substring(0,equation.length-1);
        if(equation==''){
          equation='0';
        }

      }else if(btntext=='='){
        eqnfontsize=100;
        resultfontsize=70;
        expression=equation;
        expression=expression.replaceAll('x','*');
        expression=expression.replaceAll('÷', '/');
        try{
          Parser p= new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm=ContextModel();
          result= '${exp.evaluate(EvaluationType.REAL, cm)}';

        }catch(e){
          result="Error";
        }

      }else{
        eqnfontsize=100;
        resultfontsize=70;
        if(equation=='0'){
          equation=btntext;
        }else {
          equation = equation + btntext;
        }
      }
    });
  }


  Widget Calcbutton(String btntext, Color btncolor, Color txtcolor){
    return Container(
      child: ElevatedButton(
        onPressed: ()=> buttonPressed(btntext),
        child: 
          Text(btntext,
          style: TextStyle(color : txtcolor,
            fontSize: 32,
          ),
          ),
        style: ElevatedButton.styleFrom(backgroundColor: btncolor, shape: CircleBorder(),padding: EdgeInsets.all(10))
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.all(10.0),
              child: Text(equation,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white,fontSize: eqnfontsize),)
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Text(result,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,fontSize: resultfontsize),)
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Calcbutton('AC', Colors.amber, Colors.black),
              Calcbutton('⌫', Colors.grey, Colors.amber),
              Calcbutton('.', Colors.grey, Colors.amber),
              Calcbutton('÷', Colors.grey, Colors.amber),

            ],
          ),
          SizedBox(width: 0.0,height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Calcbutton('7', Colors.grey, Colors.black),
              Calcbutton('8', Colors.grey, Colors.black),
              Calcbutton('9', Colors.grey, Colors.black),
              Calcbutton('x', Colors.grey, Colors.amber),

            ],
          ),
          SizedBox(width: 0.0,height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Calcbutton('4', Colors.grey, Colors.black),
              Calcbutton('5', Colors.grey, Colors.black),
              Calcbutton('6', Colors.grey, Colors.black),
              Calcbutton('-', Colors.grey, Colors.amber),

            ],
          ),
          SizedBox(width: 0.0,height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Calcbutton('1', Colors.grey, Colors.black),
              Calcbutton('2', Colors.grey, Colors.black),
              Calcbutton('3', Colors.grey, Colors.black),
              Calcbutton('+', Colors.grey, Colors.amber),

            ],
          ),
          SizedBox(width: 0.0,height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Calcbutton('', Colors.grey, Colors.white),
              Calcbutton('0', Colors.grey, Colors.black),
              Calcbutton('00', Colors.grey, Colors.black),
              Calcbutton('=', Colors.grey, Colors.amber),

            ],
          ),
        ],

      )
    );
  }
}
