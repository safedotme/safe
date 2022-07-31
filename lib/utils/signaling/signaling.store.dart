import 'package:mobx/mobx.dart';

part 'signaling.store.g.dart';

class SignalingStore extends _SignalingStore with _$SignalingStore {}

abstract class _SignalingStore with Store {
  @observable
  List<Map<String, dynamic>>? candidates;

  @action
  void setCandidates(List<Map<String, dynamic>> c) => candidates = c;
}
