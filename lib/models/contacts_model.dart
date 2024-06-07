import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';
@JsonSerializable()
class ContactsModel {
  int id;
  String name;
  String surname;
  int phone;

  ContactsModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.surname,
  });

  factory ContactsModel.fromJson(Map<String,dynamic> json){
    return  _$ContactsModelFromJson(json);
  }
}
