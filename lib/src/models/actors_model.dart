class Cast {
  List<Actor> cast = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = Actor.fromJsonMap(element);
      cast.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getPicture() {
    if (profilePath == null)
      return 'https://lh3.googleusercontent.com/proxy/Kyaco9ZIStWMg5tQzl8qghzvdhv_ImDwiJLIDZ3hSXsD2s0bP_cyvW4juKmxycwGO25SfiMhvmxhgiJBGIP5kzAap_rqVkIjdJKFQHcs4W0UlKOml6pPezwO_F7X';
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
