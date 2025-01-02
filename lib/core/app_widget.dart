import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/configs/dependencies.dart';
import 'package:provider/provider.dart';

import '../data/repositories/imc_impl.dart';
import '../ui/pages/imc_calculator.dart';
import '../ui/view_models/imc_calculator.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: productionDependencies,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ImcCalculatorPage(),
      ),
    );
  }
}