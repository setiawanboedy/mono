import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/repositories/models/note.dart';

class NoteModelSerializer with JsonDecoder<Note>, JsonEncoder<Note> {
  @override
  Note fromJson(Map<String, dynamic> json) {
    return Note(
      username: json['username'] as String,
      text: json['text'] as String,
    );
  }

  @override
  Map<String, String> toJson(Note data) {
    return <String, String>{
      'username': data.username,
      'text': data.text,
    };
  }
}
