
class PeopleData{
  final int id;
  final String name;
  final String status;
  final String image;
  final String gender;

  static List<PeopleData> peopleData = [];

  PeopleData(this.id, this.name, this.status, this.image, this.gender);

  static void fromJson(dynamic data){
    if (data is List<dynamic>){
      for (var element in data) {
        if (element is Map<String, dynamic>){
          if(    element['id'         ]!=null && element['id'         ] is int
              && element['name'       ]!=null && element['name'       ] is String
              && element['status']!=null && element['status'] is String
              && element['image'  ]!=null && element['image'] is String
              && element['gender'  ]!=null && element['gender'] is String
          ){
            peopleData.add(
              PeopleData(
                element['id'] as int,
                element['name'] as String,
                element['status'] as String,
                element['image'] as String,
                element['gender'] as String
              )
            );
          }
        }
      }
    }
  }
}