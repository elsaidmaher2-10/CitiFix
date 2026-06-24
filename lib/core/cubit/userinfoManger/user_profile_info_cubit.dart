import 'dart:convert';
import 'dart:io';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_info_state.dart';

class UserProfileInfoCubit extends Cubit<UserProfileInfoState> {
  UserProfileInfoCubit(this.userprofilerepos)
    : super(UserProfileInfoInitial()) {
    _loadInitialData();
  }
  final Userprofilerepos userprofilerepos;

  void _loadInitialData() async {
    final cachedUser = _readCachedUserProfile();

    if (cachedUser != null) {
      emit(UserProfileInfoSuccess(cachedUser));
      await getUserProfleInfo(showLoading: false);
      return;
    }

    await getUserProfleInfo();
  }

  Future<void> getUserProfleInfo({bool showLoading = true}) async {
    if (showLoading && state is! UserProfileInfoSuccess) {
      emit(UserProfileInfoLoading());
    }

    final result = await userprofilerepos.getuserInfo();
    result.fold((l) {
      if (state is! UserProfileInfoSuccess) {
        emit(UserProfileInfoError(l.errors.join()));
      }
    }, (r) => emit(UserProfileInfoSuccess(r)));
  }

  UserProfile? _readCachedUserProfile() {
    final cachedUser = PrefrenceManager().getstring(Constantmanger.cacheKey);
    if (cachedUser == null || cachedUser.isEmpty) {
      return null;
    }

    try {
      return UserProfile.fromJson(jsonDecode(cachedUser));
    } catch (_) {
      return null;
    }
  }

  void clear() {
    emit(UserProfileInfoInitial());
  }

  Future<void> updateUserProfleImage(File image) async {
    if (isClosed) return;
    UserProfile? currentUser;
    if (state is UserProfileInfoSuccess) {
      currentUser = (state as UserProfileInfoSuccess).user;
    } else if (state is UserProfileImageUpdatedSuccess) {
      currentUser = (state as UserProfileImageUpdatedSuccess).user;
    }
    if (currentUser == null) return;
    emit(UserProfileImageLoading(currentUser));
    final result = await userprofilerepos.updateuserImage(image);
    if (isClosed) return;
    result.fold((l) => emit(UserProfileInfoError(l.errors.join())), (r) {
      emit(UserProfileImageUpdatedSuccess(r));
    });
  }

  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    if (isClosed) return;
    emit(EditUserProfileInfoLoading());
    final result = await userprofilerepos.updateProfile(updatedProfile);
    if (isClosed) return;
    result.fold(
      (failure) => emit(EditUserProfileInfoError(failure.errors.join())),
      (response) {
        UserProfile finalProfile;
        String? cachedUser = PrefrenceManager().getstring(
          Constantmanger.cacheKey,
        );

        if (cachedUser != null) {
          UserProfile oldProfile = UserProfile.fromJson(jsonDecode(cachedUser));
          finalProfile = UserProfile(
            id: response.id ?? oldProfile.id,
            username: response.username ?? oldProfile.username,
            email: response.email ?? oldProfile.email,
            role: response.role ?? oldProfile.role,
            fullName: response.fullName ?? oldProfile.fullName,
            nationalId: response.nationalId ?? oldProfile.nationalId,
            dateOfBirth: response.dateOfBirth ?? oldProfile.dateOfBirth,
            phoneNumber: response.phoneNumber ?? oldProfile.phoneNumber,
            address: response.address ?? oldProfile.address,
            verified: response.verified ?? oldProfile.verified,
            userId: response.userId ?? oldProfile.userId,
            profileImage: response.profileImage ?? oldProfile.profileImage,
          );
        } else {
          finalProfile = response;
        }

        PrefrenceManager().setstring(
          Constantmanger.cacheKey,
          jsonEncode(finalProfile.toJson()),
        );

        emit(EditUserProfileInfoSuccess(finalProfile));
      },
    );
  }
}
