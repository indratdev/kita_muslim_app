import 'package:flutter/material.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../utils/formaters.dart';
import '../../utils/validator.dart';

class CustomTextfieldWidget extends StatefulWidget {
  TextEditingController? controller;
  IconData? icon;
  String? hintText;
  Function()? onTap;
  Function(String)? onChanges;
  Icon? suffixIcon;
  int? maxLines;
  String? titleTextfield;
  TextInputType keyboardType;
  bool obscureText;
  TypeTextField typeTextField;
  bool readOnly;
  bool isUppercase;
  bool useValidator;
  EdgeInsetsGeometry customPadding;
  String label;
  String? initialValue;

  CustomTextfieldWidget({
    super.key,
    this.controller,
    this.onTap,
    this.suffixIcon,
    this.icon,
    this.hintText,
    this.maxLines = 1,
    this.titleTextfield,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.typeTextField = TypeTextField.general,
    this.isUppercase = false,
    this.onChanges,
    this.useValidator = true,
    this.customPadding = const EdgeInsets.only(bottom: 8.0),
    this.label = "",
    this.initialValue,
  });

  @override
  State<CustomTextfieldWidget> createState() => _CustomTextfieldWidgetState();
}

class _CustomTextfieldWidgetState extends State<CustomTextfieldWidget> {
  Validator validator = Validator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.customPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.titleTextfield == null)
              ? const SizedBox()
              : Text(widget.titleTextfield!),
          const SizedBox(height: 8),
          TextFormField(
            onChanged: widget.onChanges,
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            controller: widget.controller,
            onTap: widget.onTap,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            validator: (widget.useValidator)
                ? (value) =>
                    validator.typeValidator(widget.typeTextField, value)
                : null,
            inputFormatters:
                (widget.isUppercase) ? [UpperCaseTextFormatter()] : [],
            decoration: InputDecoration(
              labelText: widget.label,
              // labelText: ,
              filled: widget.readOnly,
              suffixIcon: widget.suffixIcon,
              fillColor: Colors.grey.shade300,
              prefixIcon: (widget.icon == null)
                  ? null
                  : Icon(
                      widget.icon,
                      color: Constants.colorBlack,
                    ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.colorBlack,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.colorBlack,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              contentPadding: const EdgeInsets.all(10),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Constants.colorBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
