import 'package:bloc/bloc.dart';
import '../../repository/login_repo.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<LoadTokenEvent>((event, emit) async {
      try {
        final token = await LoginRepo.getToken();
        emit(TokenLoaded(token ?? 'No token found'));
      } catch (_) {
        emit(TokenLoadFailure());
      }
    });
  }
}
