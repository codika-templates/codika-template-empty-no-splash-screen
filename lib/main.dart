import 'package:codika_template_empty_no_splash_screen/app.dart';
import 'package:flutter/material.dart';

Future<void> runMainApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = errorBuilderWidget;

  // Add your initialization code here

  runApp(const MyApp());
}

Widget errorBuilderWidget(FlutterErrorDetails details) {
  return Material(
    child: Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("An Error Was Encountered"),
              const SizedBox(height: 32),
              Text(details.exception.toString()),
            ],
          ),
        ),
      ),
    ),
  );
}
