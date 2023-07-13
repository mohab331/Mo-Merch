// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
//     as di;
// import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
// import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
// import 'package:shop_app_clean_architecture/core/widgets/custom_list_tile.dart';
// import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_cubit.dart';
// import 'package:shop_app_clean_architecture/shop/presentation/cubit/check_out/check_out_cubit.dart';
// import 'package:shop_app_clean_architecture/shop/presentation/screens/add_address_screen.dart';
// import 'package:shop_app_clean_architecture/shop/presentation/screens/choose_address_screen.dart';
//
// class AddressScreen extends StatelessWidget {
//   const AddressScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomListTile(
//             title: AppStrings.savedAddress,
//             leadingIcon: Icons.home,
//             onListTileTapFunction: () {
//               AppFunctions.navigateTo(
//                   context: context,
//                   screen: MultiBlocProvider(
//                     providers: [
//                       BlocProvider(
//                           create: (context) =>
//                               di.sl<AddressCubit>()..getUserAddresses(context)),
//                       BlocProvider.value(value: CheckOutCubit.get(context)),
//                     ],
//                     child: const ChooseAddressScreen(),
//                   ));
//             },
//             trailingIcon: Icons.arrow_forward_ios_rounded),
//         CustomListTile(
//           title: AppStrings.newAddress,
//           leadingIcon: Icons.new_label,
//           onListTileTapFunction: () {
//             AppFunctions.navigateTo(
//                 context: context,
//                 screen: MultiBlocProvider(
//                   providers: [
//                     BlocProvider(create: (context) => di.sl<AddressCubit>()),
//                     BlocProvider.value(value: CheckOutCubit.get(context)),
//                   ],
//                   child: AddAddressScreen(),
//                 ));
//           },
//           trailingIcon: Icons.arrow_forward_ios_rounded,
//         )
//       ],
//     );
//   }
// }
