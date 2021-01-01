// Dependency imports
import 'package:flutter/material.dart';

// Availabell imports
import 'package:availabell/widgets/misc/globals.dart' as globals;
import 'package:availabell/widgets/ui/av_themes.dart';
import 'package:flutter/services.dart';

class AVTextFormField extends StatelessWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode fieldFocusNode;
  final FocusNode fieldFocusNodeToRequest;
  final Function validator;
  final Function onSaved;
  final int maxLength;
  final String initialValueText;

  AVTextFormField({
    Key key,
    this.labelText,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.fieldFocusNode = null,
    this.fieldFocusNodeToRequest = null,
    this.validator,
    this.onSaved,
    this.maxLength,
    this.initialValueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _avFormFieldBorder(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: color, width: 1.0),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
            ),
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextFormField(
            cursorColor: AVThemes.avDarkColor,
            decoration: InputDecoration(
              labelText: null,
              filled: true,
              fillColor: Colors.white,
              hoverColor: Colors.white,
              focusColor: Colors.white,
              contentPadding: EdgeInsets.only(left: globals.halfSpacer, right: globals.halfSpacer),
              focusedBorder: _avFormFieldBorder(AVThemes.avDarkColor),
              enabledBorder: _avFormFieldBorder(AVThemes.avGreyColor),
              errorBorder: _avFormFieldBorder(AVThemes.avPinkColor),
              focusedErrorBorder: _avFormFieldBorder(AVThemes.avPinkColor),
            ),
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            focusNode: fieldFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(fieldFocusNodeToRequest);
            },
            validator: validator,
            onSaved: onSaved,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            initialValue: initialValueText,
          ),
        ],
      ),
    );
  }
}
