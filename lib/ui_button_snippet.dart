import 'package:flutter/material.dart';

// Import the custom action we just created
import 'custom_code/actions/custom_merge_and_download.dart';

/// This is a sample widget demonstrating how to call the PDF merge actions.
/// It uses standard Flutter widgets.
class PortfolioDownloadButton extends StatefulWidget {
  // Pass the selected class ID to this widget
  final String selectedClassId;

  const PortfolioDownloadButton({Key? key, required this.selectedClassId}) : super(key: key);

  @override
  _PortfolioDownloadButtonState createState() => _PortfolioDownloadButtonState();
}

class _PortfolioDownloadButtonState extends State<PortfolioDownloadButton> {
  bool _isLoading = false;

  Future<void> _downloadPortfolio() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await generateAndDownloadPortfolio(
        classId: widget.selectedClassId,
        // TODO: Replace with your actual cover URLs
        firstCoverUrl: 'https://your-storage.com/covers/first_cover.pdf',
        lastCoverUrl: 'https://your-storage.com/covers/last_cover.pdf',
      );

      // Show success message if still mounted
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF 다운로드 완료!')),
      );
    } catch (e) {
      // Show error message if still mounted
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다운로드 실패: ${e.toString()}')),
      );
    } finally {
      // Hide loading dialog and reset button state
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: _isLoading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Icon(Icons.download),
      label: Text(_isLoading ? '처리 중...' : '전체 자료 다운로드'),
      onPressed: _downloadPortfolio,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF284E75),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
}
