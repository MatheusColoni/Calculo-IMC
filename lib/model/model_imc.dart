class IMC {
  final double altura;
  final double peso;

  IMC( this.altura,  this.peso);

  factory IMC.fromJson(Map json){
     return IMC(json['altura'], json['peso']);


  }


@override
String toString(){
return
'Altura: $altura, Peso: $peso';
 }
}

  