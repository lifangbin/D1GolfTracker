import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../auth/presentation/providers/player_provider.dart';
import '../providers/handicap_provider.dart';
import '../screens/ga_connect_webview_screen.dart';

/// Dialog for connecting to Golf Australia (GA CONNECT)
/// Offers both WebView auto-sync and manual entry options
class GAConnectDialog extends ConsumerStatefulWidget {
  const GAConnectDialog({super.key});

  @override
  ConsumerState<GAConnectDialog> createState() => _GAConnectDialogState();
}

class _GAConnectDialogState extends ConsumerState<GAConnectDialog> {
  final _formKey = GlobalKey<FormState>();
  final _gaNumberController = TextEditingController();
  final _handicapController = TextEditingController();
  bool _isLoading = false;
  bool _showManualEntry = false;

  @override
  void dispose() {
    _gaNumberController.dispose();
    _handicapController.dispose();
    super.dispose();
  }

  Future<void> _openWebView() async {
    Navigator.pop(context); // Close dialog first

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const GAConnectWebViewScreen(),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('GA CONNECT synced successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _connectManually() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final gaNumber = _gaNumberController.text.trim();
      final handicap = double.tryParse(_handicapController.text.trim());

      if (handicap == null) {
        _showError('Please enter a valid handicap');
        return;
      }

      // Update player with GA info
      final playerNotifier = ref.read(playerNotifierProvider.notifier);
      await playerNotifier.updateGAConnect(
        gaNumber: gaNumber,
        handicap: handicap,
      );

      // Add handicap entry
      await ref.read(handicapNotifierProvider.notifier).addHandicapEntry(
        handicapIndex: handicap,
        effectiveDate: DateTime.now(),
        source: 'ga_connect_manual',
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('GA CONNECT linked! Handicap: ${handicap.toStringAsFixed(1)}'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      _showError('Failed to connect: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: _showManualEntry ? _buildManualEntryForm() : _buildConnectionOptions(),
      ),
    );
  }

  Widget _buildConnectionOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(
                Icons.sports_golf,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connect GA CONNECT',
                    style: AppTextStyles.titleLarge,
                  ),
                  Text(
                    'Sync your Golf Australia handicap',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),

        // Auto-sync option (recommended)
        _ConnectionOption(
          icon: Icons.sync,
          title: 'Auto-Sync (Recommended)',
          description: 'Log in to golf.com.au and we\'ll automatically read your handicap',
          isRecommended: true,
          onTap: _openWebView,
        ),
        const SizedBox(height: AppSpacing.md),

        // Manual entry option
        _ConnectionOption(
          icon: Icons.edit,
          title: 'Manual Entry',
          description: 'Enter your GA Number and handicap manually',
          isRecommended: false,
          onTap: () {
            setState(() {
              _showManualEntry = true;
            });
          },
        ),
        const SizedBox(height: AppSpacing.lg),

        // Info
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.info, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Your login credentials are never stored. We only read your handicap from the page.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildManualEntryForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _showManualEntry = false;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'Manual Entry',
                  style: AppTextStyles.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Info box
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.info.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Enter your details from golf.com.au',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // GA Number field
          TextFormField(
            controller: _gaNumberController,
            decoration: const InputDecoration(
              labelText: 'GA Number',
              hintText: 'e.g., 12345678',
              prefixIcon: Icon(Icons.badge),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your GA Number';
              }
              if (value.length < 6) {
                return 'GA Number should be at least 6 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),

          // Handicap field
          TextFormField(
            controller: _handicapController,
            decoration: const InputDecoration(
              labelText: 'Current Handicap Index',
              hintText: 'e.g., 12.5',
              prefixIcon: Icon(Icons.golf_course),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your handicap';
              }
              final handicap = double.tryParse(value);
              if (handicap == null) {
                return 'Please enter a valid number';
              }
              if (handicap < -10 || handicap > 54) {
                return 'Handicap must be between -10 and 54';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  isOutlined: true,
                  onPressed: () {
                    setState(() {
                      _showManualEntry = false;
                    });
                  },
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  isLoading: _isLoading,
                  onPressed: _connectManually,
                  child: const Text('Connect'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConnectionOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isRecommended;
  final VoidCallback onTap;

  const _ConnectionOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.isRecommended,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: isRecommended ? AppColors.primary : AppColors.textHint,
            width: isRecommended ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          color: isRecommended ? AppColors.primary.withValues(alpha: 0.05) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isRecommended
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                icon,
                color: isRecommended ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: isRecommended ? AppColors.primary : null,
                        ),
                      ),
                      if (isRecommended) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'BEST',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isRecommended ? AppColors.primary : AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}
