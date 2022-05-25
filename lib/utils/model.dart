class Model {
  int? id;
  String nomb;
  String desc;
  String img;

  Model({
    this.id,
    required this.nomb,
    required this.desc,
    required this.img,
  });

  Map<String,dynamic>convertiraMap() {
    return {
      "id": id,
      "nomb": nomb,
      "desc": desc,
      "img": img,
    };
  }
}
