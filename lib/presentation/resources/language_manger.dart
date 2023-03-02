import 'package:advance_flutter/app/constants.dart';

enum LanguageType{
  ENGLISH,
  ARABIC
}

extension LanguageTypeExtension on LanguageType {
  String getValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return Constants.english;
      case LanguageType.ARABIC:
       return Constants.arabic;
    }
  }
}