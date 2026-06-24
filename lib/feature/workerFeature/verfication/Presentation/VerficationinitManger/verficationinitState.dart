import 'package:citifix/feature/workerFeature/verfication/data/model/WorkerRequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/worker_verification_model.dart';
import '../../data/model/verficationmodel.dart';

abstract class VerificationInitState {}

class VerificationInitInitial extends VerificationInitState {}

class VerificationInitLoading extends VerificationInitState {}

class VerificationInitSuccess extends VerificationInitState {
  final VerficationInitList areas;
  final VerficationInitList departments;
  VerificationInitSuccess({required this.areas, required this.departments});
}

class VerificationInitError extends VerificationInitState {
  final String message;
  VerificationInitError(this.message);
}

class VerificationNoRequest extends VerificationInitState {}

class VerificationRequestLoading extends VerificationInitState {
  final VerficationInitList? areas;
  final VerficationInitList? departments;

  VerificationRequestLoading({this.areas, this.departments});
}

class VerificationRequestSuccess extends VerificationInitState {
  VerificationRequestSuccess();
}

class VerificationRequestError extends VerificationInitState {
  final String errorMessage;
  final VerficationInitList? areas;
  final VerficationInitList? departments;

  VerificationRequestError(this.errorMessage, {this.areas, this.departments});
}

class VerificationSuccess extends VerificationInitState {
  final WorkerRequestModel workerRequest;
  VerificationSuccess({required this.workerRequest});
}

class VerificationError extends VerificationInitState {
  final String errorMessage;
  final int? statusCode;

  VerificationError({required this.errorMessage, this.statusCode});
}

class VerificationRequestsInitial extends VerificationInitState {}

class VerificationRequestsLoading extends VerificationInitState {}

class VerificationRequestsSuccess extends VerificationInitState {
  final List<WorkerVerificationModel> requests;
  VerificationRequestsSuccess(this.requests);
}

class VerificationRequestsError extends VerificationInitState {
  final String message;
  VerificationRequestsError(this.message);
}
