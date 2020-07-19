import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This widget listen for changes in the status of a [FormControl] specified
/// in [formControlName] property and call [builder] function to rebuild widgets.
///
/// This widget is just a wrapper around [ValueListenableBuilder]
/// that listen [AbstractControl.onStatusChanged]
///
class ReactiveStatusListenableBuilder extends StatelessWidget {
  /// The name of the control bound to this widgets
  final String formControlName;

  /// Optionally child widget
  final Widget child;

  /// The builder that creates a widget depending on the status of the control.
  final ReactiveListenableWidgetBuilder builder;

  /// Creates an instance of [ReactiveStatusListenableBuilder].
  ///
  /// The [formControlName] and the [builder] function must not be null.
  ///
  const ReactiveStatusListenableBuilder({
    Key key,
    @required this.formControlName,
    @required this.builder,
    this.child,
  })  : assert(formControlName != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final form =
        ReactiveForm.of(context, listen: false) as FormControlCollection;
    final formControl = form.control(this.formControlName);
    return ValueListenableBuilder<ControlStatus>(
      valueListenable: formControl.onStatusChanged,
      builder: (context, status, child) =>
          this.builder(context, formControl, child),
    );
  }
}
