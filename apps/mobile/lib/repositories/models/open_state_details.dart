import './open_state.dart';

class OpenStateDetails {
  const OpenStateDetails({
    required this.state,
    required this.untilTime,
    required this.untilDay,
  });

  final OpenState state;
  // in minutes, e.g. 600 -> 10:00 am
  final int untilTime;
  // Monday - 0; Sunday - 6
  final int untilDay;
}
