import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: "Wrong password provided for that user."));
      } else {
        emit(LoginFailure(errorMessage: e.toString()));
      }
    }
  }

  void passwordVisability() {
    emit(LoginChangePasswordStyle());
  }
}
