import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/repositories/models/tag.dart';

class TagSerializer with Encoder<Tag, String>, Decoder<Tag, String> {
  @override
  Tag fromType(String data) {
    switch (data) {
      case 'wheelchairAccessible':
        return Tag.wheelchairAccessible;
      case 'babyRoom':
        return Tag.babyRoom;
    }

    throw SerializerException('Unknown type $data');
  }

  @override
  String toType(Tag data) {
    return data.toString().split('.').last.toLowerCase();
  }
}
