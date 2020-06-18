import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@JsonSerializable()
class Main {
    Main();

    num temp;
    num temp_min;
    num temp_max;
    num pressure;
    num sea_level;
    num grnd_level;
    num humidity;
    num temp_kf;
    
    factory Main.fromJson(Map<String,dynamic> json) => _$MainFromJson(json);
    Map<String, dynamic> toJson() => _$MainToJson(this);
}
