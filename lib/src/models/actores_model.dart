class Cast {
  List<Actor> actores = List();

  Cast.fromJsonMap(List<dynamic> lista) {
    if (lista == null) return;
    lista.forEach((element) {
      actores.add(Actor.fromJsonMap(element));
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

  getFoto() {
    print(profilePath);
    return (profilePath == null)
        ? 'https://i.pinimg.com/originals/72/2b/28/722b2826eb22634b6f963db69a6c11a5.gif'
        : 'https://image.tmdb.org/t/p/w500$profilePath';
  }
}
