import 'package:freezed_annotation/freezed_annotation.dart';

part 'handicap_entry.freezed.dart';
part 'handicap_entry.g.dart';

/// Represents a handicap history entry
@freezed
class HandicapEntry with _$HandicapEntry {
  const factory HandicapEntry({
    required String id,
    required String playerId,
    required double handicapIndex,
    double? lowHandicap,
    required DateTime effectiveDate,
    @Default('manual') String source, // 'ga_connect', 'manual', 'calculated'
    int? roundsCounted,
    DateTime? createdAt,
  }) = _HandicapEntry;

  factory HandicapEntry.fromJson(Map<String, dynamic> json) =>
      _$HandicapEntryFromJson(json);
}

/// Extension for HandicapEntry utilities
extension HandicapEntryX on HandicapEntry {
  String get handicapDisplay => handicapIndex.toStringAsFixed(1);

  String get sourceDisplay {
    switch (source) {
      case 'ga_connect':
        return 'GA Connect';
      case 'manual':
        return 'Manual';
      case 'calculated':
        return 'Calculated';
      default:
        return source;
    }
  }

  bool get isFromGAConnect => source == 'ga_connect';
}
