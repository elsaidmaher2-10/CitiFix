import 'package:citifix/feature/citzenFeature/achivement/data/Achievment/achievementModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/ReportResponseModel.dart';

abstract class ReportManagerState {}

class ReportManagerInitial extends ReportManagerState {}

class GetReportsLoading extends ReportManagerState {}

class GetReportsSuccess extends ReportManagerState {
  final List<ReportItem> reports;
  GetReportsSuccess(this.reports);
}

class GetReportsFailure extends ReportManagerState {
  final String errMessage;
  GetReportsFailure(this.errMessage);
}

class GetReportsByidLoading extends ReportManagerState {}

class GetReportsByidSuccess extends ReportManagerState {
  final ReportResponseModelByid reports;
  GetReportsByidSuccess(this.reports);
}

class GetAchivmentReportsByidSuccess extends ReportManagerState {
  final AchievementModel reports;
  GetAchivmentReportsByidSuccess(this.reports);
}

class GetReportsByidFailure extends ReportManagerState {
  final String errMessage;
  GetReportsByidFailure(this.errMessage);
}

class SearchLoading extends ReportManagerState {}

class SearchReportsSuccess extends ReportManagerState {
  final List<ReportItem> reports;
  SearchReportsSuccess(this.reports);
}

class SearchReportsFailure extends ReportManagerState {
  final String errMessage;
  SearchReportsFailure(this.errMessage);
}

class CreateReportLoading extends ReportManagerState {
  double progress;
  bool isCompressing;
  CreateReportLoading(this.progress, {this.isCompressing = false});
}

class CreateReportSuccess extends ReportManagerState {
  final String message;
  CreateReportSuccess(this.message);
}

class CreateReportFailure extends ReportManagerState {
  final String errMessage;
  CreateReportFailure(this.errMessage);
}

class deleteReportState extends ReportManagerState {
  final String errMessage;
  deleteReportState(this.errMessage);
}
