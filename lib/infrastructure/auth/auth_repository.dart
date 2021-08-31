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
