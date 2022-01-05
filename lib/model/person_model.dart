import 'dart:convert';

class PersonModel {
  String? name;
  String? mail;
  String? password;
  String? sex;
  String? age;
  String? length;
  String? weight;
  PersonModel({
    this.name,
    this.mail,
    this.password,
    this.sex,
    this.age,
    this.length,
    this.weight,
  });

  PersonModel copyWith({
    String? name,
    String? mail,
    String? password,
    String? sex,
    String? age,
    String? length,
    String? weight,
  }) {
    return PersonModel(
      name: name ?? this.name,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      length: length ?? this.length,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mail': mail,
      'password': password,
      'sex': sex,
      'age': age,
      'length': length,
      'weight': weight,
    };
  }

  factory PersonModel.fromMap(Map<dynamic, dynamic> map) {
    return PersonModel(
      name: map['name'],
      mail: map['mail'],
      password: map['password'],
      sex: map['sex'],
      age: map['age'],
      length: map['length'],
      weight: map['weight'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonModel(name: $name, mail: $mail, password: $password, sex: $sex, age: $age, length: $length, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.name == name &&
        other.mail == mail &&
        other.password == password &&
        other.sex == sex &&
        other.age == age &&
        other.length == length &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        mail.hashCode ^
        password.hashCode ^
        sex.hashCode ^
        age.hashCode ^
        length.hashCode ^
        weight.hashCode;
  }
}
