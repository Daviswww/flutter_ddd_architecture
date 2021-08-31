
# Day23 Domain Error Handle
## 安裝
```yaml
dartz: ^0.9.2
```

## Domain：Google Failure
我創建了一個錯誤訊息的引導，GoogleAuthServerFailure當Google登入出錯時會出現，如果你還有FB、Github等的登入你可以往裡面一直新增，`FirebaseAuthFailure`則是處理登入獲取使用者資料的錯誤訊息。

```dart
import 'package:equatable/equatable.dart';

abstract class AuthFailure extends Equatable {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class GoogleAuthServerFailure extends AuthFailure {
  GoogleAuthServerFailure({required String message}) : super(message: "");
}

class FirebaseAuthFailure extends AuthFailure {
  FirebaseAuthFailure({required String message}) : super(message: "");
}

```

## 修改 Infrastructure Auth
將所有功能都加上AuthFailure，我多新增了一個getUser，這樣一來登入完成後可以直接獲取使用者資訊。

```dart
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stunning_tribble/domain/auth/auth_failure.dart';

abstract class AuthRepositoryImpl {
  /// Used when the google login button is triggered.
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  /// Check if you are logged in.
  Future<Either<AuthFailure, Unit>> isSignedIn();

  /// Log out of device.
  Future<Either<AuthFailure, Unit>> signOut();

  /// Get current user info.
  Future<Either<AuthFailure, User>> getUser();
}

class AuthRepository implements AuthRepositoryImpl {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(GoogleAuthServerFailure(message: "Cache User Failure"));
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);

      return right(unit);
    } catch (e) {
      return left(GoogleAuthServerFailure(message: "$e"));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> isSignedIn() async {
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        return right(unit);
      } else {
        return left(FirebaseAuthFailure(message: "Not Logged In"));
      }
    } catch (e) {
      return left(FirebaseAuthFailure(message: "$e"));
    }
  }

  Future<Either<AuthFailure, User>> getUser() async {
    try {
      return right(_firebaseAuth.currentUser);
    } catch (_) {
      return left(FirebaseAuthFailure(message: "Get Current User Failure"));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return right(unit);
    } catch (e) {
      return left(FirebaseAuthFailure(message: "$e"));
    }
  }
}

```
