// Classe para guardar imagens (para poder usar tanto File como Asset)
import 'dart:io';

import 'package:flutter/widgets.dart';

class AppImage {
  String? asset;
  File? file;
  String? url;

  AppImage.asset(this.asset) : file = null, url = null;
  AppImage.file(this.file) : asset = null, url = null;
  AppImage.url(this.url) : file = null, asset = null;

  ImageProvider build() {
    // Ponto de exclamação passa de nullable a non-nullable
    if (asset != null) {
      return AssetImage(asset!);
    } else if (file != null) {
      return FileImage(file!);
    } else if (url != null) {
      return NetworkImage(url!);
    } else {
      return AssetImage('assets/images/placeholder.jpg'); // Fallback
    }
  }
}