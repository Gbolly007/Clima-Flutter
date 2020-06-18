import 'package:json_annotation/json_annotation.dart';

part 'wind.g.dart';

@JsonSerializable()
class Wind {
    Wind();

    num speed;
    num deg;
    
    factory Wind.fromJson(Map<String,dynamic> json) => _$WindFromJson(json);
    Map<String, dynamic> toJson() => _$WindToJson(this);
}
