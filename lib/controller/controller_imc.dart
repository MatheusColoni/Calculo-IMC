import 'package:flutter/material.dart';




class ImcController {

final pesoController = TextEditingController();
final alturaController  = TextEditingController();

ValueNotifier<bool> botaoProcessar= ValueNotifier(false);

//* verificar com o tiago amanhãImcController(

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

}