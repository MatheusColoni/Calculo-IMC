class ImcModel {
  final double altura;
  final double peso;
  String mensagem = '';



ImcModel({required this.peso, required this.altura, required this.mensagem});

  factory ImcModel.fromJson(Map json){
     return ImcModel(
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

  