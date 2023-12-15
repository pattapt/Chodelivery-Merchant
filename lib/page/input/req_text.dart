import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestTextInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  final String? title;
  final String? description;

  const RequestTextInput({
    Key? key,
    required this.controller,
    this.action,
    this.focusNode,
    this.nextFocusNode,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  State<RequestTextInput> createState() => _RequestTextInputState();
}

class _RequestTextInputState extends State<RequestTextInput> {
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
          widget.title!.isEmpty ? "ระบุข้อความ" : widget.title!,
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: GoogleFonts.getFont('Prompt'),
          controller: widget.controller,
          focusNode: widget.focusNode,
          onEditingComplete: () {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          decoration: InputDecoration(
            hintText: widget.description!.isEmpty ? 'กรุณากรอกข้อมูล' : widget.description!,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
          textInputAction: widget.action ?? TextInputAction.next,
          keyboardType: TextInputType.text,
          autofillHints: const [AutofillHints.email],
          autofocus: false,
          validator: (text) => text != null && text.isEmpty ? 'กรุณากรอกข้อมูล' : null,
        ),
        const SizedBox(height: 5),
      ],
    ),
  );
}
