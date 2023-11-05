import 'package:freezed_annotation/freezed_annotation.dart';
part 'ship_freezed.freezed.dart';
part 'ship_freezed.g.dart';

@freezed
class ShipsFreezed with _$ShipsFreezed {
  const factory ShipsFreezed(
      {@Default('') String ship_name,
      @Default('') String ship_type,
      @Default(0) int weight_kg,
      @Default(0) int year_built,
      @Default('') String home_port,
      @Default('') String url,
      @Default('') String image,
      @Default([]) List<String> roles,
      @Default([]) List<Mission> missions}) = _ShipsFreezed;

  factory ShipsFreezed.fromJson(Map<String, dynamic> json) =>
      _$ShipsFreezedFromJson(json);
}

@freezed
class Mission with _$Mission {
  const factory Mission({
    @Default('') String name,
    @Default(0) int flight,
  }) = _Mission;
  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);
}
