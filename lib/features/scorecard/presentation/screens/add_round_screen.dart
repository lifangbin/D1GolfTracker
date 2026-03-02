import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../course_search/presentation/widgets/course_search_field.dart';
import '../../../handicap/presentation/providers/handicap_provider.dart';
import '../../../tournaments/presentation/providers/tournament_provider.dart';
import '../providers/scorecard_provider.dart';
import '../widgets/hole_entry_card.dart';
import '../widgets/scorecard_summary.dart';

class AddRoundScreen extends ConsumerStatefulWidget {
  final String? tournamentId;
  final String? tournamentName;
  final String? courseName;
  final int? coursePar;
  final double? courseSlope;
  final double? courseRating;
  final int roundNumber;

  const AddRoundScreen({
    super.key,
    this.tournamentId,
    this.tournamentName,
    this.courseName,
    this.coursePar,
    this.courseSlope,
    this.courseRating,
    this.roundNumber = 1,
  });

  @override
  ConsumerState<AddRoundScreen> createState() => _AddRoundScreenState();
}

class _AddRoundScreenState extends ConsumerState<AddRoundScreen> {
  final _pageController = PageController();
  final _handicapController = TextEditingController();
  int _currentPage = 0; // 0 = course info, 1 = front 9, 2 = back 9, 3 = summary
  Map<String, dynamic>? _selectedCourse;
  bool _handicapInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the scorecard entry provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(scorecardEntryProvider.notifier);
      if (widget.tournamentId != null) {
        notifier.initForTournament(
          tournamentId: widget.tournamentId!,
          courseName: widget.courseName ?? '',
          coursePar: widget.coursePar,
          courseSlope: widget.courseSlope,
          courseRating: widget.courseRating,
          roundNumber: widget.roundNumber,
        );
      } else {
        notifier.initForPractice(
          courseName: widget.courseName,
          coursePar: widget.coursePar,
          courseSlope: widget.courseSlope,
          courseRating: widget.courseRating,
        );
      }
      // Set standard pars as default
      notifier.setStandardPars();

