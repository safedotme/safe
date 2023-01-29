import 'package:mobx/mobx.dart';
import 'package:safe/models/incident/incident.model.dart';

part 'play.store.g.dart';

class PlayStore extends _PlayStore with _$PlayStore {}

abstract class _PlayStore with Store {
  @observable
  Incident? incident;

  @action
  void setIncident(Incident? i) => incident = i;
}
