import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
class Player with _$Player {
  const factory Player({
    required String id,
    required String userId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? avatarUrl,

    // Golf Australia Integration
    String? gaNumber,
    @Default(false) bool gaConnected,
    DateTime? gaLastSync,

    // Current Stats
    double? currentHandicap,
    @Default(1) int currentPhase,
    String? homeCourse,

    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

/// Extension for Player utilities
extension PlayerX on Player {
  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  String get phaseName {
    switch (currentPhase) {
      case 1:
        return 'Foundation';
      case 2:
        return 'Development';
      case 3:
        return 'Competition';
      case 4:
        return 'Recruitment';
      default:
        return 'Unknown';
    }
  }

  String get handicapDisplay {
    if (currentHandicap == null) return 'N/A';
    return currentHandicap!.toStringAsFixed(1);
  }
}
