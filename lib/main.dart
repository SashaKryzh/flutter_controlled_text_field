import 'package:flutter/material.dart';
import 'package:flutter_controlled_text_field/constants.dart';
import 'package:flutter_controlled_text_field/page_notifier.dart';
import 'package:flutter_controlled_text_field/use_controlled_text_editing_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const Home(),
      ),
    );
  }
}

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final fieldA = useState(kInitialValue);
    final controllerA = useControlledTextEditingController(
      text: fieldA.value,
      onChanged: (value) => fieldA.value = value,
    );

    final notifier = context.watch<PageNotifier>();
    final controllerB = useControlledTextEditingController(
      text: notifier.fieldB,
      onChanged: (value) => notifier.updateFieldB(value),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controllerA,
                decoration: const InputDecoration(
                  labelText: 'Field A',
                ),
              ),
              TextField(
                controller: controllerB,
                decoration: const InputDecoration(
                  labelText: 'Field B',
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  fieldA.value = kInitialValue;
                  notifier.updateFieldB(kInitialValue);
                },
                child: const Text('Reset fields'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
