
import 'package:second_brain/src/utils/app_exports.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enableSuggestions;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final int? maxLength;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final bool isMandatory;
  final bool autofocus;

  const CustomTextField({
    Key? key,
    this.label,
    this.inputFormatters,
    this.hintText,
    this.icon,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.enableSuggestions = true,
    this.controller,
    this.keyboardType,
    this.autofillHints,
    this.minLines,
    this.maxLines,
    this.enabled,
    this.readOnly = false,
    this.onTap,
    this.textInputAction,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.focusNode,
    this.isDense,
    this.maxLength,
    this.isMandatory = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      maxLength: maxLength,
      autofocus: autofocus,
      // autofocus: true,
      onTap: onTap,
      readOnly: readOnly,
      obscuringCharacter: '*',
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      inputFormatters: inputFormatters,
      enableSuggestions: enableSuggestions,
      autofillHints: autofillHints,
      minLines: minLines,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines ?? 1,
      // autocorrect: false,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
              text: "${label ?? ""}${hintText ?? ""}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              children: [
                if (isMandatory)
                  const TextSpan(
                      text: ' *',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red))
              ]),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18 ,horizontal: 17),
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        // fillColor: context.theme.disabledColor.withOpacity(0.1),
        // filled: true,
        // hintText: hintText,
        isDense: isDense ?? true,
        // labelText: label,
        // labelStyle:
        //     const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        suffixIcon: suffixIcon,
        // prefixIcon: Icon(icon, color: context.theme.colorScheme.secondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class CReadingOrderTraversalPolicy extends OrderedTraversalPolicy {

  @override
  Iterable<FocusNode> sortDescendants(
      Iterable<FocusNode> descendants, FocusNode currentNode) {

    return descendants;
  }
}
