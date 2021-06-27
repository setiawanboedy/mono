import 'package:google_maps_flutter/google_maps_flutter.dart';

import './category.dart';
import './entry_method.dart';
import './note.dart';
import './open_state_details.dart';
import './tag.dart';
import './vote.dart';

class Toilet {
  const Toilet({
    required this.id,
    required this.username,
    required this.name,
    required this.category,
    required this.entryMethod,
    required this.code,
    required this.tags,
    required this.priceHuf,
    required this.priceEur,
    required this.coords,
    required this.distance,
    required this.state,
    required this.votes,
    required this.notes,
  });

  final String id;
  final String username;
  final String name;
  final Category category;
  final EntryMethod entryMethod;
  final String code;
  final List<Tag> tags;
  final int priceHuf;
  final int priceEur;
  final LatLng coords;
  final int distance;
  final OpenStateDetails state;
  final List<Vote> votes;
  final List<Note> notes;
}
