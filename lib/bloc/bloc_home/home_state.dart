part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeChangeBottomNav extends HomeState {}

class HomeChangeBottomNavToPost extends HomeState {}

class HomePopUpMenuButtonNotification extends HomeState {}

class HomePopUpMenuButtonLogout extends HomeState {}

class HomePickProfileImageSuccess extends HomeState {}

class HomePickProfileImageError extends HomeState {}

class HomePickCoverImageSuccess extends HomeState {}

class HomePickCoverImageError extends HomeState {}

class HomeUploadProfileImageSuccess extends HomeState {}

class HomeUploadProfileImageError extends HomeState {}

class HomeUploadCoverImageSuccess extends HomeState {}

class HomeUploadCoverImageError extends HomeState {}

class HomeUpdateProfileSuccess extends HomeState {}

class HomeUpdateProfileError extends HomeState {}

class HomeUpdateProfileLoading extends HomeState {}

class HomePickPostImageSuccess extends HomeState {}

class HomePickPostImageError extends HomeState {}

class HomeRemovePostImage extends HomeState {}

class HomeCreateNewPostLoading extends HomeState {}

class HomeCreateNewPostError extends HomeState {}

class HomeCreateNewPostSuccess extends HomeState {}

class HomeUploadPostImageSuccess extends HomeState {}

class HomeUploadPostImageError extends HomeState {}

class HomeLikePostError extends HomeState {}

class HomeLikePostSuccess extends HomeState {}

class HomeGetAllUserSuccess extends HomeState {}

class HomeGetAllUserError extends HomeState {}

class HomeGetAllUserLoading extends HomeState {}

class HomeChangeBottomNavGetAllUser extends HomeState {}

class HomeChangeBottomNavGetMapLocation extends HomeState {}

class HomeSendMessageSuccess extends HomeState {}

class HomeSendMessageError extends HomeState {}

class HomeGetMessageSuccess extends HomeState {}

class HomeGetMessageError extends HomeState {}

class HomeGetMapLocation extends HomeState {}
