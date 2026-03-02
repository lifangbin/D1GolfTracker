import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../data/course_database.dart';

/// A search field with autocomplete for golf courses
/// Uses local Australian golf course database
class CourseSearchField extends StatefulWidget {
  final Function(Map<String, dynamic> course) onCourseSelected;
  final String? initialValue;
  final String? label;
  final String? hint;

  const CourseSearchField({
    super.key,
    required this.onCourseSelected,
    this.initialValue,
    this.label,
    this.hint,
  });

  @override
  State<CourseSearchField> createState() => _CourseSearchFieldState();
}

class _CourseSearchFieldState extends State<CourseSearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;
  List<Map<String, dynamic>> _searchResults = [];
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Delay to allow tap on result
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() => _showDropdown = false);
        }
      });
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    if (query.length < 2) {
      setState(() {
        _searchResults = [];
        _showDropdown = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;

      final results = CourseDatabase.searchCourses(query);

      setState(() {
        _searchResults = results;
        _showDropdown = results.isNotEmpty;
      });
    });
  }

  void _selectCourse(Map<String, dynamic> course) {
    _controller.text = course['name'] as String;
    setState(() {
      _showDropdown = false;
      _searchResults = [];
    });
    _focusNode.unfocus();
    widget.onCourseSelected(course);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            labelText: widget.label ?? 'Course Name',
            hintText: widget.hint ?? 'Search for a golf course...',
            filled: true,
            fillColor: AppColors.surface,
            prefixIcon: const Icon(Icons.golf_course_outlined),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _searchResults = [];
                        _showDropdown = false;
                      });
                    },
                  )
                : const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.textHint),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.textHint),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          textCapitalization: TextCapitalization.words,
        ),

        // Search results dropdown
        if (_showDropdown && _searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final course = _searchResults[index];
                return _CourseResultTile(
                  course: course,
                  onTap: () => _selectCourse(course),
                );
              },
            ),
          ),

        // Help text
        if (!_showDropdown)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Type to search Australian golf courses. Par, slope & rating will auto-fill.',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}

class _CourseResultTile extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback onTap;

  const _CourseResultTile({
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = course['name'] as String;
    final city = course['city'] as String;
    final state = course['state'] as String;
    final par = course['par'] as int;
    final slope = course['slope'] as int;
    final rating = course['rating'] as double;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.surfaceVariant),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.golf_course,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$city, $state',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Course details
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Par $par',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Slope $slope · CR ${rating.toStringAsFixed(1)}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
