import 'package:collection/collection.dart';

enum UserType {
  Student,
  Professor_General,
  Admin,
  Professor_Main,
}

enum DashboardViewType {
  dash_overview,
  dash_classes,
  dash_detail,
}

enum PortfolioType {
  portfolio,
  midtermResult,
  finalResult,
}

enum PortfolioViewType {
  portfolio_overview,
  portfolio_classes,
  portfolio_portfolioType,
  portfolio_chooseWeek,
  portfolio_detail,
  portfolio_evaluate,
}

enum StudentSubmitViewType {
  overview,
  selectType,
  selectClass,
  classDetail,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (UserType):
      return UserType.values.deserialize(value) as T?;
    case (DashboardViewType):
      return DashboardViewType.values.deserialize(value) as T?;
    case (PortfolioType):
      return PortfolioType.values.deserialize(value) as T?;
    case (PortfolioViewType):
      return PortfolioViewType.values.deserialize(value) as T?;
    case (StudentSubmitViewType):
      return StudentSubmitViewType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
