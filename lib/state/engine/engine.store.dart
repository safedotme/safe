import 'package:mobx/mobx.dart';

part 'engine.store.g.dart';

class EngineStore extends _EngineStore with _$EngineStore {}

abstract class _EngineStore with Store {
  @observable
  bool onStop = false;

  @action
  void setOnStop(bool v) => onStop = v;

  @observable
  int count = 0;

  @action
  void clearCount() => count = 0;

  @action
  void addCount() => count++;

  @observable
  List<Map<String, dynamic>> backlog = [];

  @action
  void addToBacklog(Map<String, dynamic> b) => backlog.add(b);

  @action
  void takeJob(Map<String, dynamic> job) =>
      backlog[backlog.indexOf(job)]["taken"] = true;

  @action
  void completeJob(Map<String, dynamic> job) => backlog.remove(job);
}
