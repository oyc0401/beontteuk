import 'dart:io';

import 'package:beontteuk/inmat/inmat_api/inmat_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageToUrl {
  Future<String> getUrl() async {
    FilePickerResult? upload = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (upload == null) {
      throw '취소';
    }

    // print(upload);
    print(upload.files.first);

    String url = await InMatApi.community.getImageUrl(upload.files.first.name);

    print(url);

    await _uploadToSignedURL(file: upload.files.first, url: url);

    return "https://inmat.s3.ap-northeast-1.amazonaws.com/${upload.files.first.name}";
  }

  Future<String> getCameraUrl(String path) async {
    File file = File(path);
    String name = basename(file.path);

    print(file);
    print(name);

    String url = await InMatApi.community.getImageUrl(name);

    Uint8List? byte;

    if (kIsWeb) {
      byte = file.readAsBytesSync();

      print("카메라??");
    } else {
      byte = await _readFileByte(file.path);
    }

    http.Response response = await http.put(Uri.parse(url), body: byte);
    print(response.statusCode);
    print(response.body);

    return "https://inmat.s3.ap-northeast-1.amazonaws.com/$name";

    // PlatformFile platformFile=PlatformFile(name: name, size: size)
// /data/user/0/com.oyc0401.beontteuk/cache/CAP9081181283050997484.jpg

    // String url= await InMatApi.community.getImageUrl(path);
    //
    // print(url);
    //
    // // print(upload.files.first.bytes);
    //
    //
    // url= url.replaceAll ('inmat.s3.ap-northeast-2.amazonaws.com', 'inmat.s3-ap-northeast-1.amazonaws.com');
    //
    // print(url);
    //
    // await _uploadToSignedURL(file: upload.files.first,url: url);
    //
    //
    // return "https://inmat.s3.ap-northeast-1.amazonaws.com/${upload.files.first.name}";
  }

  Future<int> _uploadToSignedURL(
      {required PlatformFile file, required String url}) async {
    Uint8List? byte;
    if (kIsWeb) {
      byte = file.bytes;
    } else {
      byte = await _readFileByte(file.path!);
    }

    http.Response response = await http.put(Uri.parse(url), body: byte);
    print(response.statusCode);
    print(response.body);

    return response.statusCode;
  }

  Future<Uint8List?> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List? bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }
}
