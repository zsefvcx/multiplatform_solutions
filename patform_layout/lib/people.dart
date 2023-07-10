
class PeopleData{
  final int id;
  final String name;
  final String homeWorld;

  static List<PeopleData> peopleData = [];

  PeopleData(this.id, this.name, this.homeWorld);

  static void fromJson(dynamic data){
    int id = 0;
    if (data is List<dynamic>){
      for (var element in data) {
        if (element is Map<String, dynamic>){
          if( element['name'       ]!=null && element['name'       ] is String
              && element['homeworld'  ]!=null && element['homeworld'  ] is String
          ){
            id++;
            peopleData.add(
              PeopleData(
                id,
                element['name'] as String,
                element['homeworld'] as String
              )
            );
          }
        }
      }
    }
  }
}