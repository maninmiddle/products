import 'package:fpdart/fpdart.dart';
import 'package:products_application/core/error/failures.dart';

/// The [UseCase] class is an abstract interface for defining business logic operations
/// in the application. It defines a contract for use cases that return a result wrapped
/// in an [Either] to handle both success and failure outcomes.
///
/// The [UseCase] is typically used in the domain layer to separate business logic from
/// other layers of the app (like the UI or data layer).
///
/// The [call] method should be overridden in the concrete use case classes to perform
/// the actual operation.
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
