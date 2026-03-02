import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_session.freezed.dart';
part 'training_session.g.dart';

/// Training session types
enum TrainingType {
  driving('Driving Range', 'driving'),
  putting('Putting', 'putting'),
  chipping('Chipping', 'chipping'),
  bunker('Bunker', 'bunker'),
  fullSwing('Full Swing', 'full_swing'),
  course('On-Course Practice', 'course'),
  fitness('Fitness', 'fitness'),
  mentalGame('Mental Game', 'mental'),
  lesson('Lesson', 'lesson'),
  simulator('Simulator', 'simulator');

  final String label;
  final String value;
  const TrainingType(this.label, this.value);

  static TrainingType fromValue(String value) {
    return TrainingType.values.firstWhere(
      (t) => t.value == value,
      orElse: () => TrainingType.fullSwing,
    );
  }
}

/// Focus areas for training
enum TrainingFocus {
  accuracy('Accuracy'),
  distance('Distance'),
  consistency('Consistency'),
  shortGame('Short Game'),
  speed('Speed'),
  technique('Technique'),
  mentalGame('Mental Game'),
  courseManagement('Course Management');

  final String label;
  const TrainingFocus(this.label);
}

/// Intensity levels
enum TrainingIntensity {
  light('Light'),
  moderate('Moderate'),
  intense('Intense');

  final String label;
  const TrainingIntensity(this.label);
}

/// Training session model
@freezed
class TrainingSession with _$TrainingSession {
  const TrainingSession._();

  const factory TrainingSession({
    required String id,
    required String playerId,
    required DateTime date,
    required TrainingType type,
    required int durationMinutes,
    String? location,
    TrainingIntensity? intensity,
    @Default([]) List<TrainingFocus> focusAreas,
    String? notes,
    String? coachName,
    int? ballsHit,
    int? puttsMade,
    int? puttsAttempted,
    double? rating, // 1-5 self-assessment
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TrainingSession;

  factory TrainingSession.fromJson(Map<String, dynamic> json) =>
      _$TrainingSessionFromJson(json);

  /// Formatted duration
  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final mins = durationMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
  }

  /// Putting percentage
  double? get puttingPercentage {
    if (puttsMade != null && puttsAttempted != null && puttsAttempted! > 0) {
      return puttsMade! / puttsAttempted!;
    }
    return null;
  }
}

/// Weekly training summary
@freezed
class TrainingSummary with _$TrainingSummary {
  const factory TrainingSummary({
    required int totalSessions,
    required int totalMinutes,
    required Map<TrainingType, int> sessionsByType,
    required Map<TrainingType, int> minutesByType,
    required double averageRating,
    required int totalBallsHit,
  }) = _TrainingSummary;
}
