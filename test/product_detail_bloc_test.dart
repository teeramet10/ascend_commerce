import 'package:bloc_test/bloc_test.dart';
import 'package:data/repositories/product_repository_impl.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/features/product_detail/bloc/product_detail_bloc.dart';
import 'package:presentation/features/product_detail/bloc/product_detail_event.dart';
import 'package:presentation/features/product_detail/bloc/product_detail_state.dart';
import 'mock_datasource/mock_product_remote_datasource.dart';
import 'mock_network/mock_network_info.dart';

void main() {
  group("test get product list when connect internet", () {
    MockProductRemoteDataSource dataSource = MockProductRemoteDataSource();
    MockNetworkInfoImpl network = MockNetworkInfoImpl(true);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductDetailUseCase usecase = GetProductDetailUseCase(repositoryImpl);

    ProductDetailBloc bloc =
        ProductDetailBloc(getProductDetailUseCase: usecase);

    var data = mockProducts.last.toModel();

    bloc.add(InitialState(data: data));

    blocTest<ProductDetailBloc, ProductDetailState>(
      '',
      build: () => bloc,
      act: (bloc) => {bloc.add(GetProductDetailEvent())},
      expect: () => [
        isA<LoadingState>(),
        isA<ProductDetailState>(),
      ],
    );
    tearDown(() {
      bloc.close();
    });
  });

  group("test get product list when no internet connection", () {
    MockProductRemoteDataSource dataSource = MockProductRemoteDataSource();
    MockNetworkInfoImpl network = MockNetworkInfoImpl(false);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductDetailUseCase usecase = GetProductDetailUseCase(repositoryImpl);

    ProductDetailBloc bloc =
        ProductDetailBloc(getProductDetailUseCase: usecase);

    var data = mockProducts.last.toModel();
    bloc.add(InitialState(data: data));
    blocTest<ProductDetailBloc, ProductDetailState>(
      '',
      build: () => bloc,
      act: (bloc) => {bloc.add(GetProductDetailEvent())},
      expect: () => [isA<LoadingState>() ,isA<NetworkErrorState>()],
    );
    tearDown(() {
      bloc.close();
    });
  });

  group("test get product list when error", () {
    MockProductRemoteDataSource dataSource =
        MockProductRemoteDataSource(hasError: true);
    MockNetworkInfoImpl network = MockNetworkInfoImpl(true);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductDetailUseCase usecase = GetProductDetailUseCase(repositoryImpl);

    ProductDetailBloc bloc =
        ProductDetailBloc(getProductDetailUseCase: usecase);

    var data = mockProducts.last.toModel();
    bloc.add(InitialState(data: data));
    blocTest<ProductDetailBloc, ProductDetailState>(
      '',
      build: () => bloc,
      act: (bloc) => {bloc.add(GetProductDetailEvent())},
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>()
      ],
    );
    tearDown(() {
      bloc.close();
    });
  });

  group("test get product list initial data no id", () {
    MockProductRemoteDataSource dataSource =
        MockProductRemoteDataSource();
    MockNetworkInfoImpl network = MockNetworkInfoImpl(true);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductDetailUseCase usecase = GetProductDetailUseCase(repositoryImpl);

    ProductDetailBloc bloc =
        ProductDetailBloc(getProductDetailUseCase: usecase);

    bloc.add(InitialState(data: null));
    blocTest<ProductDetailBloc, ProductDetailState>(
      '',
      build: () => bloc,
      act: (bloc) => {bloc.add(GetProductDetailEvent())},
      expect: () => [isA<NoDataIDState>()],
    );
    tearDown(() {
      bloc.close();
    });
  });
}
