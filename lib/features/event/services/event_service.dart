import 'package:timelineandprojectmanagementapp/features/event/model/event_model.dart';

class EventServices{
  List<EventModel> _events=[];
  Map<String,List> _finalEvents={};

  List<EventModel> getDataList() {
    return [
      EventModel(name: '2023-1-22', description: 'Description 1', title: 'Title 1'),
      EventModel(name: '2023-1-12', description: 'Description 2', title: 'Title 2'),
      EventModel(name: '2023-1-22', description: 'Description 3', title: 'Title 3'),
      EventModel(name: '2023-1-20', description: 'Description 4', title: 'Title 4'),
    ];
  }

  Map<String,List> getFinalDataList() {
    _events = getDataList();
    for (int i = 0; i < _events.length; i++) {

        if (_finalEvents[_events[i].name] != null) {
          _finalEvents[_events[i].name]
              ?.add({
            "eventTitle": _events[i].title,
            "eventDesc": _events[i].title,
          });
        } else {
          _finalEvents[_events[i].name] = [
            {
              "eventTitle": _events[i].title,
              "eventDesc": _events[i].title,
            }
          ];
        }
    }
    return _finalEvents;
  }

}