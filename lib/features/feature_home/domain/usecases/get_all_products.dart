import 'package:fpdart/src/either.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/usecase/usecase.dart';
import 'package:products_application/features/feature_home/domain/repository/home_repository.dart';

/// Use case for retrieving all products.
///
/// This class interacts with the [HomeRepository] to fetch a list of all available products.
/// It follows the Clean Architecture principle by separating the domain logic from other layers.
class GetAllProducts implements UseCase<List<Product>, NoParams> {
  /// The repository responsible for fetching product data.
  final HomeRepository homeRepository;

  /// Creates an instance of [GetAllProducts].
  ///
  /// - [homeRepository]: The repository implementation used for retrieving products
  GetAllProducts(this.homeRepository);

  /// Executes the use case.
  ///
  /// This method fetches all products by delegating the request to the [HomeRepository].
  /// It handles success and failure scenarios through the [Either] type.
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await homeRepository.getProducts();
  }
}
