import '/components/not_used_comps/message_item/message_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_model.dart';
import '/core/responsive_wrapper.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  static String routeName = 'chat';
  static String routePath = '/chat';

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText(
              'llh204cq' /* Page Title */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.openSans(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: ResponsiveWrapper(
          child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.messageItemModel1,
                  updateCallback: () => safeSetState(() {}),
                  child: MessageItemWidget(
                    sender: true,
                    messasge: 'hi i am sender. sender checked\n',
                    image:
                        'https://images.unsplash.com/photo-1557188969-16b469a5b6c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxiZWF1dGlmdWwlMjBvY2VhbnxlbnwwfHx8fDE2OTk0MzE1ODJ8MA&ixlib=rb-4.0.3&q=80&w=1080',
                    sendDate: getCurrentTimestamp,
                    hasAttachment: true,
                  ),
                ),
                wrapWithModel(
                  model: _model.messageItemModel2,
                  updateCallback: () => safeSetState(() {}),
                  child: MessageItemWidget(
                    sender: false,
                    messasge: 'hi i am reciver. sender is not cheched',
                    image:
                        'https://images.unsplash.com/photo-1633469924738-52101af51d87?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxsZWdvfGVufDB8fHx8MTY5OTQxOTA0OXww&ixlib=rb-4.0.3&q=80&w=1080',
                    sendDate: getCurrentTimestamp,
                    hasAttachment: false,
                  ),
                ),
                wrapWithModel(
                  model: _model.messageItemModel3,
                  updateCallback: () => safeSetState(() {}),
                  child: MessageItemWidget(
                    sender: false,
                    messasge: 'hi i am reciver. sender is not cheched',
                    image:
                        'https://images.unsplash.com/photo-1633469924738-52101af51d87?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxsZWdvfGVufDB8fHx8MTY5OTQxOTA0OXww&ixlib=rb-4.0.3&q=80&w=1080',
                    sendDate: getCurrentTimestamp,
                    hasAttachment: true,
                  ),
                ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
        ),
        ),
      ),
    );
  }
}
