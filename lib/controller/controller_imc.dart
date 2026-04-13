import 'package:flutter/material.dart';
import 'package:projeto_ebac_imc/model/model_imc.dart';



class ImcController {

final pesoController = TextEditingController();
final alturaController  = TextEditingController();


double resultadoIMC =  0;

ValueNotifier<bool> botaoProcessar= ValueNotifier(false);


ImcController() {
  pesoController.addListener(() {
	_habilitabotao();
  });


alturaController.addListener((){
	_habilitabotao();

});


}

void _habilitabotao() {
  botaoProcessar.value = pesoController.value.text.isNotEmpty && 
  alturaController.value.text.isNotEmpty;
}


 ImcModel processarIMC() { 
resultadoIMC = double.tryParse(_calcularIMC().toStringAsFixed(2)) as double;

if( resultadoIMC == -999){
  return ImcModel(peso: 0, altura: 0, mensagem: '');
}

var mensagemIMC = _obterMensagemIMC(resultadoIMC);

ImcModel imcModel = ImcModel(
  peso: double.parse(pesoController.value.text.replaceAll(',', '.')) , 
  altura: double.parse(alturaController.value.text.replaceAll(',', '.')) , 
  mensagem: mensagemIMC);




return imcModel;

}

double _calcularIMC(){
 // peso / (altura * altura)

try{
double pesoIMC = double.parse(pesoController.value.text.replaceAll(',', '.'));
double alturaIMC = double.parse(alturaController.value.text.replaceAll(',', '.'));
double valorIMC = pesoIMC / (alturaIMC * alturaIMC);
return valorIMC;

} catch (e) {
return -999;
}

}
String _obterMensagemIMC(double valorIMC){
  if (valorIMC < 16){
    return 'baixo peso, muito grave';
  }

if (valorIMC >= 16 && valorIMC < 17){
    return 'baixo peso, grave';
  }

if (valorIMC >= 17 && valorIMC <= 18.5){
  return 'peso baixo';
}

if (valorIMC >= 18.5 && valorIMC <=25){
  return 'peso ideal';
}

if(valorIMC >= 25 && valorIMC < 30){
  return 'sobrepeso';
}

if(valorIMC >= 30 && valorIMC < 35){
  return 'obesidade grau 1';
}

if(valorIMC >= 35 && valorIMC < 40){
  return 'obesidade grau 2';
}

return 'obesidade grau 3 (obesidade mórbida) = maior que 40kg/m2';


}

}