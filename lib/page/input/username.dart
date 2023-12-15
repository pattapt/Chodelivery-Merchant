import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UsernameInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  const UsernameInput({Key? key, required this.controller, this.action, this.focusNode, this.nextFocusNode}) : super(key: key);
  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {

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
          "ชื่อผู้ใช้งาน *ภาษาอังกฤษและตัวเลขเท่านั้น",
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
            hintText: 'ชื่อผู้ใช้งาน',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.person_2_outlined),
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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
          ],
          textInputAction: (widget.action != null) ? widget.action : TextInputAction.next,
          keyboardType: TextInputType.text,
          autofillHints: const [AutofillHints.email],
          autofocus: false,
          validator: (username) => username != null && (username.length < 6 || username.length > 32)
              ? 'กรุณากรอกชื่อผู้ใช้งานให้ถูกต้อง (ยาวตั้งแต่ 6 ถึง 32 ตัวอักษร)'
              : null,
        )
      ],
    )
  );
}