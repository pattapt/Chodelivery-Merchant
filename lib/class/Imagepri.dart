import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/chodelivery.dart';

class GetImagePrivateV2 extends StatefulWidget {
  final String imageUrl;
  final double? width, height;

  const GetImagePrivateV2({Key? key, required this.imageUrl, this.width = 200, this.height = 200}) : super(key: key);

  @override
  _GetImagePrivateV2State createState() => _GetImagePrivateV2State();
}

class _GetImagePrivateV2State extends State<GetImagePrivateV2> {
  late Future<List<int>> _imageFuture;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _imageFuture = Chodee.getImagePrivate(widget.imageUrl);
    _imageFuture.then((imageBytes) {
      if (mounted) {
        setState(() {
          _imageBytes = Uint8List.fromList(imageBytes);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageBytes != null
        ? _buildImageWidget()
        : FutureBuilder<List<int>>(
            future: _imageFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final imageBytes = snapshot.data!;
                _imageBytes = Uint8List.fromList(imageBytes);
                return _buildImageWidget();
              } else if (snapshot.hasError) {
                return Text('ไม่สามารถแสดงผลรูปภาพได้ในขณะนี้ โปรดลองใหม่อีกครั้งภายหลัง');
              } else {
                return CircularProgressIndicator();
              }
            },
          );
  }

  Widget _buildImageWidget() {
    return Image.memory(
      _imageBytes!,
      width: 300,
      fit: BoxFit.cover,
    );
  }
}