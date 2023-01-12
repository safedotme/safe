import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/user/user.model.dart';
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

  @observable
  ScrollController scrollController = ScrollController();

  @observable
  ScrollPhysics? scrollPhysics = NeverScrollableScrollPhysics();

  @action
  void setScrollPhysics(ScrollPhysics? p) => scrollPhysics = p;

  @observable
  List<Incident>? incidents;

  @action
  setIncidents(List<Incident>? i) => incidents = i;

  @observable
  Map<String, String> thumbnails = {};

  @action
  void addThumbnail(String id, String path) => thumbnails[id] = path;

  @observable
  double scrollOffset = 0;

  @action
  void setScrollOffset(double o) => scrollOffset = o;

  @observable
  User? user;

  @action
  void setUser(User u) => user = u;
}
