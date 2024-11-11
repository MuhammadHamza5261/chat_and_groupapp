import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/app_colors.dart';

class CustomInputFieldTwo extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final List<TextInputFormatter>? textInputFormatters;
  final TextStyle? hintStyle; // Added hintStyle parameter

  const CustomInputFieldTwo({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.textInputFormatters,
    this.hintStyle, // Initialized hintStyle parameter
  }) : super(key: key);

  @override
  _CustomInputFieldTwoState createState() => _CustomInputFieldTwoState();
}

class _CustomInputFieldTwoState extends State<CustomInputFieldTwo> {
  late bool _isObscure;

  @override
  void initState() {
    _isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.textInputFormatters ?? [],
      readOnly: widget.readOnly,
      cursorColor: Colors.black54,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      validator: widget.validator,
      style: const TextStyle(
        color: Colors.black54,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white60,
        counterText: "",
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          child: Container(
            width: 1.0,
            height: 1.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.shade200
            ),
            child: Center(
              child: Icon(
                widget.prefixIcon,
                size: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorToastColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorToastColor,width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        )
            : null,
        labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black38,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
