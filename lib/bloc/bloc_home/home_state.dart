part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeChangeBottomNav extends HomeState {}
class HomeChangeBottomNavToPost extends HomeState {}
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
