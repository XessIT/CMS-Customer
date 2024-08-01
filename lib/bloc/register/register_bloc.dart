import 'package:bloc/bloc.dart';
import 'package:cms_customer/bloc/register/register_event.dart';
import 'package:cms_customer/bloc/register/register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  void _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    // Basic input validation
    if (event.firstName.isEmpty || event.lastName.isEmpty || event.address.isEmpty || event.mobile.isEmpty || event.otp.isEmpty || event.password.isEmpty) {
      emit(RegisterFailure(error: 'Please fill in all fields'));
      return;
    }

    if (event.mobile.length < 10) {
      emit(RegisterFailure(error: 'Invalid Mobile Number'));
      return;
    }

    if (event.password.length < 6) {
      emit(RegisterFailure(error: 'Password must be at least 6 characters'));
      return;
    }

    try {
      await Future.delayed(Duration(seconds: 2));
      emit(RegisterSuccess());
      // Add your actual registration logic here
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
