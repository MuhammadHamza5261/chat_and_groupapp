import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../values/colors.dart';

class CustomTextField extends StatefulWidget {
  final VoidCallback onTap ;
  final TextEditingController controller ;
  final dynamic validation ;
  final Function(String?)? onChange ;
  final Widget? suffixIcon ;
  final String? hintText;
  final Widget? prefixIcon;
  final bool? isVisibilityIconShow;
  final bool? obscureText ;
  final String? labelText ;
  final int? borderRadius ;
  final bool isActive;
  final bool? isFocus;
  FocusNode? focusNode;
  CustomTextField({Key? key, required this.controller, this.validation, this.onChange, this.suffixIcon, this.hintText, this.prefixIcon, this.isVisibilityIconShow, this.obscureText, this.labelText, this.borderRadius, required this.isActive, required this.onTap,this.focusNode,this.isFocus}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }
  @override
  Widget build(BuildContext context) {
    final color = widget.isActive ? AppColors.blue1 : Colors.deepOrange ;
    final darkColor = widget.isActive ? Colors.deepOrange : AppColors.black4 ;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),

      decoration: BoxDecoration(
          color: color,
          border:_isFocused ? Border.all( color:AppColors.blue7,width: 0.8):Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5)),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: TextFormField(

          onTap: widget.onTap,
          focusNode: _focusNode,
          // focusNode: focusNode,
          // enabled: isActive,
          obscureText: widget.obscureText??false,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.black9,
              fontWeight: FontWeight.w500
          ),
          controller: widget.controller,
          cursorColor: AppColors.black9,


          decoration:
          InputDecoration(

            filled: true,
            fillColor: color,
            // focusColor:color,
            labelText: widget.labelText,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14,
                color:_isFocused?AppColors.blue7: AppColors.grey7
            ),

            alignLabelWithHint:false,
            errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppColors.red
            ),
            suffix: widget.suffixIcon ?? const SizedBox(),
            prefixIcon: widget.prefixIcon,
            //suffixIcon:
            border:InputBorder.none,





            // hintText: labelText,
            //  enabledBorder: OutlineInputBorder(
            //      borderRadius: BorderRadius.circular(6),
            //      borderSide: BorderSide(
            //        color: darkColor,
            //          width: 0.8
            //      )
            //  ),
            //  errorBorder: OutlineInputBorder(
            //      borderRadius: BorderRadius.circular(6),
            //      borderSide: BorderSide(
            //          color: AppColors.red,
            //          width: 0.8
            //      )
            //  ),
            //  focusedErrorBorder: OutlineInputBorder(
            //      borderRadius: BorderRadius.circular(6),
            //      borderSide: BorderSide(
            //          color: AppColors.red,
            //          width: 0.8
            //      )
            //  ),
          ),
          validator: widget.validation,
          onChanged: widget.onChange,
        ),
      ),
    ) ;
  }
}
