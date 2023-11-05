// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShipsFreezedImpl _$$ShipsFreezedImplFromJson(Map<String, dynamic> json) =>
    _$ShipsFreezedImpl(
      ship_name: json['ship_name'] as String? ?? '',
      ship_type: json['ship_type'] as String? ?? '',
      weight_kg: json['weight_kg'] as int? ?? 0,
      year_built: json['year_built'] as int? ?? 0,
      home_port: json['home_port'] as String? ?? '',
      url: json['url'] as String? ?? '',
      image: json['image'] as String? ?? '',
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      missions: (json['missions'] as List<dynamic>?)
              ?.map((e) => Mission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ShipsFreezedImplToJson(_$ShipsFreezedImpl instance) =>
    <String, dynamic>{
      'ship_name': instance.ship_name,
      'ship_type': instance.ship_type,
      'weight_kg': instance.weight_kg,
      'year_built': instance.year_built,
      'home_port': instance.home_port,
      'url': instance.url,
      'image': instance.image,
      'roles': instance.roles,
      'missions': instance.missions,
    };

_$MissionImpl _$$MissionImplFromJson(Map<String, dynamic> json) =>
    _$MissionImpl(
      name: json['name'] as String? ?? '',
      flight: json['flight'] as int? ?? 0,
    );

Map<String, dynamic> _$$MissionImplToJson(_$MissionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'flight': instance.flight,
    };
