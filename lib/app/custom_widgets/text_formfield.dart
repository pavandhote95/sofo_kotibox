import 'package:flutter/material.dart';
import 'package:sofo/app/custom_widgets/text_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPassword;
  final bool readOnly;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.readOnly = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) {
      _obscureText = false;
    }

    widget.focusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = widget.focusNode.hasFocus;

    return SizedBox(
      height: 55,
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        style: AppTextStyle.montserrat(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: widget.label,
          labelStyle: AppTextStyle.montserrat(
            c: isFocused ? Colors.orange : Colors.grey,
            fs: 16,
          ),
          hintText: widget.hint,
          hintStyle: AppTextStyle.montserrat(c: Colors.grey),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}




// class CustomTextField extends StatefulWidget {
//   final String? label;
//   final String hint;
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final bool isPassword;
//   final bool readOnly;
//   final TextInputType keyboardType;
//
//   const CustomTextField({
//     super.key,
//     this.label,
//     required this.hint,
//     required this.controller,
//     required this.focusNode,
//     this.readOnly = false,
//     this.isPassword = false,
//     this.keyboardType = TextInputType.text,
//   });
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _obscureText = true;
//
//   @override
//   void initState() {
//     super.initState();
//     if (!widget.isPassword) {
//       _obscureText = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isFocused = widget.focusNode.hasFocus;
//     final hasText = widget.controller.text.isNotEmpty;
//
//     return SizedBox(
//       height: 55,
//       child: TextField(
//         readOnly: widget.readOnly,
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         keyboardType: widget.keyboardType,
//         obscureText: _obscureText,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           label: widget.label != null && widget.label!.isNotEmpty
//               ? Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Text(
//               widget.isPassword && (isFocused || hasText)
//                   ? 'Password'
//                   : widget.label ?? '',
//               style: AppTextStyle.montserrat(
//                 c: !isFocused
//                     ? (hasText ? Colors.black : Colors.grey)
//                     : (hasText ? Colors.black : Colors.orange),
//                 fs: (isFocused || hasText) ? 18 : 14,
//               ),
//             ),
//           )
//               : null,
//           hintText: widget.hint,
//           hintStyle: AppTextStyle.montserrat(c: Colors.grey),
//           suffixIcon: widget.isPassword
//               ? IconButton(
//             icon: Icon(
//               _obscureText
//                   ? Icons.visibility_off_outlined
//                   : Icons.visibility_outlined,
//               color: Colors.grey,
//             ),
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           )
//               : null,
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.orange),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 15,
//           ),
//         ),
//       ),
//     );
//   }
// }
