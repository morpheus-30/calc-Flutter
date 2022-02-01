import 'dart:math';

class CalculatorFunctions{
  int fno;
  int sno;
  CalculatorFunctions({this.fno=0,this.sno=0});
  int add(){
    return fno+sno;
  }
  int sub(){
    return fno-sno;
  }
  int multiply(){
    return fno*sno;
  }
  double divide(){
    return fno.toDouble()/sno.toDouble();
  }
  num exp(){
    return pow(fno,sno);
  }
}