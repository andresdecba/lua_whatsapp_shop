import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';

class PickImages extends StatefulWidget {
  const PickImages({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;
  @override
  State<PickImages> createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  var _picker;
  var _pickImageError;
  final List<XFile> _imageFileList = [];

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AdminProductsProvider>(context);
    return Column(
      children: [
        _previewImages(_provider),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => pickImages(_provider),
          style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40)),
          child: Text('Agregar imágenes'),
        ),
      ],
    );
  }

  // display images or no images message
  Widget _previewImages(AdminProductsProvider provider) {
    
    if (_imageFileList.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          crossAxisCount: 3,
        ),
        itemCount: _imageFileList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _imageFileList.removeAt(index);
                provider.imagesToUpload.removeAt(index);
              });
            },
            child: Stack(fit: StackFit.expand, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_imageFileList[index].path),
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 30,
                  ))
            ]),
          );
        },
      );
    } else if (_pickImageError != null) {
      return Text(
        'Error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else if (widget.product != null) {
      return SizedBox();
    } else {
      return Container(
        padding: kPaddingSmall,
        color: kLightGrey,
        width: double.infinity,
        child: const Text(
          'No hay imágenes agregadas',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  // pick images from gallery
  Future pickImages(AdminProductsProvider provider) async {
    try {
      // 1- get images
      List<XFile> pickedFileList = await _picker.pickMultiImage();

      // 2- send picked images to provider
      for (var item in pickedFileList) {
        File tmp = File(item.path);
        provider.imagesToUpload.add(tmp);
      }

      // 3- update screen
      setState(() {
        _imageFileList.addAll(pickedFileList);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
