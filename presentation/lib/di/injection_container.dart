import 'package:domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/common/navigation/screen_navigation_service.dart';
import 'package:presentation/features/product_detail/bloc/product_detail_bloc.dart';
import 'package:presentation/features/product_list/bloc/product_list_bloc.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';
import 'package:data/repositories/product_repository_impl.dart';
import 'package:data/network_info.dart';
import 'package:data/datasource/product/product_datasource.dart';
import 'package:data/datasource/product/product_remote_datasource_impl.dart';
import 'package:data/http_manager.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  GetIt.I.allowReassignment = true;

  //bloc
  sl.registerFactory(() => ProductListBloc(getProductListUseCase: sl()));
  sl.registerFactory(() => ProductDetailBloc(getProductDetailUseCase: sl()));
  //usecase
  sl.registerLazySingleton(() => GetProductListUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailUseCase(sl()));

  //repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Data source
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(httpManager: sl()));

  //Core , Utils
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => HttpManager());
  sl.registerLazySingleton(() => ScreenNavigationService());

  //External
  sl.registerLazySingleton(() => DataConnectionChecker());

}
