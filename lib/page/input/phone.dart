import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  const PhoneInput({Key? key, required this.controller, this.action, this.focusNode, this.nextFocusNode}) : super(key: key);
  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {

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
          "หมายเลขโทรศัพท์มือถือ",
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
            hintText: '08X-XXX-XXXX',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.phone_enabled_sharp),
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
            counterText: '',
          ),

          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
          ],
          maxLength: 10,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.telephoneNumber],
          autofocus: false,
          validator: (phone) => phone != null && (phone.length != 10 || !phone.startsWith('0'))
              ? 'หมายเลขโทรศัพท์มือถือไม่ถูกต้อง'
              : null,
        )
      ],
    )
  );
}

