import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/address/widgets/add_address_widget.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AddressContent extends HookWidget {
  const AddressContent({required this.onLongPressed, Key? key})
      : super(key: key);
  final Function(AddressResponseEntity? chosenAddress) onLongPressed;

  @override
  Widget build(BuildContext context) {
    final addressState = context.watch<AddressCubit>().state;
    final addressCubit = context.read<AddressCubit>();
    final userAddressesList = addressCubit.userAddresses;
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      resizeToAvoidBottomInset: false, // Set this to false
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return StateHandlingWidget(
            isLoading: (addressState is GetAddressLoadingState &&
                    addressCubit.userAddresses.isEmpty) ||
                addressState is AddAddressLoadingState,
            hasError: addressState is GetAddressErrorState &&
                addressCubit.userAddresses.isEmpty,
            onRetryButtonPressed: () => _onRetryButtonPressed(addressCubit),
            successWidget: PaginatedList(
              isLoading: addressState is GetAddressLoadingState,
              isEmpty: userAddressesList.isEmpty,
              controller: scrollController,
              onScrollCallBack: (context) => _onScroll(addressCubit),
              listEmptyTitle: 'No Address saved, Click + to add',
              listEmptyIcon: Icons.location_on,
              listChild: CustomAnimatedList(
                products: userAddressesList,
                itemBuilder: (context, index) {
                  final address = userAddressesList[index];
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          40.0.r,
                        ),
                        topRight: Radius.circular(
                          40.0.r,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      iconColor: Colors.deepOrange,
                      onTap: () {},
                      onLongPress: () {
                        onLongPressed.call(userAddressesList[index]);
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20.0.r,
                        ),
                      ),
                      title: Text(
                        address.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Long press to choose',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      leading: const Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                    ),
                  );
                },
                controller: scrollController,
                animationType: AnimationEnum.slide,
              ),
              onEmptyReloadButtonPressed: () =>
                  _onRetryButtonPressed(addressCubit),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => AddAddressWidget(
            addressCubit: addressCubit,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                30.0.r,
              ),
              topLeft: Radius.circular(
                30.0.r,
              ),
            ),
          ),
          isScrollControlled: true,
          useRootNavigator: true, // Set useRootNavigator to true
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _onScroll(AddressCubit addressCubit) {
    final page = addressCubit.currentPage + 1;
    addressCubit.getUserAddresses(page: page);
  }

  void _onRetryButtonPressed(AddressCubit addressCubit) {
    addressCubit.getUserAddresses(
      page: addressCubit.currentPage,
    );
  }
}
