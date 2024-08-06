import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class PostDetails extends StatefulWidget {
  final String? details;
  final List<String>? images;

  const PostDetails({Key? key, this.details, this.images}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late TextEditingController _detailsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  bool _isLoading = false;
  double _compressionProgress = 0.0;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true;
      _compressionProgress = 0.0;
    });

    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      if (_selectedImages.length + pickedFiles.length > 4) {
        // Show Snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You can only select up to 4 images.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
      List<XFile> compressedImages = [];
      for (int i = 0; i < pickedFiles.length; i++) {
        XFile file = pickedFiles[i];
        final File imageFile = File(file.path);
        final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
        if (image != null) {
          final img.Image resizedImage = img.copyResize(image, width: 800); // Adjust width as needed
          final List<int> compressedImage = img.encodeJpg(resizedImage, quality: 85); // Adjust quality as needed

          final String compressedPath = '${file.path}_compressed.jpg';
          final File compressedImageFile = File(compressedPath);
          compressedImageFile.writeAsBytesSync(compressedImage);

          compressedImages.add(XFile(compressedImageFile.path));
          setState(() {
            _compressionProgress = (i + 1) / pickedFiles.length;
          });
        }
      }

      setState(() {
        _selectedImages.addAll(compressedImages);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }


  void _saveDetails() {
    if (_detailsController.text.isEmpty) {
      // Show Snackbar with error message for empty details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide details about the service request.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pop(context, {
      'details': _detailsController.text,
      'images': _selectedImages.map((e) => e.path).toList(),
    });
  }
  @override
  void initState() {
    super.initState();
    _detailsController = TextEditingController(text: widget.details);
    if (widget.images != null) {
      _selectedImages = widget.images!.map((path) => XFile(path)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text('Add Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _detailsController,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Please provide details about the service request',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MaterialButton(
                  onPressed: _pickImage,
                  child: Text('Add Images'),
                ),
              ),
            ),
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Compressing images: ${(_compressionProgress * 100).toStringAsFixed(0)}%'),
                  ],
                ),
              ),
            if (_selectedImages.isNotEmpty)
              Wrap(
                children: _selectedImages.asMap().entries.map((entry) {
                  int index = entry.key;
                  XFile image = entry.value;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Image.file(
                          File(image.path),
                          height: 100,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () => _removeImage(index),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MaterialButton(
                  onPressed: _saveDetails,
                  child: Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
