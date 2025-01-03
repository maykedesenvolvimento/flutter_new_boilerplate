import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/presenter/view_models/login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    final loginCommand = viewModel.loginCommand;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: viewModel.setEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: viewModel.setPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10),
            AnimatedBuilder(
                animation: loginCommand,
                builder: (_, __) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.login,
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
                              child: loginCommand.isLoading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Icon(Icons.calculate),
                            ),
                            const Text('Entrar'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (loginCommand.isFailure)
                        Text(
                          loginCommand.error!.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      if (loginCommand.isSuccessful)
                        Text(
                          'Bem-vindo: ${loginCommand.result!.name}',
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
