import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/shop/presentation/widgets/row_icon_item_builder.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    Key? key,
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
  }) : super(key: key);
  final String name;
  final String city;
  final String region;
  final String details;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowIconItemBuilder(
          text: city,
          icon: Icons.home,
        ),
         SizedBox(
          height: context.height * 0.015,
        ),
        RowIconItemBuilder(
          text: name,
          icon: Icons.location_on_outlined,
        ),
        SizedBox(
          height: context.height * 0.015,
        ),
        RowIconItemBuilder(
          text: region,
          icon: Icons.location_city_outlined,
        ),
        SizedBox(
          height: context.height * 0.015,
        ),
        RowIconItemBuilder(
          text: details,
          icon: Icons.details,
        ),
        SizedBox(
          height: context.height * 0.015,
        ),
        RowIconItemBuilder(
          text: notes,
          icon: Icons.notes,
        ),
      ],
    );
  }
}
