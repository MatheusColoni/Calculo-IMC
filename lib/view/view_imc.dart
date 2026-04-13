import 'package:flutter/material.dart';
import  'package:projeto_ebac_imc/controller/controller_imc.dart';
import 'package:projeto_ebac_imc/model/model_imc.dart';

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
    title: const Text('IMC', style: TextStyle(color: Colors.blue)),
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
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
    isDense: true,
    filled: true,
    contentPadding: EdgeInsets.all(8) ,
    label: Text('Peso', style: TextStyle(color: Colors.blue)),
    suffixIcon: Icon(Icons.height),
    prefix: Text( "P - "),
    hintText: 'Digite seu peso',
    hintStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
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

  const SizedBox(
  height: 20,
),
 
 
  Expanded(
  child: TextField(
  controller: imcController.alturaController,
  keyboardType: TextInputType.numberWithOptions(decimal:true),
  decoration: InputDecoration(
  isDense: true,
  filled: true,
  contentPadding: EdgeInsets.all(8) ,
  label: Text('Altura', style: TextStyle(color: Colors.blue )),
  suffixIcon: Icon(Icons.height),
  prefix: Text( "A - "),
  hintText: 'Digite sua altura',
  hintStyle: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
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
  builder: (context){
    ImcModel imcModel = imcController.processarIMC( 
    );
        

 return AlertDialog(
 shape: const RoundedRectangleBorder(
 borderRadius: BorderRadius.all(Radius.circular(32))
          ),
         
  titlePadding: const EdgeInsets.symmetric(horizontal: 0),
  titleTextStyle: const TextStyle( color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
  title:  const AlertTitle(),
  content: imcController.resultadoIMC == -999 ?
 Center(
    heightFactor: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.warning,
           color: Colors.orange,
            size: 30),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text('VERIFIQUE OS CAMPOS DE PESO E ALTURA'),
        ),
      ],
    ),
  ) 
  : Column (
  mainAxisAlignment: MainAxisAlignment.center,
  mainAxisSize: MainAxisSize.min, 
 
  children: [
        
  PesoCaracteristicas(
  icon: Icon(
  Icons.person,
  color: Colors.blue,
    size: 30,),
  descricao: 'Peso:',
  valorImc: imcModel.peso,
 ),
     
   Divider(height: 1, color: Colors.yellow) ,
     
  AlturaCaracteristicas(
  icon: Icon(
  Icons.accessibility_new,
  color: Colors.blue,
  size: 30,
  ),
  descricao:' Altura:',
  valorImc: imcModel.altura,
  ),
  
   Divider(height: 1, color: Colors.yellow) ,

 ImcValor(
  icon: Icon(
  Icons.show_chart_outlined,
  color: Colors.blue,
  size: 30,
  ),
  descricao:' IMC:',
  valorImc: imcController.resultadoIMC,
 ),


MensagemIMC(imcModel: imcModel)


    ]
    ),





        
 actions: [
 TextButton(
  style: ButtonStyle(
    // ignore: deprecated_member_use
    backgroundColor: MaterialStateProperty.all(Colors.blue)
  ),
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

class ImcValor extends StatelessWidget {
  const ImcValor({
    super.key,
    required this.valorImc,
    required this.icon,
    required this.descricao,
  });

final double valorImc;
final Icon icon;
final String descricao;

 @override
  Widget build(BuildContext context) {
    return ListTile(
      
      leading: const Icon(
      Icons.show_chart,
       color: Colors.blue),
      // ignore: deprecated_member_use
      tileColor: Colors.blue.withOpacity(0.1),
      title: const Text('Valor IMC:', style: TextStyle(fontSize: 20, color: Colors.blue)),
      trailing: Text(valorImc.toString()),
 );
  }
}

class AlturaCaracteristicas extends StatelessWidget {
  const AlturaCaracteristicas({
    super.key,
    required this.valorImc, 
    required this.icon, 
    required this.descricao,
  });

  final double valorImc;
  final Icon icon;
  final String descricao;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      leading: const Icon(Icons.accessibility_new, color: Colors.blue,),
      // ignore: deprecated_member_use
      tileColor: Colors.blue.withOpacity(0.1),
      title: const Text('Altura:', style: TextStyle(fontSize: 20, color: Colors.blue)),
      trailing: Text(valorImc.toString()),
    );
  }
}

class PesoCaracteristicas extends StatelessWidget {
  const PesoCaracteristicas({
    super.key,
    required this.valorImc,
    required this.icon,
    required this.descricao,
  });

  final double valorImc;
  final Widget icon ; 
  final String descricao ;



  @override
  Widget build(BuildContext context) {
    return ListTile(
     leading: const Icon(Icons.height, color: Colors.blue),
     // ignore: deprecated_member_use
     tileColor: Colors.blue.withOpacity(0.1),
    title: Text ( "Peso:",  style: TextStyle(fontSize: 20, color: Colors.blue)),
    trailing: Text(valorImc.toString()),
    );
  }
}

class AlertTitle extends StatelessWidget {
  const AlertTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container (
    height: 60,
    decoration:  const BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        
    ),
     child:const Center(child:
      Text('Resultado IMC')),
    );
  }
}