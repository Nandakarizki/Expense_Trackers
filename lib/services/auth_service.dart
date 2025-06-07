import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user?.updateDisplayName(name);
      await result.user?.reload();
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthException('Gagal keluar: ${e.toString()}');
    }
  }

  AuthException _handleAuthException(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'Email tidak ditemukan';
        break;
      case 'wrong-password':
        message = 'Password salah';
        break;
      case 'email-already-in-use':
        message = 'Email sudah digunakan';
        break;
      case 'weak-password':
        message = 'Password terlalu lemah';
        break;
      case 'invalid-email':
        message = 'Format email tidak valid';
        break;
      case 'user-disabled':
        message = 'Akun telah dinonaktifkan';
        break;
      case 'too-many-requests':
        message = 'Terlalu banyak percobaan, coba lagi nanti';
        break;
      case 'operation-not-allowed':
        message = 'Operasi tidak diizinkan';
        break;
      case 'network-request-failed':
        message = 'Koneksi internet bermasalah';
        break;
      case 'invalid-credential':
        message = 'Email atau password salah';
        break;
      default:
        message = 'Terjadi kesalahan yang tidak diketahui.';
    }
    return AuthException(message);
  }
}
