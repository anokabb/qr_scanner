import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/cubit/theme_cubit.dart';

class TxtField extends StatelessWidget {
  BuildContext context;
  String? label;
  TextEditingController? controler;
  String? hint;
  Icon? prefixIcon;
  bool obscure;
  int lines;
  TextInputAction? inputAction;
  TextInputType? inputType;
  bool enabled;
  bool autofocus;
  Function(String)? onChanged;
  FocusNode? focusNode;
  Function(String)? onSubmit;

  TxtField(
    this.context, {
    this.label,
    this.controler,
    this.hint,
    this.prefixIcon,
    this.obscure = false,
    this.lines = 1,
    this.inputAction,
    this.inputType,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
    this.focusNode,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: Theme.of(context).canvasColor,
      borderRadius: 16,
      spread: BlocProvider.of<ThemeCubit>(context).state.isDark ? 0 : 10,
      depth: 10,
      child: TextField(
        autofocus: autofocus,
        onSubmitted: onSubmit,
        onChanged: onChanged,
        enabled: enabled,
        style: TextStyle(color: Theme.of(context).splashColor),
        controller: controler,
        focusNode: focusNode,
        decoration: InputDecoration(
          focusColor: Colors.white,
          prefixIcon: prefixIcon,
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Color.fromRGBO(129, 129, 129, 1)),
          labelStyle: TextStyle(color: Color.fromRGBO(129, 129, 129, 1)),
          filled: true,
          fillColor: Theme.of(context).canvasColor,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(16)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16)),
        ),
        keyboardType: inputType,
        textInputAction: inputAction,
        obscureText: obscure,
        maxLines: lines,
      ),
    );
  }
}
