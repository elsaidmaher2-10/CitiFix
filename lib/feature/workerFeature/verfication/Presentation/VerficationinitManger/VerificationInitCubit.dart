import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/VerificationrequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/verficationmodel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationInitCubit extends Cubit<VerificationInitState> {
  final VerficationInitRepo repo;

  VerificationInitCubit(this.repo) : super(VerificationInitInitial());
  Future<void> loadInitialData() async {
    emit(VerificationInitLoading());

    final results = await Future.wait([
      repo.getAreas(),
      repo.getDepartmentname(),
    ]);

    final areasResult = results[0];
    final departmentsResult = results[1];
    areasResult.fold(
      (failure) => emit(VerificationInitError(failure.errors.first)),
      (areas) {
        areasList = areas;
        departmentsResult.fold(
          (failure) => emit(VerificationInitError(failure.errors.first)),
          (departments) {
            departmentsList = departments;
            emit(
              VerificationInitSuccess(
                areas: areasList!,
                departments: departmentsList!,
              ),
            );
          },
        );
      },
    );
  }

  VerficationInitList? areasList;
  VerficationInitList? departmentsList;
  Future<void> sendVerificationRequest({
    required VerificationrequestModel request,
  }) async {
    emit(
      VerificationRequestLoading(
        areas: areasList,
        departments: departmentsList,
      ),
    );

    final result = await repo.verificationrequest(request: request);

    result.fold(
      (failure) {
        emit(
          VerificationRequestError(
            failure.errors.first,
            areas: areasList,
            departments: departmentsList,
          ),
        );
      },
      (response) {
        emit(VerificationRequestSuccess());
      },
    );
  }

  Future<void> getVerificationRequestData() async {
    emit(VerificationInitLoading());
    final result = await repo.getvrificationRequest();
    result.fold(
      (failure) {
        if (isNoVerificationRequestFailure(failure)) {
          emit(VerificationNoRequest());
        } else {
          emit(VerificationInitError(failure.errors.join()));
        }
      },
      (workerRequestModel) {
        emit(VerificationSuccess(workerRequest: workerRequestModel));
      },
    );
  }

  static bool isNoVerificationRequestFailure(FailureResponse failure) {
    final normalizedMessage = failure.errors.join(' ').toLowerCase();
    final has404Status = failure.statusCode == 404;
    final hasNoRequestText =
        normalizedMessage.contains('no verification request') ||
        normalizedMessage.contains('request not found') ||
        normalizedMessage.contains('not found') ||
        normalizedMessage.contains('لم يتم العثور على طلب تحقق');

    return has404Status || hasNoRequestText;
  }

  Future<void> fetchRequests() async {
    emit(VerificationRequestsLoading());

    final result = await repo.getvrificationRequests();

    result.fold(
      (failure) {
        emit(VerificationRequestsError(failure.errors.first));
      },
      (data) {
        emit(VerificationRequestsSuccess(data));
      },
    );
  }
}
