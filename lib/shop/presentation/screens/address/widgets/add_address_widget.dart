import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AddAddressWidget extends HookWidget {
  AddAddressWidget({required this.addressCubit, Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AddressCubit addressCubit;

  @override
  Widget build(BuildContext context) {
    final nameTextEditingController = useTextEditingController();
    final cityTextEditingController = useTextEditingController();
    final regionTextEditingController = useTextEditingController();
    final detailsTextEditingController = useTextEditingController();
    final notesTextEditingController = useTextEditingController();

    final cityFocusNode = useFocusNode();
    final regionFocusNode = useFocusNode();
    final detailsFocusNode = useFocusNode();
    final notesFocusNode = useFocusNode();

    ValueNotifier<LocationInfo?> addressData = useState(null);

    void setLatLng(LocationInfo? value) {
      addressData.value = value;
    }

    return BlocProvider.value(
      value: addressCubit,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(
              20.0,
            ),
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: CustomTextButton(
                    label: 'Save',
                    onPressed: () => _onAddPressed(
                      context,
                      AddAddressRequestEntity(
                        name: nameTextEditingController.text,
                        city: cityTextEditingController.text,
                        region: regionTextEditingController.text,
                        details: detailsTextEditingController.text,
                        notes: notesTextEditingController.text,
                      ),
                      addressData.value?.latLng,
                    ),
                    isLoading: addressCubit.state is AddAddressLoadingState,
                  ),
                ),
                DefaultTextFormField(
                  textController: nameTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.home,
                  label: R.strings.addressNameLabel,
                  onValidateFunction: (value) => value?.validateIsEmpty(),
                  onFieldSubmittedFunction: (_) =>
                      FocusScope.of(context).requestFocus(cityFocusNode),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DefaultTextFormField(
                  textController: cityTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.location_city_outlined,
                  label: R.strings.addressCityLabel,
                  onValidateFunction: (value) => value?.validateIsEmpty(),
                  focusNode: cityFocusNode,
                  onFieldSubmittedFunction: (_) =>
                      FocusScope.of(context).requestFocus(regionFocusNode),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DefaultTextFormField(
                  textController: regionTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.location_on_outlined,
                  label: R.strings.addressRegionLabel,
                  onValidateFunction: (value) => value?.validateIsEmpty(),
                  focusNode: regionFocusNode,
                  onFieldSubmittedFunction: (_) =>
                      FocusScope.of(context).requestFocus(detailsFocusNode),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DefaultTextFormField(
                  textController: detailsTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.location_on_sharp,
                  label: R.strings.addressDetailsLabel,
                  onValidateFunction: (value) => value?.validateIsEmpty(),
                  focusNode: detailsFocusNode,
                  onFieldSubmittedFunction: (_) =>
                      FocusScope.of(context).requestFocus(notesFocusNode),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DefaultTextFormField(
                  textController: notesTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.notes,
                  label: R.strings.addressNotesLabel,
                  onValidateFunction: (value) => value?.validateIsEmpty(),
                  focusNode: notesFocusNode,
                  onFieldSubmittedFunction: (_) =>
                      FocusScope.of(context).unfocus(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.map_outlined,
                    color: Colors.green,
                  ),
                  title: Text(
                    addressData.value != null
                        ? ' ${addressData.value?.address?.street}'
                        : 'set location on maps',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MapsWidget(
                          onLocationSaved: (value) => setLatLng(value),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onAddPressed(
    BuildContext context,
    AddAddressRequestEntity addedAddress,
    LatLng? data,
  ) {
    if (_formKey.currentState?.validate() == true && data != null) {
      _formKey.currentState?.save();
      FocusScope.of(context).unfocus();
      addedAddress.setLatLng(data);
      addressCubit.addNewAddress(
        addressData: addedAddress,
      );
    }
  }
}
