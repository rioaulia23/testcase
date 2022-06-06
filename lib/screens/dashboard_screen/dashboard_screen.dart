import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testcase/screens/dashboard_screen/bloc/dashboard_bloc.dart';


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  ScrollController? scrollController = ScrollController();
  DashboardBloc _dashboardBloc = DashboardBloc();
  bool isLove = false;
  bool isLoading = false;
  bool isLoad = false;

  @override
  void initState() {
    _dashboardBloc.add(GetDashboardEvent());
    scrollController!.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController!.position.pixels ==
            scrollController!.position.maxScrollExtent &&
        _dashboardBloc.productModel.products!.length < 100) {
      setState(() {
        isLoading = true;
      });
      _dashboardBloc.add(LoadMoreEvent());
    }
  }

  int? countItem(){
    if(_dashboardBloc.productModel != null){
      if(_dashboardBloc.productModel.products != null){
        return _dashboardBloc.productModel.products!.length;
      }else{
        return 0;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _dashboardBloc,
        builder: (context, state) {
          return BlocListener(
            bloc: _dashboardBloc,
            listener: (context, state) {
              if(state is SuccesGetDashboard){
                isLoading = false;
                isLoad = true;
              }else{
                isLoad = false;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Product'),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color:const Color.fromRGBO(114, 142, 167, 0.5),
                child: isLoad ? Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: GridView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(30),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                            itemCount: countItem(),
                            itemBuilder: (BuildContext ctx, index) {
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                shape:const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0))),
                                child: Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: _dashboardBloc
                                          .productModel.products![index].thumbnail
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(0.3),
                                      width: 150,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text(
                                        _dashboardBloc
                                            .productModel.products![index].brand
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 5,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '\$${_dashboardBloc.productModel.products![index].priceAfterDiscount.toString()}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            child: Text(
                                              '\$${_dashboardBloc.productModel.products![index].price.toString()}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                  decorationColor: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if(_dashboardBloc.productModel.products![index].isLove == false){
                                                _dashboardBloc.productModel.products![index].isLove = true;
                                              }else{
                                                _dashboardBloc.productModel.products![index].isLove = false;
                                              }
                                            });
                                          },
                                          icon: !_dashboardBloc.productModel.products![index].isLove!
                                              ? const Icon(
                                                  Icons.favorite_border_outlined,
                                                  color: Colors.pinkAccent,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.pinkAccent,
                                                )),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 5,
                                      child: RatingBar.builder(
                                        initialRating: _dashboardBloc
                                            .productModel.products![index].rating!
                                            .toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 12,
                                        glow: true,
                                        ignoreGestures: true,
                                        unratedColor: Colors.black,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 70,
                                        height: 18,
                                        margin: const EdgeInsets.only(top: 14),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color:
                                              const Color.fromRGBO(240, 118, 66, 1),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(16),
                                              bottomRight: Radius.circular(16)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(0.1),
                                              spreadRadius: 10,
                                              blurRadius: 10,
                                              offset: const Offset(0, 1),
                                            )
                                          ],
                                        ),
                                        child: Text(
                                          'PROMO ${_dashboardBloc.productModel.products![index].discountPercentage!.round()}%',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    isLoading
                        ? const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 30),
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 30,
                          height: 30,
                        ))
                        : Container()
                  ],
                ) : Center(child: CircularProgressIndicator())
              ),
            ),
          );
        });
  }
}
