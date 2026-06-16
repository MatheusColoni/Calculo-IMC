// Testes de regressão do ImcController
//
// Cobrem as três mudanças de comportamento registradas no histórico de commits:
//
//  commit 526763f — try/catch adicionado em _calcularIMC
//  commit 3727141 — operadores de faixa corrigidos (<= → < e <= 25 → < 24.9)
//  commit 008bae1 — guarda de altura <= 0 adicionada

import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_ebac_imc/controller/controller_imc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ImcController controller;

  setUp(() => controller = ImcController());
  tearDown(() {
    controller.pesoController.dispose();
    controller.alturaController.dispose();
  });

  // ── commit 526763f ────────────────────────────────────────────────────────
  // Antes: entrada inválida lançava exceção e exibia tela vermelha.
  // Depois: try/catch captura o erro e retorna modelo vazio.
  group('Regressão 526763f — try/catch em _calcularIMC', () {
    test('texto não numérico não lança exceção', () {
      controller.pesoController.text = 'abc';
      controller.alturaController.text = 'xyz';
      expect(() => controller.processarIMC(), returnsNormally);
    });

    test('texto não numérico retorna modelo vazio ao invés de travar', () {
      controller.pesoController.text = 'abc';
      controller.alturaController.text = '1.75';
      final result = controller.processarIMC();
      expect(result.peso, 0);
      expect(result.altura, 0);
      expect(result.mensagem, '');
    });

    test('caracteres especiais não lançam exceção', () {
      controller.pesoController.text = '@#!';
      controller.alturaController.text = '???';
      expect(() => controller.processarIMC(), returnsNormally);
    });
  });

  // ── commit 3727141 ────────────────────────────────────────────────────────
  // Antes: "peso baixo"  era  >= 17 && <= 18.5  (incluía o limite superior)
  //        "peso ideal"  era  >= 18.5 && <= 25   (incluía o limite superior)
  // Depois: operadores corrigidos para < 18.5 e < 24.9, evitando sobreposição.
  group('Regressão 3727141 — fronteiras das faixas de IMC', () {
    // IMC = 18.50 — antes retornava "peso baixo" (pois <= 18.5 era verdadeiro),
    // agora deve retornar "peso ideal".
    test('IMC = 18.50 retorna "peso ideal", não mais "peso baixo"', () {
      // peso=56.65 / (1.75²=3.0625) ≈ 18.4979 → arredonda para 18.50
      controller.pesoController.text = '56.65';
      controller.alturaController.text = '1.75';
      expect(controller.processarIMC().mensagem, 'peso ideal');
    });

    // IMC logo abaixo de 18.5 ainda deve ser "peso baixo".
    test('IMC = 18.40 ainda retorna "peso baixo"', () {
      // peso=56.34 / (1.75²) ≈ 18.40
      controller.pesoController.text = '56.34';
      controller.alturaController.text = '1.75';
      expect(controller.processarIMC().mensagem, 'peso baixo');
    });

    // IMC = 25.0 — antes retornava "peso ideal" (pois <= 25 era verdadeiro),
    // agora deve retornar "sobrepeso".
    test('IMC = 25.00 retorna "sobrepeso", não mais "peso ideal"', () {
      // peso=76.56 / (1.75²=3.0625) ≈ 24.998 → arredonda para 25.00
      controller.pesoController.text = '76.56';
      controller.alturaController.text = '1.75';
      expect(controller.processarIMC().mensagem, 'sobrepeso');
    });

    // IMC logo abaixo de 24.9 ainda deve ser "peso ideal".
    test('IMC = 24.80 ainda retorna "peso ideal"', () {
      // peso=75.95 / (1.75²) ≈ 24.80
      controller.pesoController.text = '75.95';
      controller.alturaController.text = '1.75';
      expect(controller.processarIMC().mensagem, 'peso ideal');
    });

    // Limites das demais faixas que não foram alteradas.
    test(
      'IMC = 17.0 exato retorna "peso baixo" (limite inferior inalterado)',
      () {
        // peso=52.06 / (1.75²=3.0625) ≈ 16.999 → arredonda para 17.00
        controller.pesoController.text = '52.06';
        controller.alturaController.text = '1.75';
        expect(controller.processarIMC().mensagem, 'peso baixo');
      },
    );

    test(
      'IMC = 16.0 exato retorna "baixo peso, grave" (limite inferior inalterado)',
      () {
        // peso=49.0 / (1.75²) ≈ 16.0
        controller.pesoController.text = '49.0';
        controller.alturaController.text = '1.75';
        expect(controller.processarIMC().mensagem, 'baixo peso, grave');
      },
    );
  });

  // ── commit 008bae1 ────────────────────────────────────────────────────────
  // Antes: altura = 0 causava divisão por zero (DivisionByZeroException).
  // Depois: guarda `if (alturaIMC <= 0)` retorna -999 e o modelo vazio.
  group('Regressão 008bae1 — guarda de altura <= 0', () {
    test('altura = 0 não lança DivisionByZeroException', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '0';
      expect(() => controller.processarIMC(), returnsNormally);
    });

    test('altura = 0 retorna modelo vazio', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '0';
      final result = controller.processarIMC();
      expect(result.peso, 0);
      expect(result.altura, 0);
      expect(result.mensagem, '');
    });

    test('altura negativa não lança exceção', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '-1.75';
      expect(() => controller.processarIMC(), returnsNormally);
    });

    test('altura negativa retorna modelo vazio', () {
      controller.pesoController.text = '70';
      controller.alturaController.text = '-1.75';
      final result = controller.processarIMC();
      expect(result.peso, 0);
      expect(result.altura, 0);
      expect(result.mensagem, '');
    });
  });
}
