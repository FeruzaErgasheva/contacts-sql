// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) =>
    ContactsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: (json['phone'] as num).toInt(),
      surname: json['surname'] as String,
    );

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'phone': instance.phone,
    };
