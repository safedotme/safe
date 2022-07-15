import 'package:mobx/mobx.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'incident_log.store.g.dart';

class IncidentLogStore extends _IncidentLogStore with _$IncidentLogStore {}

abstract class _IncidentLogStore with Store {
  @observable
  PanelController controller = PanelController();

  @observable
  double offset = 0;

  @action
  void setOffset(double o) => offset = o;
}
