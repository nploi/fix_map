import "package:flutter/material.dart";

class Input extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final onChange;
  final String id;
  final bool obscureText;

  const Input({
    Key key,
    @required this.hintText,
    @required this.icon,
    @required this.onChange,
    @required this.id,
    @required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {
        this.onChange(this.id, value);
      },
      cursorColor: Theme.of(context).primaryColorLight,
      obscureText: this.obscureText,
      decoration: InputDecoration(
          hintText: this.hintText,
          prefixIcon: Material(
            elevation: 0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: this.icon,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
    );
  }
}
