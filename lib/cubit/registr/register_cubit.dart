import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> register(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(
            errorMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-usewrong-password') {
        emit(RegisterFailure(
            errorMessage: "The account already exists for that email."));
      } else {
        emit(RegisterFailure(errorMessage: e.toString()));
      }
    }
  }

  void passwordVisability() {
    emit(RegisterChangePasswordStyle1());
  }

  void passwordVisability2() {
    emit(RegisterChangePasswordStyle2());
  }
}
