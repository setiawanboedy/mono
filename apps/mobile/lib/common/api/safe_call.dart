import 'api_exceptions.dart';
import 'failure.dart';
import 'result.dart';
import 'serializer.dart';

const String fatalErrorStr =
    'Váratlan hiba történt, indítsa újra az applikációt';

String _defaultClientExceptionMessage(ClientExceptionType type) {
  switch (type) {
    case ClientExceptionType.badRequestException:
      return 'Hibás kérés!';
    case ClientExceptionType.unauthorizedException:
      return 'Nincs jogosultság!';
    case ClientExceptionType.forbiddenException:
      return 'Nem megengedett művelet!';
    case ClientExceptionType.notFoundException:
      return 'Nem található!';
    case ClientExceptionType.timoutException:
      return 'Időtúllépés!';
    case ClientExceptionType.undefined:
      return 'Ismeretlen hiba!';
  }
}

Future<Result<R>> safeCall<R>(
  Future<R> Function() callback, {
  Map<ClientExceptionType, String>? errorMessages,
}) async {
  try {
    final R value = await callback();
    return Result<R>.ok(value);
  } on ClientException catch (e) {
    final String errorMessage =
        errorMessages?[e.type] ?? _defaultClientExceptionMessage(e.type);

    return Result<R>.failure(Failure(
      errorMessage,
      e.toString(),
    ));
  } on InternalServerError catch (e) {
    final Failure failure = Failure(
      fatalErrorStr,
      e.toString(),
    );
    return Result<R>.failure(failure);
  } on SerializerException catch (e) {
    final Failure failure = Failure(fatalErrorStr, e.toString());
    return Result<R>.failure(failure);
  } catch (e) {
    final Failure failure = Failure(fatalErrorStr, e.toString());
    return Result<R>.failure(failure);
  }
}
