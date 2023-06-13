import 'package:flutter/material.dart';

class BaseTextInput extends StatefulWidget {
  final bool? obscureText;
  final bool? readOnly;
  final String? text;
  final String hintText;
  final String? icon;
  final String? prefix;
  final ValueChanged<String>? onChanged;

  const BaseTextInput(
      {this.obscureText,
      this.readOnly,
      required this.hintText,
      this.icon,
      this.prefix,
      super.key,
      this.onChanged,
      this.text});

  @override
  State<BaseTextInput> createState() => _TextInputState();
}

class _TextInputState extends State<BaseTextInput> {
  bool passwordVisible = false;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.text != null) {
      textController.text = widget.text!;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: TextStyle(color: Theme.of(context).canvasColor),
      obscureText: widget.obscureText != null ? !passwordVisible : false,
      readOnly: widget.readOnly == null ? false : widget.readOnly!,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        /* prefixIcon: widget.prefix != null ? SvgPicture.asset(
          widget.prefix ?? "",
        ) : const SizedBox(),*/
        suffixIcon: (() {
          if (widget.obscureText != null) {
            return IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            );
          }
        }()),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        filled: true,
        hintStyle: TextStyle(color: Theme.of(context).canvasColor),
        hintText: widget.hintText,
        fillColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
