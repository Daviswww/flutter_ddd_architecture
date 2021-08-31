
# Day22 Infrastructure Auth
## 安裝
```yaml
google_sign_in: ^5.0.5
firebase_auth: ^3.0.1
firebase_core: ^1.4.0
```

## Google 登入
在登入時會有三個功能，第一個是按按鈕的時候觸發的google登入和第二個登出，第三個則是在開啟app時檢查有沒有登入過，有的話就可以跳過登入畫面，如果還不知道Google登入怎麼設定的請到[Day16 - Google登入教學]()。

```dart
abstract class AuthRepositoryImpl {
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  Future<bool> isSignedIn();
}

class AuthRepository implements AuthRepositoryImpl {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  @override
  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return false;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);

    return true;
  }

  @override
  Future<void> signOut() async {
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}

```