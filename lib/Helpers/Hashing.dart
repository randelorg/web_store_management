import 'package:xxtea/xxtea.dart';

import '../Backend/Interfaces/IHash.dart';

class Hashing implements IHash {
  final String _secretKey = '0x72ce036659118a698a83ad75eea7b492a779729d';
  String _decryptedWord = 'Unkown';
  String _encryptedWord = 'Unkown';

  // get decryptedWord => this._decryptedWord;

  set decryptedWord(String value) => this._decryptedWord = value;

  get encryptedWord => this._encryptedWord;

  set encryptedWord(value) => this._encryptedWord = value;

  //methods
  void encrypt(String word) {
    _encryptedWord = xxtea.encryptToString(word, _secretKey).toString();
  }

  String decrypt(String wordEncrypted) {
    _decryptedWord =
        xxtea.decryptToString(wordEncrypted, _secretKey).toString();
    return _decryptedWord;
  }
}
