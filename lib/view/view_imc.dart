import 'package:flutter/material.dart';
import  'package:projeto_ebac_imc/controller/controller_imc.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {

ImcController imcController = ImcController();


@override
void dispose() {
  imcController.pesoController.dispose();
  imcController.alturaController.dispose();
  super.dispose();
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('IMC'),
         ),


body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
   children: [
    
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children:  [
      Expanded(
       child:  TextField(
        controller: imcController.pesoController,
       //* inputFormatters: [
      //*   FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
      //*  ],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          //* isDense deixa o campo mais compacto, reduzindo a altura do TextField
          isDense: true,
          //* filled deixa o fundo mais cinza, e o border deixa a borda arredondada
          filled: true,
         //* contentPadding é o espaçamento interno do TextField
         contentPadding: EdgeInsets.all(8) ,
        
          label: Text('Peso', style: TextStyle(color: Colors.amber)),
         
          suffixIcon: Icon(Icons.height),
          prefix: Text( "P - "),
          hintText: 'Digite seu peso',
          hintStyle: TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30)
              
         ),
         ), 
         ),
),
),
     ],
    ),
   
//* SizedBox ele cria um espaço entre o textfield e o botão, para deixar a interface mais agradável

const SizedBox(
  height: 20,
),
 
 
 Expanded(
       child: TextField(
        controller: imcController.alturaController,

     //*   inputFormatters: [
   //*    FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
     //*   ],

      keyboardType: TextInputType.numberWithOptions(decimal:true),
        decoration: InputDecoration(
          //* isDense deixa o campo mais compacto, reduzindo a altura do TextField
          isDense: true,
          //* filled deixa o fundo mais cinza, e o border deixa a borda arredondada
          filled: true,
         //* contentPadding é o espaçamento interno do TextField
         contentPadding: EdgeInsets.all(8) ,
        
          label: Text('Altura', style: TextStyle(color: Colors.amber )),
         
          suffixIcon: Icon(Icons.height),
          prefix: Text( "A - "),
          hintText: 'Digite sua altura',
          hintStyle: TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30)
              
         ),
         ), 
         ),
),
),


const SizedBox(
height: 5,
),

Row(
  children: [
    Expanded(child:
    Padding(
      padding: const EdgeInsets.symmetric(vertical : 16.0),
      child: ValueListenableBuilder<bool>(
        valueListenable: imcController.botaoProcessar,
        builder:(context, value, _) {
        return ElevatedButton(
          onPressed: 
          !value 
          ? null : (){
        showDialog(context:context,
        //* barrierDismissible: false, para não fechar o dialog quando clicar fora dele, obrigando o usuário a clicar no botão para fechar o dialog
        barrierDismissible: false,
         builder: (context){
        
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))
          ),
         
        titlePadding: const EdgeInsets.symmetric(horizontal: 0),
        titleTextStyle: const TextStyle( color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        title: Container (
        height: 60,
        decoration:  const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            
        ),
         child:const Center(child:
          Text('Resultado IMC')),
        ),
          content: Column (
           mainAxisAlignment: MainAxisAlignment.center,
           mainAxisSize: MainAxisSize.min, 
            children: [
        Text('Peso:  ${imcController.pesoController.text} '),
        Text('Altura: ${imcController.alturaController.text} '),
          ]
          ),
        
        actions: [
          TextButton(
            onPressed: () {
            Navigator.of(context).pop('Fechando a tela');
            FocusManager.instance.primaryFocus
         ?.unfocus(); 
          },
         
          child:const Icon(Icons.close)),
        ],
        
        
        
        
        );
        });
         
        },
         child:  const Text('Processar IMC',
          style: TextStyle(
          color: Colors.amber
            ),
            )
            );
        },
         
      ),
    )
        ),
  ],
),



],
),
),
); 
  
  
  
  }
}