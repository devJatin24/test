class MovieModel{
  String? image;
  String? name;
  String? description;
  String? directorName;
  int? id;

  MovieModel({this.image, this.name, this.description, this.id,this.directorName});
  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description,'image':image,"directorN"
        "ame":directorName};
  }
}