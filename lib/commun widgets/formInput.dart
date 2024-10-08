import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class formInput extends StatelessWidget {
   formInput({
    super.key,
    required this.height,
    required this.label,
    required this.hint,
     this.textEditingController,
    required this.inputType,
    required this.obscureText,
    required this.togglePasswordVisibility,
  });

  final String label;
  final String hint;
  final double height;
   TextEditingController? textEditingController;
  final InputType inputType; // Use enum for input type
  final bool obscureText; // Obscure text visibility
  final VoidCallback togglePasswordVisibility; // Function to toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(height: height * 0.008),
        TextFormField(
          controller: textEditingController,
         validator: (value) {
  switch (inputType) {
    case InputType.password:
      return Validator.validatePassword(value);
    case InputType.email:
      return Validator.validateEmail(value);
    case InputType.name:
      return Validator.validateName(value); // Validate name
    default:
      return null; // Return null for other cases
  }
},

          obscureText: inputType == InputType.password ? obscureText : false, // Hide text if password
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            labelText: hint,
            labelStyle: Theme.of(context).textTheme.labelMedium,
            suffixIcon: inputType == InputType.password
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: togglePasswordVisibility, // Toggle visibility
                  )
                : null,
          ),
          keyboardType: inputType == InputType.email 
              ? TextInputType.emailAddress 
              : TextInputType.text, // Set keyboard type for email
        ),
      ],
    );
  }
}