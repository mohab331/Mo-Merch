import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/loading_data_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/check_out/check_out_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/widgets/address_item.dart';
import 'package:shop_app_clean_architecture/shop/presentation/widgets/card_item_builder.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({Key? key ,}) : super(key: key);

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  bool _isLoading = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      if (currentScroll == maxScroll && !_isLoading) {}
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AddressCubit, AddressStates>(
        listener: (context, state) {
          if (state is GetAddressErrorState || state is GetAddressSuccessState) {
            _isLoading = false;
          } else if (state is GetAddressLoadingState &&
              AddressCubit.get(context).hasMoreAddressData == true &&
              AddressCubit.get(context).userAddressList.isNotEmpty) {
            _isLoading = true;
          }
        },
        buildWhen: (previousState, currentState) {
          return previousState != currentState &&
              (currentState is GetAddressErrorState ||
                  currentState is GetAddressSuccessState ||
                  currentState is GetAddressLoadingState);
        },
        builder: (context, state) {
          if (state is GetAddressLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAddressErrorState &&
              AddressCubit.get(context).userAddressList.isEmpty) {
            return NetworkErrorWidget(
                onReloadButtonPressed: (BuildContext context) {
              AddressCubit.get(context).currentAddressPage = 1;
              AddressCubit.get(context).getUserAddresses(context);
            });
          } else if (state is GetAddressSuccessState &&
              AddressCubit.get(context).userAddressList.isEmpty) {
            return const EmptyWidget(
                iconData: Icons.home, title: AppStrings.emptyAddress);
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          CheckOutCubit.get(context).addressId = AddressCubit.get(context)
                              .userAddressList
                              .elementAt(index)
                              .id;
                          CheckOutCubit.get(context).toggleIndex(currentIndex: 2,);
                          Navigator.of(context).pop();
                        },
                        child: CardItemBuilder(
                          child: AddressItem(
                              name: AddressCubit.get(context)
                                  .userAddressList
                                  .elementAt(index)
                                  .name,
                              city: AddressCubit.get(context)
                                  .userAddressList
                                  .elementAt(index)
                                  .city,
                              region: AddressCubit.get(context)
                                  .userAddressList
                                  .elementAt(index)
                                  .region,
                              details: AddressCubit.get(context)
                                  .userAddressList
                                  .elementAt(index)
                                  .details,
                              notes: AddressCubit.get(context)
                                  .userAddressList
                                  .elementAt(index)
                                  .notes),
                        ),
                      );
                    },
                    itemCount: AddressCubit.get(context).userAddressList.length,
                  ),
                ),
                if (_isLoading) const LoadingDataWidgetBuilder(),
                if (state is GetAddressErrorState &&
                    AddressCubit.get(context).userAddressList.isNotEmpty)
                  NetworkErrorWidget(
                      onReloadButtonPressed: (BuildContext context) {
                    AddressCubit.get(context).getUserAddresses(context);
                  }),
              ],
            );
          }
        },
      ),
    );
  }
}
