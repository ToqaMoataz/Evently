

import '../../../../../../Core/assets/const data.dart';

abstract class LoginStates {}

class LoginState extends LoginStates {
   final RequestState loginRequestState;
   final bool passwordVisible;
   final double opacity;
   final String? errorMessage;

   LoginState({
      this.loginRequestState = RequestState.init,
      this.passwordVisible = false,
      this.opacity = 1.0,
      this.errorMessage,
   });

   LoginState copyWith({
      RequestState? loginRequestState,
      bool? passwordVisible,
      double? opacity,
      String? errorMessage,
   }) {
      return LoginState(
         loginRequestState: loginRequestState ?? this.loginRequestState,
         passwordVisible: passwordVisible ?? this.passwordVisible,
         opacity: opacity ?? this.opacity,
         errorMessage: errorMessage,
      );
   }
}

class LoginInitState extends LoginState {
   LoginInitState() : super(
      loginRequestState: RequestState.init,
      passwordVisible: false,
   );
}
