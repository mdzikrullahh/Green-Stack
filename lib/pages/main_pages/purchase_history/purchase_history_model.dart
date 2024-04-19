import '/flutter_flow/flutter_flow_util.dart';
import 'purchase_history_widget.dart' show PurchaseHistoryWidget;
import 'package:flutter/material.dart';

class PurchaseHistoryModel extends FlutterFlowModel<PurchaseHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
