class IMC {
  final double altura;
  final double peso;
  String mensagem = '';



IMC({required this.peso, required this.altura, required this.mensagem});

  factory IMC.fromJson(Map json){
     return IMC(
      peso: json['peso'],
      altura: json['altura'],
      mensagem: json['mensagem'] ?? ''
    );


  }


@override
String toString(){
return
'Altura: $altura, Peso: $peso, Mensagem: $mensagem';
 }
}

  