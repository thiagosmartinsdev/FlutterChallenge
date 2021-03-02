import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:trello_challenge/app/data/model/challenge_model.dart';
import 'package:trello_challenge/app/data/repository/my_repository.dart';

class NewCardController extends GetxController {
  final MyRepository repository;
  NewCardController({@required this.repository}) : assert(repository != null);

  final formKey = GlobalKey<FormState>();

  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtCpf = TextEditingController();
  final txtNascimento = TextEditingController();
  final txtCidade = TextEditingController();
  final txtEstado = TextEditingController();
  final txtPais = TextEditingController();

  final nomeNode = FocusNode();
  final emailNode = FocusNode();
  final telefoneNode = FocusNode();
  final cpfNode = FocusNode();
  final nascimentoNode = FocusNode();
  final cidadeNode = FocusNode();
  final estadoNode = FocusNode();
  final paisNode = FocusNode();

  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    txtNascimento.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    super.onInit();
  }

  @override
  onClose() {
    formKey.currentState.reset();
    super.onClose();
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  checkEmail(value) {
    if (value == null || value.isEmpty) return "Preenchimento obrigatório";

    const pattern = r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regexp = RegExp(pattern);
    if (!regexp.hasMatch(value)) {
      return "Por favor, insira um email válido";
    }
    return null;
  }

  String validate(value) {
    if (value.isEmpty) {
      return "Preenchimento obrigatório";
    }
    return null;
  }

  save() async {
    if (formKey.currentState.validate()) {
      try {
        ChallengeModel newCard = ChallengeModel(
          nome: txtNome.text,
          email: txtEmail.text,
          telefone: txtTelefone.text,
          cpf: txtCpf.text,
          nascimentoData: selectedDate.value,
          cidade: txtCpf.text,
          estado: txtEstado.text,
          pais: txtPais.text,
        );
        await repository.add(newCard);
        clear();
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> clear() async {
    formKey.currentState?.reset();
    return true;
  }
}
