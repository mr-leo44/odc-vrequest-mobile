import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:signals/signals_flutter.dart';

class SharedState {
  bool isLoading;
  Signal<List<Map<String,List<ChatModel>>>> newMessages = Signal(<Map<String, List<ChatModel>>>[]);
  User? auth;
  Map<String, dynamic> location;

  SharedState({
    this.isLoading = false,
    required this.newMessages ,
    this.auth = null,
    this.location = const <String, String>{},
  });

  SharedState copyWith({
    bool? isLoading,
    Signal<List<Map<String,List<ChatModel>>>>? newMessages,
    Signal<List<ChatUsersModel>>? conversations,
    User? auth,
    Map<String, dynamic>? location,
  }) =>
      SharedState(
        isLoading: isLoading ?? this.isLoading,
        newMessages: newMessages ?? this.newMessages,
        auth: auth ?? this.auth,
        location: location ?? this.location,
      );
}