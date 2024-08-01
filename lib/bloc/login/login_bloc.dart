import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    // Basic input validation
    if (event.mobile.isEmpty && event.password.isEmpty) {
      emit(LoginFailure(error: 'Enter a Mobile and Password'));
      return;
    } else if (event.mobile.isEmpty) {
      emit(LoginFailure(error: 'Enter a Mobile Number'));
      return;
    } else if (event.password.isEmpty) {
      emit(LoginFailure(error: 'Enter a Password'));
      return;
    }

    try {
      await Future.delayed(Duration(seconds: 2));

      // Replace this with actual login validation
      if (event.mobile != '123') {
        emit(LoginFailure(error: 'Invalid Mobile Number'));
      } else if (event.password != 'p') {
        emit(LoginFailure(error: 'Invalid Password'));
      } else {
        emit(LoginSuccess());
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
