import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';

/// Auth state provider - watches authentication state changes
final authStateProvider = StreamProvider<User?>((ref) {
  final supabase = SupabaseService.instance;

  // Return current user and listen for changes
  return supabase.authStateChanges.map((state) => state.session?.user);
});

/// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).valueOrNull;
});

/// Auth controller for handling login/logout actions
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  AuthController(this._ref) : super(const AsyncValue.data(null));

  SupabaseService get _supabase => SupabaseService.instance;

  /// Sign in with email and password
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.signIn(email: email, password: password);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  /// Sign up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.signUp(email: email, password: password);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _supabase.signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.resetPassword(email);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  /// Clear error state
  void clearError() {
    state = const AsyncValue.data(null);
  }
}

/// Helper to get error message from AuthException
String getAuthErrorMessage(Object error) {
  if (error is AuthException) {
    return error.message;
  }
  return error.toString();
}
