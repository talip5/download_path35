
/*
final pickedFile = await picker.getImage(source: ImageSource.camera);
_image = File(pickedFile.path);

// getting a directory path for saving
final Directory extDir = await getApplicationDocumentsDirectory();
String dirPath = extDir.path;
final String filePath = '$dirPath/image.png';

// copy the file to a new path
final File newImage = await _image.copy(filePath);
setState(() {
if (pickedFile != null) {
_image = newImage;
} else {
print('No image selected.');
}
});*/
