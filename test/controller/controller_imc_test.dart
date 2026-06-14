import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_ebac_imc/controller/controller_imc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ImcController controller;

  setUp(() {
    controller = ImcController();
  });

  tearDown(() {
    controller.pesoController.dispose();
    controller.alturaController.dispose();
  });

  group('habilitaBotao', () {
    test('botão desabilitado quando ambos os campos estão vazios', () {
      expect(controller.botaoProcessar.value, false);
    });

    test('botão desabilitado quando apenas peso está preenchido', () {
      controller.pesoController.text = '70';
      expect(controller.botaoProcessar.value, false);
    });

    test('botão desabilitado quando apenas altura está preenchida', () {
      controller.alturaController.text = '1.75';
      expect(controller.botaoProcessar.value, false);
    });

    test('botão habilitado quando ambos os campos estão preenchidos', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '1.75';
      expect(controller.botaoProcessar.value, true);
    });

    test('botão desabilitado ao limpar um campo após preenchimento', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '1.75';
      controller.alturaController.text = '';
      expect(controller.botaoProcessar.value, false);
    });
  });

  group('processarIMC - entradas válidas', () {
    test('calcula IMC corretamente para valores inteiros', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '1.75';
      // IMC = 70 / (1.75 * 1.75) ≈ 22.86
      final result = controller.processarIMC();
      expect(result.peso, 70.0);
      expect(result.altura, 1.75);
      expect(result.mensagem, 'peso ideal');
    });

    test('aceita vírgula como separador decimal', () {
      controller.pesoController.text = '70,5';
      controller.alturaController.text = '1,75';
      final result = controller.processarIMC();
      expect(result.peso, 70.5);
      expect(result.altura, 1.75);
    });
  });

  group('processarIMC - entradas inválidas', () {
    test('retorna modelo vazio quando altura é 0', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '0';
      final result = controller.processarIMC();
      expect(result.peso, 0);
      expect(result.altura, 0);
      expect(result.mensagem, '');
    });

    test('retorna modelo vazio quando altura é negativa', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '-1.75';
      final result = controller.processarIMC();
      expect(result.mensagem, '');
    });

    test('retorna modelo vazio quando peso é texto inválido', () {
      controller.pesoController.text = 'abc';
      controller.alturaController.text = '1.75';
      final result = controller.processarIMC();
      expect(result.peso, 0);
      expect(result.altura, 0);
      expect(result.mensagem, '');
    });

    test('retorna modelo vazio quando ambos os campos são texto inválido', () {
      controller.pesoController.text = 'abc';
      controller.alturaController.text = 'xyz';
      final result = controller.processarIMC();
      expect(result.peso, 0);
      expect(result.altura, 0);
      expect(result.mensagem, '');
    });
  });

  group('obterMensagemIMC - faixas de IMC', () {
    void setValues(String peso, String altura) {
      controller.pesoController.text = peso;
      controller.alturaController.text = altura;
    }

    test('IMC < 16 retorna "baixo peso, muito grave"', () {
      setValues('38', '1.65'); // IMC ≈ 13.96
      expect(controller.processarIMC().mensagem, 'baixo peso, muito grave');
    });

    test('IMC >= 16 e < 17 retorna "baixo peso, grave"', () {
      setValues('45', '1.67'); // IMC ≈ 16.14
      expect(controller.processarIMC().mensagem, 'baixo peso, grave');
    });

    test('IMC >= 17 e < 18.5 retorna "peso baixo"', () {
      setValues('48', '1.68'); // IMC ≈ 17.01
      expect(controller.processarIMC().mensagem, 'peso baixo');
    });

    test('IMC >= 18.5 e < 24.9 retorna "peso ideal"', () {
      setValues('70', '1.75'); // IMC ≈ 22.86
      expect(controller.processarIMC().mensagem, 'peso ideal');
    });

    test('IMC >= 25 e < 30 retorna "sobrepeso"', () {
      setValues('80', '1.72'); // IMC ≈ 27.04
      expect(controller.processarIMC().mensagem, 'sobrepeso');
    });

    test('IMC >= 30 e < 35 retorna "obesidade grau 1"', () {
      setValues('95', '1.72'); // IMC ≈ 32.11
      expect(controller.processarIMC().mensagem, 'obesidade grau 1');
    });

    test('IMC >= 35 e < 40 retorna "obesidade grau 2"', () {
      setValues('110', '1.72'); // IMC ≈ 37.18
      expect(controller.processarIMC().mensagem, 'obesidade grau 2');
    });

    test('IMC >= 40 retorna "obesidade grau 3 (obesidade mórbida)"', () {
      setValues('135', '1.73'); // IMC ≈ 45.11
      expect(
        controller.processarIMC().mensagem,
        'obesidade grau 3 (obesidade mórbida) = maior que 40kg/m2',
      );
    });
  });
}
