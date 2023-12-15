import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? checkController;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  const PasswordInput({Key? key, required this.controller, this.action, this.checkController, this.focusNode, this.nextFocusNode}) : super(key: key);
  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData(
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.red,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "รหัสผ่าน",
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: GoogleFonts.getFont('Prompt'),
          controller: widget.controller,
          obscureText: isHidden,
          focusNode: widget.focusNode,
          onEditingComplete: (){
            if(widget.nextFocusNode != null){
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }else{
              TextInput.finishAutofillContext();
            }
          },
          decoration: InputDecoration(
            hintText: 'รหัสผ่าน',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.fingerprint_outlined),
            suffixIcon: IconButton(
              icon:
                  isHidden ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
              onPressed: togglePasswordVisibility,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            errorStyle: GoogleFonts.prompt(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
          textInputAction: (widget.action != null) ? widget.action : TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          autofillHints: const [AutofillHints.password],
          validator: (password) => password != null && password.length < 6
              ? 'รหัสผ่านต้องมีความยาวมากกว่า 6 ตัวอักษร'
              : (widget.checkController != null && password != widget.checkController!.text)
                  ? 'รหัสผ่านไม่ตรงกัน'
                  : null,
        )
      ],
    ),
  );
  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}