      // Set default handicap from GA
      _initDefaultHandicap();
    });
  }

  Future<void> _initDefaultHandicap() async {
    if (_handicapInitialized) return;
    _handicapInitialized = true;

    final currentHandicap = await ref.read(currentHandicapProvider.future);
    if (currentHandicap != null && mounted) {
      _handicapController.text = currentHandicap.handicapIndex.toStringAsFixed(1);
      ref.read(scorecardEntryProvider.notifier).setPlayingHandicap(currentHandicap.handicapIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _handicapController.dispose();
    super.dispose();
  }

  void _onCourseSelected(Map<String, dynamic> course) {
    setState(() {
      _selectedCourse = course;
    });
    ref.read(scorecardEntryProvider.notifier).setCourseInfo(
      courseName: course['name'] as String,
      coursePar: course['par'] as int,
      courseSlope: (course['slope'] as int).toDouble(),
      courseRating: course['rating'] as double,
    );
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _saveRound() async {
    final round = await ref.read(scorecardEntryProvider.notifier).saveRound();
    if (round != null && mounted) {
      // Invalidate the tournament providers to refresh the data
      if (widget.tournamentId != null) {
        ref.invalidate(tournamentRoundsProvider(widget.tournamentId!));
        ref.invalidate(tournamentWithStatsProvider(widget.tournamentId!));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Round saved successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scorecardEntryProvider);
    final title = widget.tournamentName != null
        ? 'Round ${widget.roundNumber} - ${widget.tournamentName}'
        : 'Add Practice Round';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (_currentPage == 3)
            TextButton(
              onPressed: state.isLoading || !state.isComplete ? null : _saveRound,
              child: state.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(),

          // Error message
          if (state.error != null)
            Container(
              margin: const EdgeInsets.all(AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.error!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Page view
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildCourseInfoPage(state),
                _buildHolesPage(state, 1, 9), // Front 9
                _buildHolesPage(state, 10, 18), // Back 9
                _buildSummaryPage(state),
              ],
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(state),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final pages = ['Course', 'Front 9', 'Back 9', 'Summary'];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: AppColors.surface,
      child: Row(
        children: pages.asMap().entries.map((entry) {
          final index = entry.key;
          final isActive = index == _currentPage;
          final isCompleted = index < _currentPage;

          return Expanded(
            child: Row(
              children: [
                if (index > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted || isActive
                          ? AppColors.primary
                          : AppColors.textHint,
                    ),
                  ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isActive
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                if (index < pages.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted
                          ? AppColors.primary
                          : AppColors.textHint,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCourseInfoPage(ScorecardEntryState state) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Information', style: AppTextStyles.titleLarge),
          const SizedBox(height: AppSpacing.md),

          // Course search
          CourseSearchField(
            onCourseSelected: _onCourseSelected,
            initialValue: state.courseName,
            label: 'Course Name',
            hint: 'Search for a golf course...',
          ),
          const SizedBox(height: AppSpacing.md),

          // Show selected course info
          if (_selectedCourse != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.primaryLight.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedCourse!['name'] as String,
                          style: AppTextStyles.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Par ${_selectedCourse!['par']} · Slope ${_selectedCourse!['slope']} · CR ${(_selectedCourse!['rating'] as double).toStringAsFixed(1)}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Date picker
          Text('Round Date', style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: state.roundDate,
                firstDate: DateTime(2010),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppColors.primary,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                ref.read(scorecardEntryProvider.notifier).setRoundDate(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.textHint),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text(
                    DateFormat('EEEE, dd MMMM yyyy').format(state.roundDate),
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Playing Handicap
          Text('Playing Handicap', style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _handicapController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Enter handicap',
                    prefixIcon: const Icon(Icons.sports_golf, color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: const BorderSide(color: AppColors.textHint),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: const BorderSide(color: AppColors.textHint),
                    ),
                    suffixText: state.playingHandicap != null ? 'GA' : null,
                    suffixStyle: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  onChanged: (value) {
                    final handicap = double.tryParse(value);
                    ref.read(scorecardEntryProvider.notifier).setPlayingHandicap(handicap);
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () async {
                  final currentHandicap = await ref.read(currentHandicapProvider.future);
                  if (currentHandicap != null && mounted) {
                    _handicapController.text = currentHandicap.handicapIndex.toStringAsFixed(1);
                    ref.read(scorecardEntryProvider.notifier).setPlayingHandicap(currentHandicap.handicapIndex);
                  }
                },
                icon: const Icon(Icons.refresh, color: AppColors.primary),
                tooltip: 'Reset to GA Handicap',
              ),
            ],
          ),
          if (state.playingHandicap != null) ...[
            const SizedBox(height: 4),
            Text(
              'Net score will be calculated: Gross - ${state.playingHandicap!.round()} strokes',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),

          // Current totals preview
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Par', '${state.coursePar}'),
                _buildStatItem('Slope', state.courseSlope?.toStringAsFixed(0) ?? '-'),
                _buildStatItem('Rating', state.courseRating?.toStringAsFixed(1) ?? '-'),
                _buildStatItem('HCP', state.playingHandicap?.toStringAsFixed(1) ?? '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.labelSmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHolesPage(ScorecardEntryState state, int startHole, int endHole) {
    final holes = state.holes
        .where((h) => h.holeNumber >= startHole && h.holeNumber <= endHole)
        .toList();

    final isFirstNine = startHole == 1;
    final total = isFirstNine ? state.frontNineStrokes : state.backNineStrokes;
    final par = holes.fold(0, (sum, h) => sum + h.par);

    return Column(
      children: [
        // Holes header with totals
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          color: AppColors.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isFirstNine ? 'Front Nine' : 'Back Nine',
                style: AppTextStyles.titleMedium,
              ),
              Row(
                children: [
                  Text(
                    'Par $par',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      '$total',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Holes list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: holes.length,
            itemBuilder: (context, index) {
              final hole = holes[index];
              return HoleEntryCard(
                holeData: hole,
                onStrokesChanged: (strokes) {
                  ref.read(scorecardEntryProvider.notifier)
                      .setHoleScore(hole.holeNumber, strokes);
                },
                onPuttsChanged: (putts) {
                  ref.read(scorecardEntryProvider.notifier)
                      .setHolePutts(hole.holeNumber, putts);
                },
                onParChanged: (par) {
                  ref.read(scorecardEntryProvider.notifier)
                      .setHolePar(hole.holeNumber, par);
                },
                onFairwayChanged: (hit) {
                  ref.read(scorecardEntryProvider.notifier)
                      .setHoleFairway(hole.holeNumber, hit);
                },
                onGIRChanged: (gir) {
                  ref.read(scorecardEntryProvider.notifier)
                      .setHoleGIR(hole.holeNumber, gir);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryPage(ScorecardEntryState state) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: ScorecardSummary(state: state),
    );
  }

  Widget _buildNavigationButtons(ScorecardEntryState state) {
    return Container(
      padding: AppSpacing.screenPadding,
      color: AppColors.surface,
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousPage,
                child: const Text('Previous'),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _currentPage < 3
                ? AppButton(
                    onPressed: _nextPage,
                    child: const Text('Next'),
                  )
                : AppButton(
                    onPressed: state.isLoading || !state.isComplete
                        ? null
                        : _saveRound,
                    isLoading: state.isLoading,
                    child: const Text('Save Round'),
                  ),
          ),
        ],
      ),
    );
  }
}
