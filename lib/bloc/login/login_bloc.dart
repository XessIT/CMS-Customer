import 'package:bloc/bloc.dart';
import '../../repository/login_repo.dart';
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
      final result = await LoginRepo.loginUser(
        event.mobile,
        event.password,
      );

      // Check for success key and handle accordingly
      if (result['status'] == 'success') {
        // Retrieve the token and print it
        final token = result['token'];
        print('Access Token: $token');
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: result['message']));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

}
