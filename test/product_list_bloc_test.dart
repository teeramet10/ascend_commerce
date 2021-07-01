import 'package:bloc_test/bloc_test.dart';
import 'package:data/repositories/product_repository_impl.dart';
import 'package:domain/repositories/product_repository.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/features/product_list/bloc/product_list_bloc.dart';
import 'package:presentation/features/product_list/bloc/product_list_event.dart';
import 'package:presentation/features/product_list/bloc/product_list_state.dart';

import 'mock_datasource/mock_product_remote_datasource.dart';
import 'mock_network/mock_network_info.dart';

void main() {
  group("test get product list when connect internet", () {
    MockProductRemoteDataSource dataSource = MockProductRemoteDataSource();
    MockNetworkInfoImpl network = MockNetworkInfoImpl(true);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductListUseCase usecase = GetProductListUseCase(repositoryImpl);

    ProductListBloc bloc = ProductListBloc(getProductListUseCase: usecase);

    blocTest<ProductListBloc, ProductListState>(
      '',
      build: () => bloc,
      act: (bloc) => bloc.add(GetProductListEvent()),
      expect: () =>
      [
        LoadingState(),
        isA<ProductListState>() ,
      ],
    );
    tearDown((){
      bloc.close();
    });
  });


  group("test get product list when no connect internet", () {
    MockProductRemoteDataSource dataSource = MockProductRemoteDataSource();
    MockNetworkInfoImpl network = MockNetworkInfoImpl(false);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductListUseCase usecase = GetProductListUseCase(repositoryImpl);

    ProductListBloc bloc = ProductListBloc(getProductListUseCase: usecase);

    blocTest<ProductListBloc, ProductListState>(
      '',
      build: () => bloc,
      act: (bloc) => bloc.add(GetProductListEvent()),
      expect: () =>
      [
        LoadingState(),
        NetworkErrorState(),
      ],
    );
    tearDown((){
      bloc.close();
    });
  });

  group("test get product list not found data", () {
    MockProductRemoteDataSource dataSource = MockProductRemoteDataSource(hasData: false);
    MockNetworkInfoImpl network = MockNetworkInfoImpl(true);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductListUseCase usecase = GetProductListUseCase(repositoryImpl);

    ProductListBloc bloc = ProductListBloc(getProductListUseCase: usecase);

    blocTest<ProductListBloc, ProductListState>(
      '',
      build: () => bloc,
      act: (bloc) => bloc.add(GetProductListEvent()),
      expect: () =>
      [
        LoadingState(),
        NoDataState(),
      ],
    );
    tearDown((){
      bloc.close();
    });
  });

  group("test get product list. has error", () {
    MockProductRemoteDataSource dataSource = MockProductRemoteDataSource(hasError: true);
    MockNetworkInfoImpl network = MockNetworkInfoImpl(true);

    ProductRepositoryImpl repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: dataSource, networkInfo: network);

    GetProductListUseCase usecase = GetProductListUseCase(repositoryImpl);

    ProductListBloc bloc = ProductListBloc(getProductListUseCase: usecase);

    blocTest<ProductListBloc, ProductListState>(
      '',
      build: () => bloc,
      act: (bloc) => bloc.add(GetProductListEvent()),
      expect: () =>
      [
        LoadingState(),
        ErrorState(),
      ],
    );
    
    tearDown((){
      bloc.close();
    });
  });
}
