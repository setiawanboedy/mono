import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/data_source/vote/vote_value_serializer.dart';
import 'package:budipest/repositories/models/vote.dart';

class VoteModelSerializer with JsonDecoder<Vote>, JsonEncoder<Vote> {
  @override
  Vote fromJson(Map<String, dynamic> json) {
    return Vote(
      username: json['username'] as String,
      value: VoteValueSerializer().fromType(
        json['value'] as String,
      ),
    );
  }

  @override
  Map<String, String> toJson(Vote data) {
    return <String, String>{
      'username': data.username,
      'value': VoteValueSerializer().toType(
        data.value,
      ),
    };
  }
}
