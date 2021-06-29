class Failure {
  const Failure(this.reason, [this.apiMessage]);

  final String reason; // message presented on ui
  final String? apiMessage; // message from backend

  @override
  String toString() {
    return reason;
  }

  String toDetailedString() {
    return 'reason: $reason, apiMessage: $apiMessage';
  }
}
