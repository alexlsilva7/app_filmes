import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/services/login/login_service.dart';
import 'package:get/get.dart';
import 'package:app_filmes/application/ui/loader/loader_mixin.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final LoginService _loginService;

  LoginController({required LoginService loginService})
      : _loginService = loginService;

  final loading = false.obs;

  final message = Rxn<MessageModel>();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> login() async {
    try {
      loading(true);
      final loginResult = await _loginService.login();
      loading(false);
      message(MessageModel.success(
          title: 'Sucesso', message: 'Login realizado com sucesso'));
    } on Exception catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
      loading(false);
      message(MessageModel.error(
          title: 'Erro', message: 'Erro ao realizar login com o Google'));
    }
  }
}
