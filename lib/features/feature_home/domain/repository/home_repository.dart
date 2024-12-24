import 'package:fpdart/fpdart.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';

/// An abstract interface for the [HomeRepository].
///
/// This repository defines the contract for fetching product data from a data source,
/// regardless of whether the source is local, remote, or a combination of both.
abstract interface class HomeRepository {
  /// Retrieves a list of products.
  ///
  /// The method is expected to handle the following:
  /// 1. Fetching product data from a specific source.
  /// 2. Mapping the data to the domain layer entity ([Product]).
  /// 3. Wrapping the result in an [Either] to handle success and failure cases.
  Future<Either<Failure, List<Product>>> getProducts();
}
