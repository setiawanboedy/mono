import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/repositories/models/open_state.dart';

class OpenStateSerializer
    with Encoder<OpenState, String>, Decoder<OpenState, String> {
  @override
  OpenState fromType(String data) {
    switch (data) {
      case 'open':
        return OpenState.open;
      case 'closed':
        return OpenState.closed;
      default:
        return OpenState.unknown;
    }
  }

  @override
  String toType(OpenState data) {
    return data.toString().split('.').last.toLowerCase();
  }
}
