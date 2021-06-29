import 'package:budipest/common/api/serializer.dart';
import 'package:budipest/data_source/note/note_model_serializer.dart';
import 'package:budipest/data_source/open_state/open_state_details_model_serializer.dart';
import 'package:budipest/data_source/toilet/category_serializer.dart';
import 'package:budipest/data_source/toilet/entry_method_serializer.dart';
import 'package:budipest/data_source/toilet/tag_serializer.dart';
import 'package:budipest/data_source/vote/vote_model_serializer.dart';
import 'package:budipest/repositories/models/note.dart';
import 'package:budipest/repositories/models/tag.dart';
import 'package:budipest/repositories/models/toilet.dart';
import 'package:budipest/repositories/models/vote.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ToiletModelSerializer with JsonDecoder<Toilet>, JsonEncoder<Toilet> {
  @override
  Toilet fromJson(Map<String, dynamic> json) {
    return Toilet(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      category: CategorySerializer().fromType(
        json['category'] as String,
      ),
      entryMethod: EntryMethodSerializer().fromType(
        json['entryMethod'] as String,
      ),
      code: json['code'] as String,
      tags: List<String>.from(
        json['tags'] as Iterable<String>,
      )
          .map(
            (String tag) => TagSerializer().fromType(tag),
          )
          .toList(),
      priceHuf: json['priceHuf'] as int,
      priceEur: json['priceEur'] as int,
      coords: LatLng(
        json['coords']['lat'] as double,
        json['coords']['lon'] as double,
      ),
      distance: json['distance'] as int,
      state: OpenStateDetailsModelSerializer().fromJson(
        json['state'] as Map<String, dynamic>,
      ),
      votes: List<Map<String, dynamic>>.from(
        json['votes'] as Iterable<Map<String, dynamic>>,
      )
          .map(
            (Map<String, dynamic> vote) => VoteModelSerializer().fromJson(
              vote,
            ),
          )
          .toList(),
      notes: List<Map<String, dynamic>>.from(
        json['notes'] as Iterable<Map<String, dynamic>>,
      )
          .map(
            (Map<String, dynamic> note) => NoteModelSerializer().fromJson(
              note,
            ),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(Toilet data) {
    return <String, dynamic>{
      'id': data.id,
      'username': data.username,
      'name': data.name,
      'category': CategorySerializer().toType(data.category),
      'entryMethod': EntryMethodSerializer().toType(data.entryMethod),
      'code': data.code,
      'tags': data.tags
          .map(
            (Tag tag) => TagSerializer().toType(tag),
          )
          .toList(),
      'priceHuf': data.priceHuf.toString(),
      'priceEur': data.priceEur.toString(),
      'coords': <String, double>{
        'lat': data.coords.latitude,
        'lon': data.coords.longitude,
      },
      'distance': data.distance,
      'state': OpenStateDetailsModelSerializer().toJson(data.state),
      'votes': data.votes
          .map((Vote vote) => VoteModelSerializer().toJson(vote))
          .toList(),
      'notes': data.notes
          .map((Note note) => NoteModelSerializer().toJson(note))
          .toList(),
    };
  }
}
