import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  const EmailInput({Key? key, required this.controller, this.action, this.focusNode, this.nextFocusNode}) : super(key: key);
  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

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
          "อีเมล์",
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: GoogleFonts.getFont('Prompt'),
          controller: widget.controller,
          focusNode: widget.focusNode,
          onEditingComplete: (){
            if(widget.nextFocusNode != null){
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }
          },
          decoration: InputDecoration(
            hintText: 'อีเมล์',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.email_outlined),
            suffixIcon: widget.controller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => widget.controller.clear(),
                  ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            errorStyle: GoogleFonts.prompt(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
          textInputAction: (widget.action != null) ? widget.action : TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          autofocus: false,
          validator: (email) => email != null && (!email.contains('@') || !email.contains('.'))
              ? 'กรุณากรอกอีเมล์ให้ถูกต้อง'
              : null,
        )
      ],
    )
  );
}