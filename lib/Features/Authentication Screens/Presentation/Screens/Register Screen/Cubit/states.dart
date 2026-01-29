

import '../../../../../../Core/assets/const data.dart';

abstract class RegisterStates {}

class RegisterState extends RegisterStates {
  final RequestState registerRequestState;
  final bool passVisible;
  final bool rePassVisible;
  final String? errorMessage;
  final double opacity;
  RegisterState({
    this.registerRequestState = RequestState.init,
    this.passVisible = false,
    this.rePassVisible = false,
    this.errorMessage,
    this.opacity = 1.0,
  });

  RegisterState copyWith({
    RequestState? registerRequestState,
    bool? passVisible,
    bool? rePassVisible,
    String? errorMessage,
    double? opacity,
  }) {
    return RegisterState(
      registerRequestState:
      registerRequestState ?? this.registerRequestState,
      passVisible: passVisible ?? this.passVisible,
      rePassVisible: rePassVisible ?? this.rePassVisible,
      errorMessage: errorMessage ?? this.errorMessage,
      opacity: opacity ?? this.opacity,
    );
  }
}

class RegisterInitState extends RegisterState {}
