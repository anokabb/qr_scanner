import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'flash_state.dart';

class FlashCubit extends Cubit<FlashState> {
  FlashCubit() : super(FlashOff());

  void flashOn() => emit(FlashOn());

  void flashOff() => emit(FlashOff());
}
