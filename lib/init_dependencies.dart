import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:products_application/core/services/cart_service.dart';
import 'package:products_application/features/feature_cart/data/data_sources/cart_local_data_source.dart';
import 'package:products_application/features/feature_cart/data/repository/cart_repository_impl.dart';
import 'package:products_application/features/feature_cart/domain/repository/cart_repository.dart';
import 'package:products_application/features/feature_cart/domain/usecases/add_product_to_cart.dart';
import 'package:products_application/features/feature_cart/domain/usecases/get_products_in_cart.dart';
import 'package:products_application/features/feature_cart/domain/usecases/remove_product_from_cart.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:products_application/features/feature_home/data/api/request/home_remote_data_source.dart';
import 'package:products_application/features/feature_home/data/repository/home_repository.dart';
import 'package:products_application/features/feature_home/domain/repository/home_repository.dart';
import 'package:products_application/features/feature_home/domain/usecases/get_all_products.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:products_application/navigation/bloc/navigation_bloc.dart';

part 'init_dependencies.main.dart';
