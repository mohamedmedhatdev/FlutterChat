import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:meta/meta.dart';

part 'reply_data_state.dart';

class ReplyDataCubit extends Cubit<ReplyDataState> {
  ReplyDataCubit() : super(ReplyDataState(false,null));
  void startReplyingToMessage(CMessage msg) {
    emit(ReplyDataState( true,msg));
  }

  void stopReplying() {
    emit(ReplyDataState( false,null));
  }
}
