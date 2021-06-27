import './vote_value.dart';

class Vote {
  const Vote({
    required this.username,
    required this.value,
  });

  final String username;
  final VoteValue value;
}
