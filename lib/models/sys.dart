import 'package:json_annotation/json_annotation.dart';

part 'sys.g.dart';

@JsonSerializable()
class Sys {
    Sys();

    String pod;
    
    factory Sys.fromJson(Map<String,dynamic> json) => _$SysFromJson(json);
    Map<String, dynamic> toJson() => _$SysToJson(this);
}
