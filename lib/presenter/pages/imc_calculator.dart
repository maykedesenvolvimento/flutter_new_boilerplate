import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/presenter/view_models/imc_calculator.dart';
import 'package:provider/provider.dart';

class ImcCalculatorPage extends StatelessWidget {
  const ImcCalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImcCalculatorViewModel>();
    final calculateImcCommand = viewModel.calculateImcCommand;

    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: viewModel.setHeight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: viewModel.setWeight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            const SizedBox(height: 10),
            AnimatedBuilder(
                animation: calculateImcCommand,
                builder: (_, __) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.calculateImc,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(
                                right: 10,
                                bottom: 8,
                                top: 8,
                              ),
                              alignment: Alignment.center,
                              child: calculateImcCommand.isLoading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Icon(Icons.calculate),
                            ),
                            const Text('Calcular IMC'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (calculateImcCommand.isFailure)
                        Text(
                          calculateImcCommand.error!.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      if (calculateImcCommand.isSuccessful)
                        Text(
                          'O IMC deste indivíduo é: ${calculateImcCommand.result!.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.green),
                        ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
