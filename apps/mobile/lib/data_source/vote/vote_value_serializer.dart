import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/repositories/models/vote_value.dart';

class VoteValueSerializer
    with Encoder<VoteValue, String>, Decoder<VoteValue, String> {
  @override
  VoteValue fromType(String data) {
    switch (data) {
      case 'upvote':
        return VoteValue.upvote;
      case 'downvote':
        return VoteValue.downvote;
    }

    throw SerializerException('Unknown type $data');
  }

  @override
  String toType(VoteValue data) {
    return data.toString().split('.').last.toLowerCase();
  }
}
