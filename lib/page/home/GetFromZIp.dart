import 'package:flutter/material.dart';

class SelectItemPage extends StatelessWidget {
  final data;
  const SelectItemPage({Key? key,required this.data}) : super(key: key);
  void _onItemTap(BuildContext context, int selectedItem) {
    Navigator.pop(context, selectedItem);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        SizedBox(height: 30), // Add a SizedBox at the top with desired height

        Expanded(
          child: ListView.builder(
            itemCount: data.data.length,
            itemBuilder: (context, index) {
              return _SelectableItem(
                itemText: data.data[index].district.nameTh +
                    " " +
                    data.data[index].amphure.nameTh +
                    " " +
                    data.data[index].province.nameTh,
                onTap: () => _onItemTap(context, index),
              );
            },
          ),
        ),
      ],
    ),
  );
}



Widget _SelectableItem({required itemText, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Center(
          child: Text(
            itemText,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}