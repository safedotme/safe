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

  late final _$isEditingAtom =
      Atom(name: '_ContactStore.isEditing', context: context);

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  late final _$controllerAtom =
      Atom(name: '_ContactStore.controller', context: context);

  @override
  PanelController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(PanelController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$editorControllerAtom =
      Atom(name: '_ContactStore.editorController', context: context);

  @override
  PanelController get editorController {
    _$editorControllerAtom.reportRead();
    return super.editorController;
  }

  @override
  set editorController(PanelController value) {
    _$editorControllerAtom.reportWrite(value, super.editorController, () {
      super.editorController = value;
    });
  }

  late final _$editorContactControllerAtom =
      Atom(name: '_ContactStore.editorContactController', context: context);

  @override
  EmergencyContactPopupController get editorContactController {
    _$editorContactControllerAtom.reportRead();
    return super.editorContactController;
  }

  @override
  set editorContactController(EmergencyContactPopupController value) {
    _$editorContactControllerAtom
        .reportWrite(value, super.editorContactController, () {
      super.editorContactController = value;
    });
  }

  late final _$editableAtom =
      Atom(name: '_ContactStore.editable', context: context);

  @override
  Contact? get editable {
    _$editableAtom.reportRead();
    return super.editable;
  }

  @override
  set editable(Contact? value) {
    _$editableAtom.reportWrite(value, super.editable, () {
      super.editable = value;
    });
  }

  late final _$countryCodeSelectorControllerAtom = Atom(
      name: '_ContactStore.countryCodeSelectorController', context: context);

  @override
  PanelController get countryCodeSelectorController {
    _$countryCodeSelectorControllerAtom.reportRead();
    return super.countryCodeSelectorController;
  }

  @override
  set countryCodeSelectorController(PanelController value) {
    _$countryCodeSelectorControllerAtom
        .reportWrite(value, super.countryCodeSelectorController, () {
      super.countryCodeSelectorController = value;
    });
  }

  late final _$isAddingAtom =
      Atom(name: '_ContactStore.isAdding', context: context);

  @override
  bool get isAdding {
    _$isAddingAtom.reportRead();
    return super.isAdding;
  }

  @override
  set isAdding(bool value) {
    _$isAddingAtom.reportWrite(value, super.isAdding, () {
      super.isAdding = value;
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
  void setIsEditing(bool v) {
    final _$actionInfo = _$_ContactStoreActionController.startAction(
        name: '_ContactStore.setIsEditing');
    try {
      return super.setIsEditing(v);
    } finally {
      _$_ContactStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditable(Contact c) {
    final _$actionInfo = _$_ContactStoreActionController.startAction(
        name: '_ContactStore.setEditable');
    try {
      return super.setEditable(c);
    } finally {
      _$_ContactStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsAdding(bool v) {
    final _$actionInfo = _$_ContactStoreActionController.startAction(
        name: '_ContactStore.setIsAdding');
    try {
      return super.setIsAdding(v);
    } finally {
      _$_ContactStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
homeWariningController: ${homeWariningController},
isEditing: ${isEditing},
controller: ${controller},
editorController: ${editorController},
editorContactController: ${editorContactController},
editable: ${editable},
countryCodeSelectorController: ${countryCodeSelectorController},
isAdding: ${isAdding}
    ''';
  }
}
