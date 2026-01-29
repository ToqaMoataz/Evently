import '../../../../../../Core/assets/const data.dart';

abstract class ForgetPassStates {}

class ForgetPassState extends ForgetPassStates {
  final RequestState forgetPassRequestState;
  final String? errorMessage;
  final double opacity;

  ForgetPassState({
    this.forgetPassRequestState = RequestState.init,
    this.errorMessage,
    this.opacity = 1.0,
  });

  ForgetPassState copyWith({
    RequestState? forgetPassRequestState,
    String? errorMessage,
    double? opacity,
  }) {
    return ForgetPassState(
      forgetPassRequestState: forgetPassRequestState ?? this.forgetPassRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      opacity: opacity ?? this.opacity,
    );
  }
}

class ForgetPassInitialState extends ForgetPassState {}


