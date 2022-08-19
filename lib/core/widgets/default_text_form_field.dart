import 'package:flutter/material.dart';


class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    Key? key,
    required this.textController,
    required this.textInputType,
    required this.prefixIcon,
    required this.label,
    this.suffixIcon,
    this.maxLength,
    this.focusNode,
    required this.onValidateFunction,
    this.onFieldSubmittedFunction,
    this.onChanged,
    this.isPasswordTextFormField = false,
  }) : super(key: key);
  final TextEditingController textController;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final int? maxLength;
  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Function onValidateFunction;
  final Function? onFieldSubmittedFunction;
  final Function? onChanged;
  final bool isPasswordTextFormField;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool obscurePassword = true;
  IconData? iconData = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged != null
          ? (String? value) {
              widget.onChanged!(value);
            }
          : null,
      controller: widget.textController,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
        suffixIcon: widget.isPasswordTextFormField && widget.suffixIcon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    iconData = widget.suffixIcon;
                    obscurePassword = !obscurePassword;
                    if (!obscurePassword) {
                      iconData = Icons.visibility;
                    } else {
                      iconData = widget.suffixIcon;
                    }
                  });
                },
                icon: Icon(iconData),
              )
            : null,
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      keyboardType: widget.textInputType,
      obscureText:
          widget.isPasswordTextFormField && obscurePassword ? true : false,
      textInputAction: TextInputAction.done,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onFieldSubmittedFunction != null
          ? (_) => widget.onFieldSubmittedFunction!(context)
          : null,
      validator: (String? value) => widget.onValidateFunction(value),
    );
  }
}
