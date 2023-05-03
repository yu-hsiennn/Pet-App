class UserDetail {
  String name = "Oreo";
  int follower = 0;
  int posts_count = 0;
  String intro = "";
  int pet_count = 1;
  String photo = "123.jpg";
  List<String> posts = ["123.jpg", "456.jpg"];
  List<PetDetail> petdatas = [];

  UserDetail(
      String _name,
      int _follower,
      int _posts_count,
      String _intro,
      int _pet_count,
      String _photo,
      List<String> _posts,
      List<PetDetail> _petdatas) {
    name = _name;
    follower = _follower;
    posts = _posts;
    intro = _intro;
    pet_count = _pet_count;
    photo = _photo;
    posts_count = _posts_count;
    petdatas = _petdatas;
  }
}

class PetDetail {
  String name = "thing";
  String breed = "Gold";
  String gender = "Male";
  int age = 3;
  List<String> personality_lable = ["Smart", "annoying", "cute"];
  String photo = "789.jpg";

  PetDetail(String _name, String _breed, String _gender, int _age,
      List<String> _personality_label, String _photo) {
    name = _name;
    breed = _breed;
    gender = _gender;
    age = _age;
    personality_lable = _personality_label;
    photo = _photo;
  }
}
