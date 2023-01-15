import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/local_widgets/emergency_contact_popup_header.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_player/video_player.dart';

part 'incident.store.g.dart';

class IncidentStore extends _IncidentStore with _$IncidentStore {}

abstract class _IncidentStore with Store {
  @observable
  ScrollController scrollController = ScrollController();

  @observable
  List<NotifiedContact> contacts = [];

  @action
  void setContacts(List<NotifiedContact> c) => contacts = c;

  @observable
  PanelController contactPopupController = PanelController();

  @observable
  EmergencyContactPopupController contactPopupValuesController =
      EmergencyContactPopupController();

  @observable
  String? incidentId;

  @action
  void setIncidentId(String id) => incidentId = id;

  @observable
  ScreenTransitionController controller = ScreenTransitionController();

  @observable
  ScreenTransitionController playController = ScreenTransitionController();

  @observable
  String? mapStyle;

  @action
  void setMapStyle(String s) => mapStyle = s;

  // PLAY
  @observable
  bool isPlayerOpen = false;

  @action
  void setIsPlayerOpen(bool b) => isPlayerOpen = b;

  @observable
  GoogleMapController? mapController;

  @action
  void setMapController(GoogleMapController? c) => mapController = c;

  @observable
  VideoPlayerController? player;

  @action
  void setPlayer(VideoPlayerController? c) => player = c;
}
