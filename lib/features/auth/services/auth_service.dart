import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite_flutter_starter_kit/core/constants/appwrite_constants.dart';
import 'package:appwrite_flutter_starter_kit/core/providers/appwrite_providers.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final Account _account = AppwriteProviders().account;

  // Sign up with email/password
  Future<models.User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return user;
    } on AppwriteException catch (e) {
      throw _handleException(e);
    }
  }

  // Sign in with email/password
  Future<models.Session> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session;
    } on AppwriteException catch (e) {
      throw _handleException(e);
    }
  }

  // Sign in with Google OAuth
  Future<bool> signInWithGoogle() async {
    try {
      // Generate OAuth2 URL
      final String url = _generateOAuthUrl();

      // Launch OAuth flow
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: _getCallbackScheme(),
      );

      // Extract parameters from callback URL
      final Uri uri = Uri.parse(result);
      final String? userId = uri.queryParameters['userId'];
      final String? secret = uri.queryParameters['secret'];

      if (userId == null || secret == null) {
        throw 'OAuth authentication failed';
      }

      // Create session with OAuth credentials
      await _account.createSession(
        userId: userId,
        secret: secret,
      );

      return true;
    } on AppwriteException catch (e) {
      throw _handleException(e);
    } catch (e) {
      throw 'OAuth authentication failed: ${e.toString()}';
    }
  }

  // Generate OAuth URL based on platform
  String _generateOAuthUrl() {
    final String endpoint = AppwriteConstants.appwritePublicEndpoint;
    final String projectId = AppwriteConstants.appwriteProjectId;
    final String provider = AppwriteConstants.googleOAuthProvider;

    String successUrl;
    String failureUrl;

    if (kIsWeb) {
      // Web platform
      successUrl = '${Uri.base.origin}/auth/success';
      failureUrl = '${Uri.base.origin}/auth/failure';
    } else {
      // Mobile platforms (Android/iOS)
      final scheme = _getCallbackScheme();
      successUrl = '$scheme://auth';
      failureUrl = '$scheme://auth';
    }

    return '$endpoint/account/sessions/oauth2/$provider'
        '?project=$projectId'
        '&success=${Uri.encodeComponent(successUrl)}'
        '&failure=${Uri.encodeComponent(failureUrl)}';
  }

  // Get callback URL scheme based on platform
  String _getCallbackScheme() {
    if (kIsWeb) {
      return 'http';
    } else if (Platform.isAndroid) {
      return 'appwrite-callback-${AppwriteConstants.appwriteProjectId}';
    } else if (Platform.isIOS) {
      return 'appwrite-callback-${AppwriteConstants.appwriteProjectId}';
    }
    return 'appwrite-callback';
  }

  // Get current user
  Future<models.User?> getCurrentUser() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        return null; // User not logged in
      }
      throw _handleException(e);
    }
  }

  // Get current session
  Future<models.Session?> getCurrentSession() async {
    try {
      return await _account.getSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        return null;
      }
      throw _handleException(e);
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      await _account.get();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      throw _handleException(e);
    }
  }

  // Delete all sessions (logout from all devices)
  Future<void> signOutFromAllDevices() async {
    try {
      await _account.deleteSessions();
    } on AppwriteException catch (e) {
      throw _handleException(e);
    }
  }

  // Error handling
  String _handleException(AppwriteException e) {
    switch (e.code) {
      case 401:
        return 'Invalid credentials';
      case 409:
        return 'User already exists';
      case 429:
        return 'Too many requests. Please try again later';
      default:
        return e.message ?? 'An error occurred';
    }
  }
}
