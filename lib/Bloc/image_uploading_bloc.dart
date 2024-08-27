import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_uploading_event.dart';
part 'image_uploading_state.dart';

class ImageUploadingBloc
    extends Bloc<ImageUploadingEvent, ImageUploadingState> {
  ImageUploadingBloc() : super(ImageUploadingInitial()) {
    on<ImageUploadingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
