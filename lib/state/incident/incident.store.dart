import 'package:mobx/mobx.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

part 'incident.store.g.dart';

class IncidentStore extends _IncidentStore with _$IncidentStore {}

abstract class _IncidentStore with Store {
  @observable
  Incident? incident;

  @action
  void setIncident(Incident i) => incident = i;

  @observable
  ScreenTransitionController controller = ScreenTransitionController();
}
