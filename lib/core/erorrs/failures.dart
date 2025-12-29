abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ValidationError extends Failure {
  const ValidationError(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
