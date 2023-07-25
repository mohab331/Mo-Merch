import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

// AddressDetails Widget
class OrderAddressPaymentDetails extends StatelessWidget {
  const OrderAddressPaymentDetails({
    required this.addressData,
    required this.paymentMethod,
    super.key,
  });

  final AddressResponseEntity addressData;
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(onTap: ()=>_handleOnAddressTapped(context),child: DeliveryAddressSection(addressData: addressData)),
        SizedBox(height: 10.h),
        const Divider(color: Colors.grey, thickness: 1,),
        SizedBox(height: 10.h),
        PaymentDetailsWidget(paymentMethod: paymentMethod),
      ],
    );
  }
  void _handleOnAddressTapped(BuildContext context) {
    if (addressData.longitude != 0.0 && addressData.latitude != 0.0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MapsScreen(
          initialLatitude: addressData.latitude,
          initialLongitude: addressData.longitude,
        ),
      ));
    }
  }
}


class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({
    required this.addressData,
    super.key,
  });

  final AddressResponseEntity addressData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 25,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10.w,
        ),
        AddressDetailsSection(
         address: addressData,
        ),
      ],
    );
  }


}

class AddressDetailsSection extends StatelessWidget {
  const AddressDetailsSection({
    required this.address,
    super.key,
  });

  final AddressResponseEntity address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: 300.w,
          child: Text(
            '${address.name} - ${address.details} - ${address.city} - ${address.region} - ${address.notes}',
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        if(address.longitude!=0.0 && address.latitude != 0.0)
        const Text('Tap to view on map',style: TextStyle(color: Colors.grey),),
      ],
    );
  }
}
