class SerializerException implements Exception {
  SerializerException(this.msg);

  final String msg;

  @override
  String toString() {
    return 'Serializer Exception: $msg';
  }
}

abstract class Encoder<T, C> {
  C toType(T data);

  C encode(T data) {
    try {
      return toType(data);
    } on SerializerException {
      rethrow;
    } catch (e) {
      throw SerializerException('');
    }
  }
}

abstract class Decoder<T, C> {
  T fromType(C data);

  T decode(C data) {
    try {
      return fromType(data);
      /* 
    for embedded serializations
    } on SerializerException catch (e) {
      throw SerializerException(
        runtimeType.toString() + '(${e.msg})',
        child: e,
      ); */
    } catch (e) {
      throw SerializerException(e.toString());
    }
  }
}

abstract class JsonEncoder<T> {
  Map<String, dynamic> toJson(T data);

  Map<String, dynamic> encode(T data) {
    try {
      return toJson(data);
    } on SerializerException {
      rethrow;
    } catch (e) {
      throw SerializerException('');
    }
  }
}

abstract class JsonDecoder<T> {
  T fromJson(Map<String, dynamic> json);

  T decode(Map<String, dynamic> json) {
    try {
      return fromJson(json);
      /* 
    for embedded serializations
    } on SerializerException catch (e) {
      throw SerializerException(
        runtimeType.toString() + '(${e.msg})',
        child: e,
      ); */
    } catch (e) {
      throw SerializerException(e.toString());
    }
  }
}

void jsonTypeTest(Map<String, dynamic> json, Map<String, Type> params) {
  for (final MapEntry<String, Type> entry in params.entries) {
    if (!json.containsKey(entry.key)) {
      throw SerializerException('Missing field: ${entry.key}');
    }

    if (json[entry.key].runtimeType != entry.value) {
      throw SerializerException('${entry.key} field is not ${entry.value}');
    }
  }
}
