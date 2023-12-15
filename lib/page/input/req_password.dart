import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestPasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? checkController;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  final String? title;
  final String? description;
  const RequestPasswordInput({Key? key, required this.controller, this.action, this.checkController, this.focusNode, this.nextFocusNode, this.title, this.description}) : super(key: key);
  @override
  State<RequestPasswordInput> createState() => _RequestPasswordInputState();
}

class _RequestPasswordInputState extends State<RequestPasswordInput> {
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
          widget.title!.isEmpty ? "รหัสผ่าน" : widget.title!,
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
            hintText: widget.description!.isEmpty ? 'รหัสผ่าน' : widget.description!,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
          validator: (text) => text != null && text.isEmpty
              ? 'กรุณากรอกข้อมูล'
              : null,
        ),
        const SizedBox(height: 5),
      ],
    ),
  );
  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}