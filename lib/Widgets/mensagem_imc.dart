import 'package:flutter/material.dart';
import 'package:projeto_ebac_imc/model/model_imc.dart';

class MensagemIMC extends StatelessWidget {
  const MensagemIMC({
    super.key,
    required this.imcModel,
  });

  final ImcModel imcModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
         const Text('Nivel IMC',
           style: TextStyle(
            fontSize: 20, 
            color: Colors.blue
            )
            ),
      
      
        const  SizedBox(
          height: 8
         ),
      
      
          Text(
            imcModel.mensagem,
             style:
              TextStyle(
                fontSize:20, 
                color: Colors.blue)
      
      
      
                
          ),
        ],
      ),
    );
  }
}
