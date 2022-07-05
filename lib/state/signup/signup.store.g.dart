// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on _SignupStore, Store {
  late final _$nameInputControllerAtom =
      Atom(name: '_SignupStore.nameInputController', context: context);

  @override
  PanelController get nameInputController {
    _$nameInputControllerAtom.reportRead();
    return super.nameInputController;
  }

  @override
  set nameInputController(PanelController value) {
    _$nameInputControllerAtom.reportWrite(value, super.nameInputController, () {
      super.nameInputController = value;
    });
  }

  @override
  String toString() {
    return '''
nameInputController: ${nameInputController}
    ''';
  }
}
