import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/screens/login_screen.dart';
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
  static const String academic = '/academic';
  static const String addRound = '/add-round';
  static const String scorecard = '/scorecard/:roundId';
}

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final playerState = ref.watch(playerNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isProfileSetup = state.matchedLocation == AppRoutes.profileSetup;

      // If still loading auth state, stay on splash
      if (authState.isLoading) {
        return isSplash ? null : AppRoutes.splash;
      }

      // If not logged in and not on login page, redirect to login
      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }

      // If logged in, check for player profile
      if (isLoggedIn) {
        final hasProfile = playerState.valueOrNull != null;
        final isLoadingProfile = playerState.isLoading;
        final hasError = playerState.hasError;

        // Still loading profile, allow splash or setup
        if (isLoadingProfile && (isSplash || isProfileSetup)) {
          return null;
        }

        // If there's an error loading profile, try going to dashboard anyway
        // The dashboard will handle the error state
        if (hasError && (isSplash || isProfileSetup)) {
          return AppRoutes.dashboard;
        }

        // No profile and not on setup screen and not loading, redirect to profile setup
        if (!hasProfile && !isProfileSetup && !isLoadingProfile) {
          return AppRoutes.profileSetup;
        }

        // Has profile and on login/splash/setup, redirect to dashboard
        if (hasProfile && (isLoggingIn || isSplash || isProfileSetup)) {
          return AppRoutes.dashboard;
        }

        // If on splash/login and not loading, go to dashboard
        // This handles edge cases where profile might exist but state is stale
        if ((isSplash || isLoggingIn) && !isLoadingProfile) {
          return AppRoutes.dashboard;
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
