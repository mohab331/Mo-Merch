import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

/// A custom implementation of [BlocObserver] for observing the state changes and events in BLoCs.
/// This observer logs the BLoC lifecycle events, state changes, transitions, and errors to the console in debug mode.
class AppBlocObserver extends BlocObserver {
  /// Called when a new [bloc] is created.
  /// Logs the `onCreate` event along with the [bloc] type to the console in debug mode.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print('onCreate -- ${bloc.runtimeType}');
    }
  }

  /// Called when an [event] is dispatched to a [bloc].
  /// Logs the `onEvent` event along with the [bloc] type and the dispatched [event] to the console in debug mode.
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('onEvent -- ${bloc.runtimeType}, $event');
    }
  }

  /// Called when a [bloc] changes its [state].
  /// Logs the `onChange` event along with the [bloc] type and the changed [state] to the console in debug mode.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  /// Called when a [bloc] transitions from one state to another.
  /// Logs the `onTransition` event along with the [bloc] type and the transition details to the console in debug mode.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('onTransition -- ${bloc.runtimeType}, $transition');
    }
  }

  /// Called when an [error] occurs within a [bloc].
  /// Logs the `onError` event along with the [bloc] type and the error details to the console in debug mode.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- ${bloc.runtimeType}, $error');
    }
    super.onError(bloc, error, stackTrace);
  }

  /// Called when a [bloc] is closed.
  /// Logs the `onClose` event along with the [bloc] type to the console in debug mode.
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print('onClose -- ${bloc.runtimeType}');
    }
  }
}
