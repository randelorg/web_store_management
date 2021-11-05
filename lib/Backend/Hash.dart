import 'package:xxtea/xxtea.dart';

class Hash {
  String _secretKey = '0x72ce036659118a698a83ad75eea7b492a779729d';
  String _decryptedWord = 'Unknown';
  String _encryptedWord = 'Unknown';

  get secretKey => this._secretKey;

  set secretKey(value) => this._secretKey = value;

  get decryptedWord => this._decryptedWord;

  set decryptedWord(value) => this._decryptedWord = value;

  get encryptedWord => this._encryptedWord;

  set encryptedWord(value) => this._encryptedWord = value;

  void encrypt(String word) {
    encryptedWord(xxteaEncryptToString(word, _secretKey));
  }

  void decrypt(String word) {
    decryptedWord = xxteaDecryptToString(word, _secretKey);
  }
}
