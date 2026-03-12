import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/profile_setup_screen.dart';
import '../features/auth/presentation/screens/profile_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/tournaments/presentation/screens/tournaments_screen.dart';
import '../features/tournaments/presentation/screens/tournament_detail_screen.dart';
import '../features/tournaments/presentation/screens/add_tournament_screen.dart';
import '../features/handicap/presentation/screens/handicap_screen.dart';
import '../features/analytics/presentation/screens/analytics_screen.dart';
import '../features/milestones/presentation/screens/milestones_screen.dart';
import '../features/training/presentation/screens/training_screen.dart';
import '../features/academic/presentation/screens/academic_screen.dart';
import '../features/scorecard/presentation/screens/add_round_screen.dart';
import '../features/scorecard/presentation/screens/scorecard_screen.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/providers/player_provider.dart';
import 'shell_screen.dart';

/// Track if user is in password reset flow (to prevent redirect after OTP verification)
final isInPasswordResetFlowProvider = StateProvider<bool>((ref) => false);

/// Track the current step in password reset flow (persists across widget rebuilds)
final resetPasswordStepProvider = StateProvider<int>((ref) => 0);

/// Track the email being used for password reset
final resetPasswordEmailProvider = StateProvider<String>((ref) => '');

/// Route names for navigation
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String tournaments = '/tournaments';
  static const String tournamentDetail = '/tournaments/:id';
  static const String handicap = '/handicap';
  static const String analytics = '/analytics';
  static const String training = '/training';
  static const String milestones = '/milestones';
  static const String profile = '/profile';
  static const String profileSetup = '/profile/setup';
  static const String profileEdit = '/profile/edit';
  static const String settings = '/settings';
  static const String resetPassword = '/reset-password';
  static const String academic = '/academic';
  static const String addRound = '/add-round';
  static const String scorecard = '/scorecard/:roundId';
}

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final playerState = ref.watch(playerNotifierProvider);
  final isInPasswordResetFlow = ref.watch(isInPasswordResetFlowProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final currentPath = state.matchedLocation;
      final isLoggingIn = currentPath == AppRoutes.login;
      final isSplash = currentPath == AppRoutes.splash;
      final isProfileSetup = currentPath == AppRoutes.profileSetup;
      final isResetPassword = currentPath == AppRoutes.resetPassword;

      // If still loading auth state, stay on splash
      if (authState.isLoading) {
        return isSplash ? null : AppRoutes.splash;
      }

      // If not logged in and not on login or reset password page, redirect to login
      if (!isLoggedIn && !isLoggingIn && !isResetPassword) {
        return AppRoutes.login;
      }

      // If logged in, check for player profile
      if (isLoggedIn) {
        // Allow user to stay on reset password page to complete the flow
        // (OTP verification logs user in, but they still need to set new password)
        // Check both the current path AND the flow state flag
        if (isResetPassword || isInPasswordResetFlow) {
          return isResetPassword ? null : AppRoutes.resetPassword;
        }

        final hasProfile = playerState.valueOrNull != null;
        final isLoadingProfile = playerState.isLoading;
        final hasError = playerState.hasError;

        // Still loading profile - stay where we are (splash or profile setup)
        if (isLoadingProfile) {
          if (isSplash || isProfileSetup) {
            return null; // Stay on current page while loading
          }
          // For other pages, wait on splash
          return AppRoutes.splash;
        }

        // Profile loading complete - now decide where to go

        // If there's an error loading profile, go to dashboard
        // The dashboard will handle showing appropriate error state
        if (hasError) {
          if (isSplash || isProfileSetup || isLoggingIn) {
            return AppRoutes.dashboard;
          }
          return null; // Already on a valid page
        }

        // No profile - must go to profile setup
        if (!hasProfile) {
          if (isProfileSetup) {
            return null; // Already on profile setup, stay here
          }
          return AppRoutes.profileSetup;
        }

        // Has profile - redirect away from auth/setup pages to dashboard
        if (hasProfile) {
          if (isLoggingIn || isSplash || isProfileSetup) {
            return AppRoutes.dashboard;
          }
          return null; // Already on a valid authenticated page
        }
      }

      return null;
    },
    routes: [
      // Splash screen
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Login screen
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // Reset password screen
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          final email = state.extra as String?;
          return ResetPasswordScreen(email: email);
        },
      ),

      // Profile setup screen (first-time flow)
      GoRoute(
        path: AppRoutes.profileSetup,
        builder: (context, state) => const ProfileSetupScreen(),
      ),

      // Profile screen
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      // Training screen
      GoRoute(
        path: AppRoutes.training,
        builder: (context, state) => const TrainingScreen(),
      ),

      // Academic screen
      GoRoute(
        path: AppRoutes.academic,
        builder: (context, state) => const AcademicScreen(),
      ),

      // Add Round screen (practice round)
      GoRoute(
        path: AppRoutes.addRound,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return AddRoundScreen(
            tournamentId: extra?['tournamentId'] as String?,
            tournamentName: extra?['tournamentName'] as String?,
            courseName: extra?['courseName'] as String?,
            coursePar: extra?['coursePar'] as int?,
            courseSlope: extra?['courseSlope'] as double?,
            courseRating: extra?['courseRating'] as double?,
            roundNumber: (extra?['roundNumber'] as int?) ?? 1,
          );
        },
      ),

      // Scorecard view screen
      GoRoute(
        path: '/scorecard/:roundId',
        builder: (context, state) {
          final roundId = state.pathParameters['roundId']!;
          return ScorecardScreen(roundId: roundId);
        },
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: AppRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),

          // Tournaments
          GoRoute(
            path: AppRoutes.tournaments,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TournamentsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddTournamentScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return TournamentDetailScreen(tournamentId: id);
                },
              ),
            ],
          ),

          // Handicap
          GoRoute(
            path: AppRoutes.handicap,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HandicapScreen(),
            ),
          ),

          // Analytics
          GoRoute(
            path: AppRoutes.analytics,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AnalyticsScreen(),
            ),
          ),

          // Milestones
          GoRoute(
            path: AppRoutes.milestones,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MilestonesScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(state.error?.message ?? 'Unknown error'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
