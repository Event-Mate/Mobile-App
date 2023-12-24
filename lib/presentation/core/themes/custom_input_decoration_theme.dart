import 'package:flutter/material.dart';

//! Currently not used may be deleted later on
class CustomInputDecorationTheme {
  InputDecorationTheme get theme {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.all(12),

//* Borders
      /// Enabled and not showing error
      enabledBorder: _buildBorder(),

      /// Has error but not focus
      errorBorder: _buildBorder(color: Colors.red),

      focusedErrorBorder: _buildBorder(color: Colors.red),

      /// Default value if borders are null
      border: _buildBorder(color: Colors.amber),

      /// Enabled and focused
      focusedBorder: _buildBorder(color: Colors.black),

      /// Disabled
      disabledBorder: _buildBorder(color: Colors.white),

//* Styles
      ///error and helper should be in same size so they wont cause any height issues
      errorStyle: _buildTextStyle(Colors.red, size: 12.0),
      helperStyle: _buildTextStyle(Colors.black, size: 12.0),
      hintStyle: _buildTextStyle(Colors.grey),
      labelStyle: _buildTextStyle(Colors.black),
      prefixStyle: _buildTextStyle(Colors.black),
      suffixStyle: _buildTextStyle(Colors.black),
      counterStyle: _buildTextStyle(Colors.grey, size: 12.0),
      floatingLabelStyle: _buildTextStyle(Colors.black),
    );
  }

  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(
      color: color,
      fontSize: size,
    );
  }

  OutlineInputBorder _buildBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
