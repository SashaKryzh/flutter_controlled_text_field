import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TextEditingController useControlledTextEditingController({
  String text = '',
  void Function(String)? onChanged,
  List<Object?>? keys,
}) {
  return use(_ControlledTextEditingControllerHook(text, onChanged, keys));
}

class _ControlledTextEditingControllerHook extends Hook<TextEditingController> {
  const _ControlledTextEditingControllerHook(
    this.text,
    this.onChanged,
    List<Object?>? keys,
  ) : super(keys: keys);

  final String text;
  final void Function(String)? onChanged;

  @override
  _ControlledTextEditingControllerHookState createState() =>
      _ControlledTextEditingControllerHookState();
}

class _ControlledTextEditingControllerHookState extends HookState<
    TextEditingController, _ControlledTextEditingControllerHook> {
  late final _controller = TextEditingController(text: hook.text);

  @override
  void initHook() {
    _controller.addListener(_listener);
  }

  @override
  void didUpdateHook(_ControlledTextEditingControllerHook oldHook) {
    if (_controller.text != hook.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = hook.text;
      });
    }
  }

  @override
  TextEditingController build(BuildContext context) {
    return _controller;
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
  }

  void _listener() {
    hook.onChanged?.call(_controller.text);
  }
}
