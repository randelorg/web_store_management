import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../Backend/Interfaces/IHash.dart';

class Hashing implements IHash {
  String _encryptedWord = 'Unkown';

  get encryptedWord => this._encryptedWord;

  set encryptedWord(value) => this._encryptedWord = value;

  //methods
  String encrypt(String word) {
    var bytess = utf8.encode(word);
    var digest = sha256.convert(bytess);
    //set the encypted word to the setter
    encryptedWord = digest.toString();
    return encryptedWord;
  }
}
