import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/common/app_colors.dart';
import 'package:presentation/common/navigation/routes.dart';
import 'package:presentation/common/navigation/screen_navigation_service.dart';
import 'package:presentation/common/widget/loading_indicator.dart';
import 'package:presentation/common/widget/my_app_bar.dart';
import 'package:domain/model/product_model.dart';
import 'package:presentation/di/injection_container.dart';
import 'package:presentation/features/product_detail/product_detail_screen.dart';
import 'package:presentation/features/product_list/bloc/product_list_event.dart';
import 'package:presentation/common/app_images.dart';
import 'bloc/product_list_bloc.dart';
import 'bloc/product_list_state.dart';
import 'package:presentation/common/widget/lost_network_widget.dart';
import 'package:presentation/common/widget/error_state_widget.dart';
import 'package:presentation/common/widget/empty_state_widget.dart';
import 'package:presentation/features/product_detail/product_detail_screen_arg.dart';

class ProductListScreen extends StatefulWidget {
  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  var bloc = sl<ProductListBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => bloc..add(GetProductListEvent()),
        child: BlocListener<ProductListBloc, ProductListState>(
            listener: (context, state) {},
            child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
              return Scaffold(
                appBar: MyAppBar(
                  title: "Product",
                ),
                body: Container(
                  alignment: Alignment.center,
                  color: AppColors.background,
                  child: ProductListBody(),
                ),
              );
            })));
  }
}

class ProductListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProductListBloc>(context);
    return BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return LoadingIndicator();
      } else if (state is NoDataState) {
        return EmptyStateWidget(
          onTap: () {
            bloc.add(GetProductListEvent());
          },
        );
      } else if (state is NetworkErrorState) {
        return LostNetworkWidget(
          onTap: () {
            bloc.add(GetProductListEvent());
          },
        );
      } else if (state is ErrorState) {
        return ErrorStateWidget(onTap: () {
          bloc.add(GetProductListEvent());
        });
      } else {
        return ProductDataListBody();
      }
    });
  }
}

class ProductDataListBody extends StatelessWidget {
  void onTapListItem(BuildContext context, ProductModel data, int index) {
    var arg = ProductDetailScreenArg(data: data, index: index);
    GetIt.I<ScreenNavigationService>().navigateTo(Routes.product_detail,
        arguments: arg, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProductListBloc>(context);

    return BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
      List<Widget> _buildGrid() {
        List<Widget> list = [];
        for (int i = 0; i < state.list.length; i++) {
          list.add(ProductItemWidget(
            data: state.list[i],
            index: i,
            onTap: (data) {
              onTapListItem(context, state.list[i], i);
            },
          ));
        }
        return list;
      }

      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start picking your treats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16),
              Flexible(
                  child: Container(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(GetProductListEvent());
                          },
                          child: GridView.count(
                            childAspectRatio: 163 / 229,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: List.generate(state.list.length, (index) {
                              return ProductItemWidget(
                                data: state.list[index],
                                index: index,
                                onTap: (data) {
                                  onTapListItem(context, data, index);
                                },
                              );
                            }),
                          ))))
            ],
          ));
    });
  }
}

class ProductItemWidget extends StatelessWidget {
  ProductItemWidget({required this.data, required this.index, this.onTap});

  ProductModel data;
  Function(ProductModel)? onTap;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(9)),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: "image${index}",
                  child:AspectRatio(
                    aspectRatio: 1.2,
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      width: 200,
                      height: 125,
                      child: CachedNetworkImage(
                        imageUrl: data.image,
                        placeholder: (context, url) => Image.asset(
                            AppImages.ic_placeholder,
                            package: AppImages.package),
                        errorWidget: (context, url, error) => Image.asset(
                            AppImages.ic_placeholder,
                            package: AppImages.package),
                      )),
                )),
                (data.isNewProduct)
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Text(
                          "New",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ))
                    : Container()
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                        tag: "title${index}",
                        child: Container(
                            child: Text(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.none,
                          ),
                        ))))),
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 8),
                    child: Hero(
                      tag: "price${index}",
                      child: Text(
                        data.price.toStringAsFixed(2),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColors.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    )))
          ],
        ),
      ),
      onTap: () {
        if (onTap != null) onTap!(data);
      },
    );
  }
}
