import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Import the custom actions to be used
import '/custom_code/actions/custom_merge_and_download.dart';

/// This is a sample widget demonstrating how to call the PDF merge actions.
/// The user should integrate this logic into their existing UI.
class PdfDownloadButton extends StatefulWidget {
  // Pass the selected class ID to this widget
  final String selectedClassId;

  const PdfDownloadButton({Key? key, required this.selectedClassId}) : super(key: key);

  @override
  _PdfDownloadButtonState createState() => _PdfDownloadButtonState();
}

class _PdfDownloadButtonState extends State<PdfDownloadButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: _isLoading ? null : () async {
        setState(() => _isLoading = true);

        // Show a loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        try {
          // 1. Get all document URLs for the selected class
          final documentUrls = await getClassDocuments(widget.selectedClassId);

          if (documentUrls.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('다운로드할 문서가 없습니다.')),
            );
            return; // Exit if no documents are found
          }

          // 2. Prepare the PDF list for merging (including covers)
          await mergePdfs(
            'https://your-storage.com/covers/first_cover.pdf', // TODO: Replace with actual first cover URL
            documentUrls,
            'https://your-storage.com/covers/last_cover.pdf'  // TODO: Replace with actual last cover URL
          );

          // 3. Perform the merge and download
          await mergeAndDownloadPdf(FFAppState().mergepdfs);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PDF 다운로드 완료!')),
          );
        } catch (e) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('다운로드 실패: $e')),
          );
        } finally {
          // Hide loading dialog and reset button state
          Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
          if (mounted) {
            setState(() => _isLoading = false);
          }
        }
      },
      text: _isLoading ? '처리 중...' : '전체 자료 다운로드',
      options: FFButtonOptions(
        width: 200,
        height: 50,
        color: _isLoading ? Colors.grey : Color(0xFF284E75),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
