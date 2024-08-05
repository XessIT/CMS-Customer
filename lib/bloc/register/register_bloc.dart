import 'package:bloc/bloc.dart';
import 'package:cms_customer/bloc/register/register_event.dart';
import 'package:cms_customer/bloc/register/register_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      final response = await http.post(
        Uri.parse('http://localhost/CMSAPI/customer_registration.php'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'first_name': event.firstName,
          'last_name': event.lastName,
          'address': event.address,
          'mobile': event.mobile,
          'password': event.password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(error: responseData['error'] ?? 'Registration failed.'));
      }
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }

}
