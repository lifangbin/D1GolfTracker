/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'D1 Golf Tracker';
  static const String appVersion = '1.0.0';

  // Supabase Configuration
  static const String supabaseUrl = 'https://znzcvssbsvzgmorizwga.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_O5jjsumS4LrDQ2L-zryieA_JGxRxPU0';

  // GolfAPI.io Configuration
  static const String golfApiBaseUrl = 'https://api.golfapi.io';
  static const String golfApiKey = 'YOUR_GOLF_API_KEY';

  // Google Places API (for course search)
  // Get your API key from: https://console.cloud.google.com/apis/credentials
  // Enable: Places API, Places API (New)
  static const String googlePlacesApiKey = 'YOUR_GOOGLE_PLACES_API_KEY';

  // GA CONNECT URLs
  static const String gaConnectLoginUrl = 'https://golf.com.au/login';
  static const String gaConnectPortalUrl = 'https://golf.com.au/golfer';

  // Media Settings
  static const int maxVideoSeconds = 120;
  static const int photoMaxWidth = 2048;
  static const int photoQuality = 85;
  static const int thumbnailWidth = 400;
  static const int thumbnailQuality = 60;
  static const int videoQuality720p = 720;
  static const int maxFileSizeMB = 50;

  // Cache Settings
  static const int courseCacheDays = 90;
  static const int handicapSyncIntervalHours = 24;

  // Pagination
  static const int defaultPageSize = 20;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 500);
}

/// Development phase definitions
class DevelopmentPhase {
  final int number;
  final String name;
  final String ageRange;
  final String description;
  final double targetHandicap;

  const DevelopmentPhase({
    required this.number,
    required this.name,
    required this.ageRange,
    required this.description,
    required this.targetHandicap,
  });

  static const List<DevelopmentPhase> phases = [
    DevelopmentPhase(
      number: 1,
      name: 'Foundation',
      ageRange: '8-10',
      description: 'Build fundamentals, develop love for the game',
      targetHandicap: 36.0,
    ),
    DevelopmentPhase(
      number: 2,
      name: 'Development',
      ageRange: '11-13',
      description: 'Competitive introduction, skill refinement',
      targetHandicap: 18.0,
    ),
    DevelopmentPhase(
      number: 3,
      name: 'Competition',
      ageRange: '14-15',
      description: 'State/National level competition, mental game',
      targetHandicap: 8.0,
    ),
    DevelopmentPhase(
      number: 4,
      name: 'Elite',
      ageRange: '16-18',
      description: 'Elite performance, advanced competition',
      targetHandicap: 2.0,
    ),
  ];

  static DevelopmentPhase getPhase(int number) {
    return phases.firstWhere(
      (p) => p.number == number,
      orElse: () => phases.first,
    );
  }
}

/// Elite performance benchmark targets
class EliteBenchmarks {
  EliteBenchmarks._();

  // Scoring
  static const double scoringAverage = 74.0;
  static const double par3Average = 3.2;
  static const double par4Average = 4.2;
  static const double par5Average = 5.0;

  // Short Game
  static const int puttsPerRound = 30;
  static const double onePuttPercent = 35.0;
  static const double threePuttPercent = 3.0;
  static const double upAndDownPercent = 55.0;
  static const double sandSavePercent = 45.0;

  // Ball Striking
  static const double firPercent = 70.0; // Fairways in Regulation
  static const double girPercent = 60.0; // Greens in Regulation
  static const double par5BirdieRate = 30.0;

  // Handicap targets by phase
  static const Map<int, double> handicapByPhase = {
    1: 36.0,
    2: 18.0,
    3: 8.0,
    4: 2.0,
  };
}

/// Storage bucket names
class StorageBuckets {
  StorageBuckets._();

  static const String tournamentMedia = 'tournament-media';
  static const String avatars = 'avatars';
}

/// Database table names
class TableNames {
  TableNames._();

  static const String players = 'players';
  static const String handicapHistory = 'handicap_history';
  static const String tournaments = 'tournaments';
  static const String rounds = 'rounds';
  static const String holeScores = 'hole_scores';
  static const String mediaItems = 'media_items';
  static const String trainingLogs = 'training_logs';
  static const String trainingSessions = 'training_sessions';
  static const String milestones = 'milestones';
  static const String playerMilestones = 'player_milestones';
  static const String academicRecords = 'academic_records';
  static const String userCourses = 'user_courses';
}
