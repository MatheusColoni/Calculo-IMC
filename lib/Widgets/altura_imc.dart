import 'package:flutter/material.dart';

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