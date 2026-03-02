import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/theme.dart';
import '../../../auth/presentation/providers/player_provider.dart';
import '../providers/handicap_provider.dart';

/// WebView-based GA Connect screen for auto-syncing handicap from golf.com.au
class GAConnectWebViewScreen extends ConsumerStatefulWidget {
  const GAConnectWebViewScreen({super.key});

  @override
  ConsumerState<GAConnectWebViewScreen> createState() => _GAConnectWebViewScreenState();
}

class _GAConnectWebViewScreenState extends ConsumerState<GAConnectWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _isExtracting = false;
  String? _extractedHandicap;
  String? _extractedGaNumber;
  String? _errorMessage;

  // Golf Australia URLs
  static const String _loginUrl = 'https://www.golf.com.au/login';
  static const String _handicapUrl = 'https://www.golf.com.au/golfer/handicap';
  static const String _profileUrl = 'https://www.golf.com.au/golfer/profile';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _checkLoginStatus(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_loginUrl));
  }

  Future<void> _checkLoginStatus(String url) async {
    // Check if we're on a logged-in page (not login page)
    if (!url.contains('/login') && url.contains('golf.com.au/golfer')) {
      setState(() {
        _isLoggedIn = true;
      });

      // If on handicap or profile page, try to extract data
      if (url.contains('/handicap') || url.contains('/profile')) {
        await _extractHandicapData();
      }
    }
  }

  Future<void> _extractHandicapData() async {
    if (_isExtracting) return;

    setState(() {
      _isExtracting = true;
      _errorMessage = null;
    });

    try {
      // Navigate to handicap page if not already there
      final currentUrl = await _controller.currentUrl();
      if (currentUrl != null && !currentUrl.contains('/handicap')) {
        await _controller.loadRequest(Uri.parse(_handicapUrl));
        // Wait for page to load
        await Future.delayed(const Duration(seconds: 2));
      }

      // JavaScript to extract handicap index from the page
      // This targets common patterns on the Golf Australia handicap page
      final handicapResult = await _controller.runJavaScriptReturningResult('''
        (function() {
          // Try multiple selectors for handicap
          var handicapElements = [
            document.querySelector('.handicap-index'),
            document.querySelector('[data-handicap]'),
            document.querySelector('.current-handicap'),
            document.querySelector('.handicap-value'),
            document.querySelector('h1.handicap'),
            document.querySelector('.hero-handicap'),
          ];

          for (var el of handicapElements) {
            if (el) {
              var text = el.textContent || el.innerText || el.getAttribute('data-handicap');
              if (text) {
                // Extract number from text (e.g., "12.5" from "Handicap Index: 12.5")
                var match = text.match(/-?\\d+\\.?\\d*/);
                if (match) return match[0];
              }
            }
          }

          // Try finding any element with "handicap" and a number
          var allText = document.body.innerText;
          var handicapMatch = allText.match(/handicap[\\s:]+(-?\\d+\\.?\\d*)/i);
          if (handicapMatch) return handicapMatch[1];

          return null;
        })()
      ''');

      // JavaScript to extract GA Number
      final gaNumberResult = await _controller.runJavaScriptReturningResult('''
        (function() {
          // Try multiple selectors for GA Number
          var gaElements = [
            document.querySelector('.ga-number'),
            document.querySelector('[data-ga-number]'),
            document.querySelector('.golf-link-number'),
            document.querySelector('.member-number'),
          ];

          for (var el of gaElements) {
            if (el) {
              var text = el.textContent || el.innerText || el.getAttribute('data-ga-number');
              if (text) {
                var match = text.match(/\\d{6,}/);
                if (match) return match[0];
              }
            }
          }

          // Try finding Golf Link / GA number pattern
          var allText = document.body.innerText;
          var gaMatch = allText.match(/(?:golf\\s*link|ga\\s*number|member)[\\s:#]+([\\d]{6,})/i);
          if (gaMatch) return gaMatch[1];

          return null;
        })()
      ''');

      // Parse results
      String? handicap = _parseJsResult(handicapResult);
      String? gaNumber = _parseJsResult(gaNumberResult);

      setState(() {
        _extractedHandicap = handicap;
        _extractedGaNumber = gaNumber;
        _isExtracting = false;
      });

      if (handicap != null) {
        _showExtractedDataDialog(handicap, gaNumber);
      } else {
        setState(() {
          _errorMessage = 'Could not find handicap on page. Please navigate to your handicap page.';
        });
      }
    } catch (e) {
      setState(() {
        _isExtracting = false;
        _errorMessage = 'Error extracting data: $e';
      });
    }
  }

  String? _parseJsResult(Object result) {
    if (result == null) return null;
    String str = result.toString();
    if (str == 'null' || str.isEmpty) return null;
    // Remove quotes if present
    if (str.startsWith('"') && str.endsWith('"')) {
      str = str.substring(1, str.length - 1);
    }
    return str;
  }

  void _showExtractedDataDialog(String handicap, String? gaNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Handicap Found!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Handicap Index: $handicap'),
            if (gaNumber != null) Text('GA Number: $gaNumber'),
            const SizedBox(height: 16),
            const Text('Would you like to save this to your profile?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _saveHandicapData(handicap, gaNumber);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveHandicapData(String handicapStr, String? gaNumber) async {
    final handicap = double.tryParse(handicapStr);
    if (handicap == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid handicap value')),
      );
      return;
    }

    try {
      // Update player with GA info
      await ref.read(playerNotifierProvider.notifier).updateGAConnect(
        gaNumber: gaNumber ?? '',
        handicap: handicap,
      );

      // Add handicap entry
      await ref.read(handicapNotifierProvider.notifier).addHandicapEntry(
        handicapIndex: handicap,
        effectiveDate: DateTime.now(),
        source: 'ga_connect_auto',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Handicap ${handicap.toStringAsFixed(1)} saved successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context, true); // Return success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GA CONNECT'),
        actions: [
          if (_isLoggedIn)
            TextButton.icon(
              onPressed: _isExtracting ? null : _extractHandicapData,
              icon: _isExtracting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.sync, color: Colors.white),
              label: Text(
                _isExtracting ? 'Reading...' : 'Get Handicap',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_errorMessage != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.error,
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (!_isLoggedIn && !_isLoading)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.info,
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Log in to your Golf Australia account to sync your handicap',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _isLoggedIn
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _controller.loadRequest(Uri.parse(_handicapUrl));
                        },
                        icon: const Icon(Icons.golf_course),
                        label: const Text('Handicap'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _controller.loadRequest(Uri.parse(_profileUrl));
                        },
                        icon: const Icon(Icons.person),
                        label: const Text('Profile'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isExtracting ? null : _extractHandicapData,
                        icon: const Icon(Icons.sync),
                        label: const Text('Sync'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
