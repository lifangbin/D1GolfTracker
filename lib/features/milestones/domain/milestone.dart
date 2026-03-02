import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'milestone.freezed.dart';
part 'milestone.g.dart';

/// Categories of milestones for junior golfers
enum MilestoneCategory {
  handicap,
  tournament,
  training,
  skill,
  academic,
  recruiting,
}

/// A milestone definition (pre-defined per phase)
@freezed
class MilestoneDefinition with _$MilestoneDefinition {
  const factory MilestoneDefinition({
    required String id,
    required String title,
    required String description,
    required int phase,
    required MilestoneCategory category,
    required int sortOrder,
    String? targetValue,
    String? unit,
  }) = _MilestoneDefinition;

  factory MilestoneDefinition.fromJson(Map<String, dynamic> json) =>
      _$MilestoneDefinitionFromJson(json);
}

/// A player's progress on a milestone
@freezed
class PlayerMilestone with _$PlayerMilestone {
  const factory PlayerMilestone({
    required String id,
    required String playerId,
    required String milestoneId,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    String? notes,
    String? mediaUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PlayerMilestone;

  factory PlayerMilestone.fromJson(Map<String, dynamic> json) =>
      _$PlayerMilestoneFromJson(json);
}

/// Combined view of milestone + player progress
@freezed
class MilestoneWithProgress with _$MilestoneWithProgress {
  const MilestoneWithProgress._();

  const factory MilestoneWithProgress({
    required MilestoneDefinition definition,
    PlayerMilestone? progress,
  }) = _MilestoneWithProgress;

  bool get isCompleted => progress?.isCompleted ?? false;
  DateTime? get completedAt => progress?.completedAt;
  String? get notes => progress?.notes;
}

/// Extension for MilestoneCategory
extension MilestoneCategoryX on MilestoneCategory {
  String get label {
    switch (this) {
      case MilestoneCategory.handicap:
        return 'Handicap';
      case MilestoneCategory.tournament:
        return 'Tournament';
      case MilestoneCategory.training:
        return 'Training';
      case MilestoneCategory.skill:
        return 'Skill';
      case MilestoneCategory.academic:
        return 'Academic';
      case MilestoneCategory.recruiting:
        return 'Recruiting';
    }
  }

  IconData get icon {
    switch (this) {
      case MilestoneCategory.handicap:
        return Icons.golf_course;
      case MilestoneCategory.tournament:
        return Icons.emoji_events;
      case MilestoneCategory.training:
        return Icons.fitness_center;
      case MilestoneCategory.skill:
        return Icons.sports_golf;
      case MilestoneCategory.academic:
        return Icons.school;
      case MilestoneCategory.recruiting:
        return Icons.connect_without_contact;
    }
  }

  Color get color {
    switch (this) {
      case MilestoneCategory.handicap:
        return const Color(0xFF4CAF50);
      case MilestoneCategory.tournament:
        return const Color(0xFFFF9800);
      case MilestoneCategory.training:
        return const Color(0xFF2196F3);
      case MilestoneCategory.skill:
        return const Color(0xFF9C27B0);
      case MilestoneCategory.academic:
        return const Color(0xFF607D8B);
      case MilestoneCategory.recruiting:
        return const Color(0xFFE91E63);
    }
  }
}

/// Pre-defined milestones for each phase
class PhaseMilestones {
  static const List<MilestoneDefinition> all = [
    // ============ Phase 1: Foundation (Ages 8-11) ============
    MilestoneDefinition(
      id: 'p1_handicap_36',
      title: 'Reach Handicap 36',
      description: 'Get your first official handicap under 36',
      phase: 1,
      category: MilestoneCategory.handicap,
      sortOrder: 1,
      targetValue: '36',
    ),
    MilestoneDefinition(
      id: 'p1_first_9',
      title: 'Complete First 9 Holes',
      description: 'Play your first full 9-hole round',
      phase: 1,
      category: MilestoneCategory.tournament,
      sortOrder: 2,
    ),
    MilestoneDefinition(
      id: 'p1_first_18',
      title: 'Complete First 18 Holes',
      description: 'Play your first full 18-hole round',
      phase: 1,
      category: MilestoneCategory.tournament,
      sortOrder: 3,
    ),
    MilestoneDefinition(
      id: 'p1_junior_clinic',
      title: 'Join Junior Clinic',
      description: 'Enroll in a junior golf development program',
      phase: 1,
      category: MilestoneCategory.training,
      sortOrder: 4,
    ),
    MilestoneDefinition(
      id: 'p1_rules_basics',
      title: 'Learn Basic Rules',
      description: 'Pass a basic golf rules quiz',
      phase: 1,
      category: MilestoneCategory.skill,
      sortOrder: 5,
    ),
    MilestoneDefinition(
      id: 'p1_first_event',
      title: 'First Junior Event',
      description: 'Compete in your first junior golf event',
      phase: 1,
      category: MilestoneCategory.tournament,
      sortOrder: 6,
    ),

    // ============ Phase 2: Development (Ages 12-14) ============
    MilestoneDefinition(
      id: 'p2_handicap_18',
      title: 'Reach Handicap 18',
      description: 'Lower your handicap to 18 or below',
      phase: 2,
      category: MilestoneCategory.handicap,
      sortOrder: 1,
      targetValue: '18',
    ),
    MilestoneDefinition(
      id: 'p2_handicap_10',
      title: 'Reach Handicap 10',
      description: 'Lower your handicap to 10 or below',
      phase: 2,
      category: MilestoneCategory.handicap,
      sortOrder: 2,
      targetValue: '10',
    ),
    MilestoneDefinition(
      id: 'p2_club_champ',
      title: 'Junior Club Championship',
      description: 'Compete in your club junior championship',
      phase: 2,
      category: MilestoneCategory.tournament,
      sortOrder: 3,
    ),
    MilestoneDefinition(
      id: 'p2_district_event',
      title: 'District Level Event',
      description: 'Qualify for and compete at district level',
      phase: 2,
      category: MilestoneCategory.tournament,
      sortOrder: 4,
    ),
    MilestoneDefinition(
      id: 'p2_private_coach',
      title: 'Private Coaching',
      description: 'Start working with a private golf coach',
      phase: 2,
      category: MilestoneCategory.training,
      sortOrder: 5,
    ),
    MilestoneDefinition(
      id: 'p2_practice_routine',
      title: 'Establish Practice Routine',
      description: 'Create and follow a structured practice plan',
      phase: 2,
      category: MilestoneCategory.training,
      sortOrder: 6,
    ),
    MilestoneDefinition(
      id: 'p2_break_80',
      title: 'Break 80',
      description: 'Score under 80 for the first time',
      phase: 2,
      category: MilestoneCategory.skill,
      sortOrder: 7,
      targetValue: '79',
    ),

    // ============ Phase 3: Competition (Ages 15-16) ============
    MilestoneDefinition(
      id: 'p3_handicap_5',
      title: 'Reach Handicap 5',
      description: 'Lower your handicap to 5 or below',
      phase: 3,
      category: MilestoneCategory.handicap,
      sortOrder: 1,
      targetValue: '5',
    ),
    MilestoneDefinition(
      id: 'p3_handicap_scratch',
      title: 'Reach Scratch',
      description: 'Achieve a scratch handicap (0 or below)',
      phase: 3,
      category: MilestoneCategory.handicap,
      sortOrder: 2,
      targetValue: '0',
    ),
    MilestoneDefinition(
      id: 'p3_state_event',
      title: 'State Level Event',
      description: 'Compete at state championship level',
      phase: 3,
      category: MilestoneCategory.tournament,
      sortOrder: 3,
    ),
    MilestoneDefinition(
      id: 'p3_national_qual',
      title: 'National Qualifier',
      description: 'Qualify for a national junior event',
      phase: 3,
      category: MilestoneCategory.tournament,
      sortOrder: 4,
    ),
    MilestoneDefinition(
      id: 'p3_top_10',
      title: 'Top 10 Finish',
      description: 'Finish top 10 in a regional or state event',
      phase: 3,
      category: MilestoneCategory.tournament,
      sortOrder: 5,
    ),
    MilestoneDefinition(
      id: 'p3_fitness_program',
      title: 'Golf Fitness Program',
      description: 'Start a golf-specific fitness training program',
      phase: 3,
      category: MilestoneCategory.training,
      sortOrder: 6,
    ),
    MilestoneDefinition(
      id: 'p3_mental_coaching',
      title: 'Mental Game Coaching',
      description: 'Work with a sports psychologist or mental coach',
      phase: 3,
      category: MilestoneCategory.training,
      sortOrder: 7,
    ),
    MilestoneDefinition(
      id: 'p3_break_par',
      title: 'Break Par',
      description: 'Score under par for the first time',
      phase: 3,
      category: MilestoneCategory.skill,
      sortOrder: 8,
    ),

    // ============ Phase 4: Recruitment (Ages 17-18) ============
    MilestoneDefinition(
      id: 'p4_handicap_plus',
      title: 'Plus Handicap',
      description: 'Achieve a plus handicap (below scratch)',
      phase: 4,
      category: MilestoneCategory.handicap,
      sortOrder: 1,
      targetValue: '-1',
    ),
    MilestoneDefinition(
      id: 'p4_national_event',
      title: 'National Event',
      description: 'Compete at national championship level',
      phase: 4,
      category: MilestoneCategory.tournament,
      sortOrder: 2,
    ),
    MilestoneDefinition(
      id: 'p4_tournament_win',
      title: 'Tournament Win',
      description: 'Win a significant junior tournament',
      phase: 4,
      category: MilestoneCategory.tournament,
      sortOrder: 3,
    ),
    MilestoneDefinition(
      id: 'p4_college_contact',
      title: 'College Coach Contact',
      description: 'Establish contact with a D1 college coach',
      phase: 4,
      category: MilestoneCategory.recruiting,
      sortOrder: 4,
    ),
    MilestoneDefinition(
      id: 'p4_campus_visit',
      title: 'Campus Visit',
      description: 'Complete an official campus visit',
      phase: 4,
      category: MilestoneCategory.recruiting,
      sortOrder: 5,
    ),
    MilestoneDefinition(
      id: 'p4_ncaa_clearinghouse',
      title: 'NCAA Clearinghouse',
      description: 'Complete NCAA Eligibility Center registration',
      phase: 4,
      category: MilestoneCategory.academic,
      sortOrder: 6,
    ),
    MilestoneDefinition(
      id: 'p4_sat_act',
      title: 'SAT/ACT Score',
      description: 'Achieve required SAT/ACT scores for eligibility',
      phase: 4,
      category: MilestoneCategory.academic,
      sortOrder: 7,
    ),
    MilestoneDefinition(
      id: 'p4_gpa_3_0',
      title: 'GPA 3.0+',
      description: 'Maintain a GPA of 3.0 or higher',
      phase: 4,
      category: MilestoneCategory.academic,
      sortOrder: 8,
      targetValue: '3.0',
    ),
    MilestoneDefinition(
      id: 'p4_scholarship_offer',
      title: 'Scholarship Offer',
      description: 'Receive a golf scholarship offer',
      phase: 4,
      category: MilestoneCategory.recruiting,
      sortOrder: 9,
    ),
    MilestoneDefinition(
      id: 'p4_commit',
      title: 'College Commitment',
      description: 'Commit to a college golf program',
      phase: 4,
      category: MilestoneCategory.recruiting,
      sortOrder: 10,
    ),
  ];

  static List<MilestoneDefinition> forPhase(int phase) {
    return all.where((m) => m.phase == phase).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  static List<MilestoneDefinition> forPhaseAndCategory(
    int phase,
    MilestoneCategory category,
  ) {
    return all
        .where((m) => m.phase == phase && m.category == category)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  static MilestoneDefinition? byId(String id) {
    try {
      return all.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  static String phaseName(int phase) {
    switch (phase) {
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

  static String phaseAgeRange(int phase) {
    switch (phase) {
      case 1:
        return 'Ages 8-11';
      case 2:
        return 'Ages 12-14';
      case 3:
        return 'Ages 15-16';
      case 4:
        return 'Ages 17-18';
      default:
        return '';
    }
  }
}
