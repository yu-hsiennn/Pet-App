class UserData {
  String name;
  int follower;
  int posts_count;
  String intro;
  int pet_count;
  String photo;
  List<PetDetail> petdatas;

  UserData(
      {required this.name,
      this.follower = 0,
      this.posts_count = 0,
      this.intro = '',
      this.pet_count = 0,
      this.photo = '',
      required this.petdatas});
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
