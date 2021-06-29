import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/repositories/models/entry_method.dart';

class EntryMethodSerializer
    with Encoder<EntryMethod, String>, Decoder<EntryMethod, String> {
  @override
  EntryMethod fromType(String data) {
    switch (data) {
      case 'free':
        return EntryMethod.free;
      case 'code':
        return EntryMethod.code;
      case 'price':
        return EntryMethod.price;
      case 'consumers':
        return EntryMethod.consumers;
      default:
        return EntryMethod.unknown;
    }
  }

  @override
  String toType(EntryMethod data) {
    return data.toString().split('.').last.toLowerCase();
  }
}
