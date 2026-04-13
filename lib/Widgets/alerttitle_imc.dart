import 'package:flutter/material.dart';

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