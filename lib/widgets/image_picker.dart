// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePicker extends StatefulWidget {
//   //const ImagePicker({Key? key}) : super(key: key);

//   @override
//   State<ImagePicker> createState() => _ImagePickerState();
// }

// class _ImagePickerState extends State<ImagePicker> {

//   var imagePicker;
//   List<XFile> _images = [];

//   @override
//   void initState() {
//     super.initState();
//     imagePicker = ImagePicker();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(onPressed: () => pickImages(), child: Text('data')),
//     );
//   }

//   Future pickImages() async {

//     await imagePicker.pickMultiImage(
//       source: ImageSource.gallery
//     );
//   }
// }










// /*
// onPressed: () async {
            
//             List<XFile>? images = await imagePicker.pickMultiImage(
//               source: ImageSource.gallery,
//               imageQuality: 50,
//             );

//             setState(() {
//               _images = File(images);
//             });

//             print('images $_images');
//           },

// */