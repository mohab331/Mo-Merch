import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DefaultTextFormField extends HookWidget {
  const DefaultTextFormField({
    required this.textController,
    required this.textInputType,
    required this.prefixIcon,
    required this.label,
    required this.onValidateFunction,
    this.suffixIcon,
    this.maxLength,
    this.focusNode,
    this.onFieldSubmittedFunction,
    this.onChanged,
    this.isPasswordTextFormField = false,
    Key? key,
  }) : super(key: key);
  final TextEditingController textController;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final int? maxLength;
  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?) onValidateFunction;
  final Function(String)? onFieldSubmittedFunction;
  final Function(String?)? onChanged;
  final bool isPasswordTextFormField;

  @override
  Widget build(BuildContext context) {
    final obscurePassword = useState(true);
    final iconData = useState(Icons.visibility_off);
    return TextFormField(
      onChanged: onChanged,
      controller: textController,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: isPasswordTextFormField
            ? IconButton(
                onPressed: () {
                  iconData.value = Icons.visibility_off;
                  obscurePassword.value = !obscurePassword.value;
                  if (!obscurePassword.value) {
                    iconData.value = Icons.visibility;
                  } else {
                    iconData.value = Icons.visibility_off;
                  }
                },
                icon: Icon(
                  iconData.value,
                ),
              )
            : null,
      ),
      keyboardType: textInputType,
      obscureText: (isPasswordTextFormField && obscurePassword.value),
      textInputAction: TextInputAction.done,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmittedFunction,
      validator: onValidateFunction,
    );
  }
}
