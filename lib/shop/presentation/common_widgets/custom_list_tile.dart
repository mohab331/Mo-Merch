import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
        required this.title,
        required this.leadingIcon,
        required this.onListTileTapFunction,
        this.trailingIcon})
      : super(key: key);
  final String title;
  final IconData leadingIcon;
  final IconData? trailingIcon;
  final Function onListTileTapFunction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15.0,),
      leading: Icon(
        leadingIcon,
        size: 30,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () {
        onListTileTapFunction();
      },
      trailing: trailingIcon != null
          ?  CircleAvatar(
        child: Icon(
          trailingIcon,
        ),
      )
          : null,
    );
  }
}
