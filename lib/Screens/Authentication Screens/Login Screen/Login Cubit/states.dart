enum RequestState { init, loading, success, error }

abstract class LoginStates {}

class LoginState extends LoginStates {
   final RequestState loginRequestState;

   LoginState({this.loginRequestState = RequestState.init});

   LoginState copyWith({
      RequestState? loginRequestState,
   }) {
      return LoginState(
         loginRequestState: loginRequestState ?? this.loginRequestState,
      );
   }
}

class LoginInitState extends LoginState {
   LoginInitState() : super(loginRequestState: RequestState.init);
}
