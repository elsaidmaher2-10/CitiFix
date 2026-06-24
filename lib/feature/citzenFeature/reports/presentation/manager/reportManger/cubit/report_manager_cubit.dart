import 'dart:async';

import 'package:citifix/feature/citzenFeature/achivement/data/Achievment/achievementModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/ReportRequestModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/ReportResponseModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportManagerState> {
  final ReportRepositoryT reportRepository;
  ReportCubit(this.reportRepository) : super(ReportManagerInitial());
  StreamSubscription<double>? _progressSub;
  List<ReportItem> _allReports = [];
  int _offset = 0;
  final int _limit = 10;
  bool _hasReachedMax = false;

  Future<void> fetchReports({bool isRefresh = false}) async {
    if (isClosed) return;

    if (isRefresh) {
      _offset = 0;
      _hasReachedMax = false;
      _allReports = [];
      emit(GetReportsLoading());
    } else {
      if (_hasReachedMax) {
        emit(GetReportsSuccess(List.from(_allReports)));
        return;
      }
    }

    final result = await reportRepository.getReports(
      offset: _offset,
      limit: _limit,
    );

    if (isClosed) return;

    result.fold((failure) => emit(GetReportsFailure(failure.errors.first)), (
      reports,
    ) {
      if (reports.isEmpty) {
        _hasReachedMax = true;
      } else {
        _allReports.addAll(reports);
        _offset += _limit;
        if (reports.length < _limit) {
          _hasReachedMax = true;
        }
      }
      emit(GetReportsSuccess(List.from(_allReports)));
    });
  }

  Future<void> createReport({required CreateReportRequest request}) async {
    if (isClosed) return;
    emit(CreateReportLoading(0.0, isCompressing: true));
    await _progressSub?.cancel();
    _progressSub = reportRepository.onprogressStream.listen((onData) {
      if (isClosed) return;
      emit(CreateReportLoading(onData, isCompressing: false));
    });

    final result = await reportRepository.addReport(request: request);
    await _progressSub?.cancel();
    _progressSub = null;
    if (isClosed) return;

    result.fold((failure) => emit(CreateReportFailure(failure.errors.first)), (
      successMessage,
    ) async {
      emit(CreateReportSuccess(successMessage));

      if (!isClosed) {
        await fetchReports(isRefresh: true);
      }
    });
  }

  Future<void> GetReportByID({required int ReportID}) async {
    if (isClosed) return;
    emit(GetReportsByidLoading());
    final result = await reportRepository.getReportById(reportId: ReportID);
    if (isClosed) return;
    result.fold(
      (failure) => emit(GetReportsByidFailure(failure.errors.first)),
      (ReportResponseModelByid successMessage) async {
        emit(GetReportsByidSuccess(successMessage));
      },
    );
  }
  Future<void> getAchievementbyReportID({required int ReportID}) async {
    if (isClosed) return;
    emit(GetReportsByidLoading());
    final result = await reportRepository.getAchievementbyReportID(reportId: ReportID);
    if (isClosed) return;
    result.fold(
      (failure) => emit(GetReportsByidFailure(failure.errors.first)),
      (AchievementModel successMessage) async {
        emit(GetAchivmentReportsByidSuccess(successMessage));
      },
    );
  }
  Future<void> deleteReport({required int ReportID}) async {
    if (isClosed) return;
    emit(GetReportsByidLoading());

    final result = await reportRepository.deleteReport(reportId: ReportID);

    if (isClosed) return;

    result.fold(
      (failure) => emit(GetReportsByidFailure(failure.errors.first)),
      (String successMessage) async {
        emit(deleteReportState(successMessage));
        await fetchReports(isRefresh: true);
      },
    );
  }

  void searchReport({required String query}) async {
    if (isClosed) return;

    if (query.isEmpty) {
      emit(GetReportsSuccess(List.from(_allReports)));
      return;
    }

    emit(SearchLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (isClosed) return;

    final filteredList = _allReports.where((e) {
      final bool matchTitle = e.title.toLowerCase().contains(
        query.toLowerCase(),
      );
      final bool matchId = e.id.toString().contains(query.toLowerCase());
      final bool matchLocation = (e.location).toString().toLowerCase().contains(
        query.toLowerCase(),
      );
      return matchTitle || matchId || matchLocation;
    }).toList();

    if (filteredList.isNotEmpty) {
      emit(SearchReportsSuccess(filteredList));
    } else {
      emit(SearchReportsFailure("No reports found for '$query'"));
    }
  }

  void resetSearch() {
    if (isClosed) return;
    emit(GetReportsSuccess(List.from(_allReports)));
  }

  void clear() {
    _allReports = [];
    emit(ReportManagerInitial());
  }

  @override
  Future<void> close() {
    _progressSub?.cancel();
    return super.close();
  }
}
