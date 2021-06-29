import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/data_source/open_state/open_state_serializer.dart';
import 'package:budipest/repositories/models/open_state_details.dart';

class OpenStateDetailsModelSerializer
    with JsonDecoder<OpenStateDetails>, JsonEncoder<OpenStateDetails> {
  @override
  OpenStateDetails fromJson(Map<String, dynamic> json) {
    return OpenStateDetails(
      state: OpenStateSerializer().fromType(
        json['state'] as String,
      ),
      untilTime: json['untilTime'] as int,
      untilDay: json['untilDay'] as int,
    );
  }

  @override
  Map<String, String> toJson(OpenStateDetails data) {
    return <String, String>{
      'state': OpenStateSerializer().toType(data.state),
      'untilTime': data.untilTime.toString(),
      'untildDay': data.untilDay.toString(),
    };
  }
}
