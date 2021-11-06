import 'Hashing.dart';
import 'Interfaces/ILogin.dart';

class GlobalController implements ILogin {
  var hash = Hashing();

  void login(final String word) {
    // print(xxtea.encryptToString(word, _secretKey));
    // hash.encrypt(word);
    // print(hash.getEncrypt());

    hash.decrypt('DKbRBOdWkBE=');
    print(hash.getDecrypt());
  }

  void logout() {}
  static void addAdmin() {}
}
