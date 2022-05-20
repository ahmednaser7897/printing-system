// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:print_system/view/components/app_colors.dart';
import 'package:print_system/view/components/app_text_styles.dart';

class DefaultTextFormField extends StatefulWidget {
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIconPressed;
  final Function? onPressSuffixIcon;
  final Function? onFilledSubmit;
  final Function? onChange;
  final Function validator;
  final double? borderRadius;
  const DefaultTextFormField({
    Key? key,
    required this.isPassword,
    required this.textInputType,
    required this.controller,
    required this.validator,
    this.labelText,
    this.hintText,
    this.onFilledSubmit,
    this.onChange,
    this.borderRadius,
    this.onPressSuffixIcon,
    this.suffixIcon,
    this.suffixIconPressed,
    this.prefixIcon,
  }) : super(key: key);
  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  FocusNode? _focusNode;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      style: AppTextStyles.bodyText(),
      obscureText: widget.isPassword && hidePassword,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      onFieldSubmitted: (String? value) {
        if (widget.onFilledSubmit != null) {
          widget.onFilledSubmit!();
        }
      },
      onChanged: (String? value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onTap: () {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator(value);
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100, // const Color(0xffFFFAF9),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRadius ?? 10.0,
            ),
          ),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: (_focusNode!.hasFocus)
                ? AppColors.primaryColor
                : Colors.grey.shade600),
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword ? widget.suffixIcon : widget.suffixIconPressed,
                  color: _focusNode!.hasFocus
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              )
            : widget.suffixIcon != null
                ? IconButton(
                    onPressed: () {
                      widget.onPressSuffixIcon!();
                    },
                    icon: Icon(widget.suffixIcon,
                        color: _focusNode!.hasFocus
                            ? AppColors.primaryColor
                            : Colors.grey),
                  )
                : null,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: _focusNode!.hasFocus ? AppColors.primaryColor : Colors.grey,
        ),
      ),
    );
  }
}
