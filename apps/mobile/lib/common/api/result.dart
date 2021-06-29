import 'failure.dart';

class ResultValue {
  ResultValue(this.value);

  final dynamic value;
}

class Result<Type> {
  Result.ok(Type value) : _resultValue = ResultValue(value);
  // only for void type
  Result.okEmpty() : _resultValue = ResultValue(0);
  Result.failure(Failure value) : _resultValue = ResultValue(value);

  final ResultValue _resultValue;
  dynamic get _value => _resultValue.value;

  bool get isFailed => _value is Failure;
  bool get isOk => !isFailed;
  Failure get failure => _value as Failure;
  Type get value => _value as Type;
  Result<CastType> castFailureTo<CastType>() =>
      Result<CastType>.failure(failure);

  @override
  String toString() {
    return isOk
        ? (_value != null ? _value.toString() : 'ok')
        : failure.toString();
  }
}
