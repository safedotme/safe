// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactStore on _ContactStore, Store {
  late final _$contactsAtom =
      Atom(name: '_ContactStore.contacts', context: context);

  @override
  List<Contact>? get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<Contact>? value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$homeWariningControllerAtom =
      Atom(name: '_ContactStore.homeWariningController', context: context);

  @override
  PanelController get homeWariningController {
    _$homeWariningControllerAtom.reportRead();
    return super.homeWariningController;
  }

  @override
  set homeWariningController(PanelController value) {
    _$homeWariningControllerAtom
        .reportWrite(value, super.homeWariningController, () {
      super.homeWariningController = value;
    });
  }

  late final _$_ContactStoreActionController =
      ActionController(name: '_ContactStore', context: context);

  @override
  void setContacts(List<Contact> c) {
    final _$actionInfo = _$_ContactStoreActionController.startAction(
        name: '_ContactStore.setContacts');
    try {
      return super.setContacts(c);
    } finally {
      _$_ContactStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
homeWariningController: ${homeWariningController}
    ''';
  }
}
