// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import '/backend/schema/structs/portfolio_item_struct.dart';
import '/backend/schema/util/schema_util.dart';

class PortfolioSectionStruct extends BaseStruct {
  PortfolioSectionStruct({
    String? key,
    String? title,
    String? sectionLabel,
    int? order,
    List<PortfolioItemStruct>? items,
  })  : _key = key,
        _title = title,
        _sectionLabel = sectionLabel,
        _order = order,
        _items = items;

  String? _key;
  String get key => _key ?? '';
  set key(String? val) => _key = val;
  bool hasKey() => _key != null;

  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  String? _sectionLabel;
  String get sectionLabel => _sectionLabel ?? '';
  set sectionLabel(String? val) => _sectionLabel = val;
  bool hasSectionLabel() => _sectionLabel != null;

  int? _order;
  int get order => _order ?? 0;
  set order(int? val) => _order = val;
  bool hasOrder() => _order != null;

  List<PortfolioItemStruct>? _items;
  List<PortfolioItemStruct> get items => _items ?? const [];
  set items(List<PortfolioItemStruct>? val) => _items = val;
  void updateItems(Function(List<PortfolioItemStruct>) updateFn) {
    updateFn(_items ??= []);
  }

  bool hasItems() => _items != null && _items!.isNotEmpty;

  static PortfolioSectionStruct fromMap(Map<String, dynamic> data) =>
      PortfolioSectionStruct(
        key: data['key'] as String?,
        title: data['title'] as String?,
        sectionLabel: data['sectionLabel'] as String?,
        order: data['order'] as int?,
        items: getStructList(
          data['items'],
          PortfolioItemStruct.fromMap,
        ),
      );

  static PortfolioSectionStruct? maybeFromMap(dynamic data) => data is Map
      ? PortfolioSectionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'key': _key,
        'title': _title,
        'sectionLabel': _sectionLabel,
        'order': _order,
        'items': _items?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'key': serializeParam(
          _key,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'sectionLabel': serializeParam(
          _sectionLabel,
          ParamType.String,
        ),
        'order': serializeParam(
          _order,
          ParamType.int,
        ),
        'items': serializeParam(
          _items,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static PortfolioSectionStruct fromSerializableMap(Map<String, dynamic> data) =>
      PortfolioSectionStruct(
        key: deserializeParam(
          data['key'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        sectionLabel: deserializeParam(
          data['sectionLabel'],
          ParamType.String,
          false,
        ),
        order: deserializeParam(
          data['order'],
          ParamType.int,
          false,
        ),
        items: deserializeStructParam<PortfolioItemStruct>(
          data['items'],
          ParamType.DataStruct,
          true,
          structBuilder: PortfolioItemStruct.fromSerializableMap,
        ),
      );

  Map<String, dynamic> toJson() => toSerializableMap();

  @override
  String toString() => 'PortfolioSectionStruct(${jsonEncode(toMap())})';

  @override
  bool operator ==(Object other) {
    return other is PortfolioSectionStruct &&
        key == other.key &&
        title == other.title &&
        sectionLabel == other.sectionLabel &&
        order == other.order &&
        const ListEquality().equals(items, other.items);
  }

  @override
  int get hashCode => const ListEquality().hash([
        key,
        title,
        sectionLabel,
        order,
        items,
      ]);
}

PortfolioSectionStruct createPortfolioSectionStruct({
  String? key,
  String? title,
  String? sectionLabel,
  int? order,
  List<PortfolioItemStruct>? items,
}) =>
    PortfolioSectionStruct(
      key: key,
      title: title,
      sectionLabel: sectionLabel,
      order: order,
      items: items,
    );
