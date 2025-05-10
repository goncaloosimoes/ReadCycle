// Classe para guardar imagens (para poder usar tanto File como Asset)
import 'dart:io';

import 'package:flutter/widgets.dart';

class AppImage {
  String? asset;
  File? file;

  AppImage.asset(this.asset) : file = null;
  AppImage.file(this.file) : asset = null;

  ImageProvider build() {
    // Ponto de exclamação passa de nullable a non-nullable
    if (asset != null) {
      return AssetImage(asset!);
    } else if (file != null) {
      return FileImage(file!);
    } else {
      return AssetImage('assets/images/placeholder.jpg'); // Fallback
    }
  }
}