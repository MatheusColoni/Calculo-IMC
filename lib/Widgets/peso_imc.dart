import 'package:flutter/material.dart';

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