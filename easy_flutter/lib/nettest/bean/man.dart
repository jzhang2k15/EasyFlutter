import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Man {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;

  Man({this.firstName, this.lastName, this.dateOfBirth});

  factory Man.fromJson(Map<String, dynamic> json) => _$ManFromJson(json);

//  Map<String, dynamic> toJson() => _$ManToJson(this);
}

Man _$ManFromJson(Map<String, dynamic> json) {
  return Man(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String));
}


