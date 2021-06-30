import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/common/app_colors.dart';
import 'package:presentation/common/navigation/routes.dart';
import 'package:presentation/common/navigation/screen_navigation_service.dart';
import 'package:presentation/common/widget/my_app_bar.dart';
import 'package:presentation/common/widget/loading_indicator.dart';
import 'package:presentation/di/injection_container.dart';
import 'package:presentation/features/product_detail/bloc/product_detail_event.dart';
import 'bloc/product_detail_bloc.dart';
import 'bloc/product_detail_state.dart';
import 'package:presentation/common/widget/lost_network_widget.dart';
import 'package:presentation/common/widget/error_state_widget.dart';
import 'package:presentation/common/widget/empty_state_widget.dart';
import 'product_detail_screen_arg.dart';
import 'package:presentation/common/app_images.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({this.args});

  ProductDetailScreenArg? args;

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  var bloc = sl<ProductDetailBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => bloc
          ..add(InitialState(data: widget.args?.data))
          ..add(GetProductDetailEvent()),
        child: BlocListener<ProductDetailBloc, ProductDetailState>(
            listener: (context, state) {},
            child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
              return Scaffold(
                appBar: MyAppBar(
                  title: "Detail",
                  canBack: true,
                ),
                body: Container(
                    alignment: Alignment.center,
                    color: AppColors.white,
                    child: Stack(
                      children: [
                        ProductDetailBody(index: widget.args?.index ?? 0)
                      ],
                    )),
              );
            })));
  }
}

class ProductDetailBody extends StatelessWidget {
  ProductDetailBody({required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProductDetailBloc>(context);
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return LoadingIndicator();
      } else if (state is NoDataState) {
        return EmptyStateWidget(
          onTap: () {
            bloc.add(GetProductDetailEvent());
          },
        );
      } else if (state is NetworkErrorState) {
        return LostNetworkWidget(
          onTap: () {
            bloc.add(GetProductDetailEvent());
          },
        );
      } else if (state is ErrorState) {
        return ErrorStateWidget(onTap: () {
          bloc.add(GetProductDetailEvent());
        });
      } else {
        return ProductDetailContent(
          index: index,
        );
      }
    });
  }
}

class ProductDetailContent extends StatelessWidget {
  ProductDetailContent({required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(12),
                height: 241,
                child: Stack(
                  children: [
                    Hero(
                        tag: "image${index}",
                        child: Container(
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: state.data?.image ?? "",
                              placeholder: (context, url) => Image.asset(
                                  AppImages.ic_placeholder,
                                  package: AppImages.package),
                              errorWidget: (context, url, error) => Image.asset(
                                  AppImages.ic_placeholder,
                                  package: AppImages.package),
                            ))),
                    (state.data?.isNewProduct ?? false)
                        ? Positioned(
                            right: 0,
                            child: Text(
                              "New",
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ))
                        : Container()
                  ],
                )),
            SizedBox(height: 32),
            Hero(
                tag: "title${index}",
                child: Text(
                  state.data?.title ?? "",
                  style: TextStyle(color: AppColors.black, fontSize: 22),
                )),
            SizedBox(
              height: 8,
            ),
            Hero(
                tag: "price${index}",
                child: Container(
                    child: Text(
                  state.data?.price.toStringAsFixed(2) ?? "",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ))),
            SizedBox(
              height: 16,
            ),
            Text(
              state.data?.content ?? "",
              style: TextStyle(color: AppColors.text_gray, fontSize: 18),
            )
          ],
        ),
      );
    });
  }
}
