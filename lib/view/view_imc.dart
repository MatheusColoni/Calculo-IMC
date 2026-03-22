import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 0, 0),
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
        //*inputFormatters: [
       //*   FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
      //*  ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          //* isDense deixa o campo mais compacto, reduzindo a altura do TextField
          isDense: true,
          //* filled deixa o fundo mais cinza, e o border deixa a borda arredondada
          filled: true,
         //* contentPadding é o espaçamento interno do TextField
         contentPadding: EdgeInsets.all(8) ,
        
          label: Text('Peso', style: TextStyle(color: Colors.red )),
         
          suffixIcon: Icon(Icons.height),
          prefix: Text( "P - "),
          hintText: 'Digite seu peso',
          hintStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
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
       //* inputFormatters: [
        //*  FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
       //* ],

      keyboardType: TextInputType.numberWithOptions(decimal:true),
        decoration: InputDecoration(
          //* isDense deixa o campo mais compacto, reduzindo a altura do TextField
          isDense: true,
          //* filled deixa o fundo mais cinza, e o border deixa a borda arredondada
          filled: true,
         //* contentPadding é o espaçamento interno do TextField
         contentPadding: EdgeInsets.all(8) ,
        
          label: Text('Altura', style: TextStyle(color: Colors.red )),
         
          suffixIcon: Icon(Icons.height),
          prefix: Text( "A - "),
          hintText: 'Digite sua altura',
          hintStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
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
      child: ElevatedButton(onPressed:  (){
        debugPrint('IMC ...');
      },
       child:  const Text('Processar IMC',
        style: TextStyle(
        color: Color.fromARGB(255, 255, 0, 0)
          ),
          )
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