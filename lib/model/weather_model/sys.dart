import 'package:json_annotation/json_annotation.dart';

part 'sys.g.dart';

@JsonSerializable()
class Sys {
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'sunrise')
  int? sunrise;
  @JsonKey(name: 'sunset')
  int? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
