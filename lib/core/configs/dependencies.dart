// ignore_for_file: unnecessary_cast

import 'package:flutter_boilerplate/data/repositories/imc.dart';
import 'package:flutter_boilerplate/data/repositories/imc_impl.dart';
import 'package:flutter_boilerplate/ui/view_models/imc_calculator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> productionDependencies = [
  // Repositories:
  Provider(create: (_) => ImcRepositoryImpl() as ImcRepository),

  // View-models:
  ChangeNotifierProvider(
    create: (context) => ImcCalculatorViewModel(context.read<ImcRepository>()),
  ),
];
