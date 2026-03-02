import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_constants.dart';

/// Singleton service for Supabase client management
class SupabaseService {
  SupabaseService._();

  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();

  bool _isInitialized = false;

  /// Initialize Supabase client
  Future<void> initialize() async {
    if (_isInitialized) return;

    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
      debug: kDebugMode,
    );

    _isInitialized = true;
  }

  /// Get Supabase client
  SupabaseClient get client => Supabase.instance.client;

  /// Get current user
  User? get currentUser => client.auth.currentUser;

  /// Get current session
  Session? get currentSession => client.auth.currentSession;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Auth state changes stream
  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  // ============ Auth Methods ============

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  /// Update password
  Future<UserResponse> updatePassword(String newPassword) async {
    return await client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // ============ Database Methods ============

  /// Get a reference to a table
  SupabaseQueryBuilder from(String table) => client.from(table);

  /// Execute a stored procedure
  Future<dynamic> rpc(String functionName, {Map<String, dynamic>? params}) {
    return client.rpc(functionName, params: params);
  }

  // ============ Storage Methods ============

  /// Get a reference to a storage bucket
  StorageFileApi storage(String bucketName) => client.storage.from(bucketName);

  /// Upload a file to storage
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required Uint8List fileBytes,
    String? contentType,
  }) async {
    await client.storage.from(bucket).uploadBinary(
          path,
          fileBytes,
          fileOptions: FileOptions(
            contentType: contentType,
            upsert: true,
          ),
        );
    return path;
  }

  /// Get a signed URL for a private file
  Future<String> getSignedUrl({
    required String bucket,
    required String path,
    int expiresIn = 3600, // 1 hour default
  }) async {
    return await client.storage.from(bucket).createSignedUrl(path, expiresIn);
  }

  /// Get public URL for a file
  String getPublicUrl({
    required String bucket,
    required String path,
  }) {
    return client.storage.from(bucket).getPublicUrl(path);
  }

  /// Delete a file from storage
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    await client.storage.from(bucket).remove([path]);
  }

  // ============ Realtime Methods ============

  /// Subscribe to table changes
  RealtimeChannel subscribeToTable({
    required String table,
    required void Function(dynamic payload) onInsert,
    void Function(dynamic payload)? onUpdate,
    void Function(dynamic payload)? onDelete,
  }) {
    return client
        .channel('public:$table')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: table,
          callback: (payload) => onInsert(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: table,
          callback: (payload) => onUpdate?.call(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: table,
          callback: (payload) => onDelete?.call(payload.oldRecord),
        )
        .subscribe();
  }
}
