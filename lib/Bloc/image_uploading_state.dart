part of 'image_uploading_bloc.dart';

sealed class ImageUploadingState extends Equatable {
  const ImageUploadingState();
}

final class ImageUploadingInitial extends ImageUploadingState {
  @override
  List<Object> get props => [];
}
