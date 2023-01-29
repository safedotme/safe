// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayStore on _PlayStore, Store {
  late final _$incidentAtom =
      Atom(name: '_PlayStore.incident', context: context);

  @override
  Incident? get incident {
    _$incidentAtom.reportRead();
    return super.incident;
  }

  @override
  set incident(Incident? value) {
    _$incidentAtom.reportWrite(value, super.incident, () {
      super.incident = value;
    });
  }

  late final _$_PlayStoreActionController =
      ActionController(name: '_PlayStore', context: context);

  @override
  void setIncident(Incident? i) {
    final _$actionInfo = _$_PlayStoreActionController.startAction(
        name: '_PlayStore.setIncident');
    try {
      return super.setIncident(i);
    } finally {
      _$_PlayStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
incident: ${incident}
    ''';
  }
}
