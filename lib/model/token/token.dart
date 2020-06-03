
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';
@JsonSerializable()
class Token {
  @JsonKey(name: 'accessToken')
  String accessToken;
  @JsonKey(name: 'tokenType')
  String tokenType;

  @JsonKey(ignore: true)
  String error;

  Token(this.accessToken, this.tokenType);

  Token.withError(this.error);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}