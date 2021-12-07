import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_chat/enum/user_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

class Utils {
  static String getUsername(String email) {

    return "Nguồn:${email.split('@')[0]}";

  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  static Future<File> pickImage({@required ImageSource source}) async {
    File selectedImage = await ImagePicker.pickImage(source: source);
    // return selectedImage;
     return await compressImage(selectedImage);
  }

  static Future<File> compressImage(File imageToCompress) async {

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);


     Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
     Im.copyResize(image, width: 500, height: 500);

     return new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  //Chuyển kiểu trạng thái người dùng thành số nguyên
  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
     switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }
}