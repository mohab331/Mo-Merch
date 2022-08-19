import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_states.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/default_text_form_field.dart';
import '../cubit/check_out/check_out_cubit.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController regionTextEditingController = TextEditingController();
  TextEditingController detailsTextEditingController = TextEditingController();
  TextEditingController notesTextEditingController = TextEditingController();

  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _regionFocusNode = FocusNode();
  final FocusNode _detailsFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();

  final GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextFormField(
                  textController: nameTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.home,
                  label: AppStrings.addressNameLabel,
                  onValidateFunction: AppFunctions.validateEmpty,
                  onFieldSubmittedFunction: (BuildContext context) {
                    FocusScope.of(context).requestFocus(_cityFocusNode);
                  },
                ),
                SizedBox(
                  height: context.height * 0.015,
                ),
                DefaultTextFormField(
                  textController: cityTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.location_city_outlined,
                  label: AppStrings.addressCityLabel,
                  onValidateFunction: AppFunctions.validateEmpty,
                  focusNode: _cityFocusNode,
                  onFieldSubmittedFunction: (BuildContext context) {
                    FocusScope.of(context).requestFocus(_regionFocusNode);
                  },
                ),
                SizedBox(
                  height: context.height * 0.015,
                ),
                DefaultTextFormField(
                  textController: regionTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.location_on_outlined,
                  label: AppStrings.addressRegionLabel,
                  onValidateFunction: AppFunctions.validateEmpty,
                  focusNode: _regionFocusNode,
                  onFieldSubmittedFunction: (BuildContext context) {
                    FocusScope.of(context).requestFocus(_detailsFocusNode);
                  },
                ),
                SizedBox(
                  height: context.height * 0.015,
                ),
                DefaultTextFormField(
                  textController: detailsTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.location_on_sharp,
                  label: AppStrings.addressDetailsLabel,
                  onValidateFunction: AppFunctions.validateEmpty,
                  focusNode: _detailsFocusNode,
                  onFieldSubmittedFunction: (BuildContext context) {
                    FocusScope.of(context).requestFocus(_notesFocusNode);
                  },
                ),
                SizedBox(
                  height: context.height * 0.015,
                ),
                DefaultTextFormField(
                  textController: notesTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.notes,
                  label: AppStrings.addressNotesLabel,
                  onValidateFunction: AppFunctions.validateEmpty,
                  focusNode: _notesFocusNode,
                  onFieldSubmittedFunction: (BuildContext context) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                  height: context.height * 0.015,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<AddressCubit, AddressStates>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState &&
              (currentState is AddAddressLoadingState ||
                  currentState is AddAddressSuccessState ||
                  currentState is AddAddressErrorState);
        },
        listener: (context, state) {
          if (state is AddAddressErrorState) {
            AppFunctions.showToast(
                message: state.errorMessage, color: AppColors.errorColor);
          } else if (state is AddAddressSuccessState) {
            AppFunctions.showToast(
                message: state.message, color: AppColors.successColor);
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state is AddAddressLoadingState
                ? null
                : () {
                    if (globalKey.currentState!.validate()) {
                      globalKey.currentState!.save();
                      FocusScope.of(context).unfocus();
                      AddressCubit.get(context).addNewAddress(context, data: {
                        'name': nameTextEditingController.text,
                        'city': cityTextEditingController.text,
                        'region': regionTextEditingController.text,
                        'details': detailsTextEditingController.text,
                        'notes': notesTextEditingController.text,
                        'latitude': 0.0,
                        'longitude': 0.0,
                      });
                      CheckOutCubit.get(context).toggleIndex(currentIndex: 2,);
                      Navigator.of(context).pop();
                    }
                  },
            child: const Icon(Icons.arrow_forward_ios_rounded),
          );
        },
      ),
    );
  }
}
