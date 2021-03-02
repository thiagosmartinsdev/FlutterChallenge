import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trello_challenge/app/controller/new_card_controller.dart';
import 'package:trello_challenge/app/data/provider/api.dart';
import 'package:trello_challenge/app/data/repository/my_repository.dart';
import 'package:http/http.dart' as http;
import 'package:trello_challenge/app/ui/global/background_app.dart';

class NewCardPage extends GetView<NewCardController> {
  final NewCardController control = Get.put(NewCardController(
      repository:
          MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
            child: Stack(
          children: [BackGroundApp(), _topBackButton(), _form(), _saveButton()],
        )),
      ),
    );
  }

  _topBackButton() {
    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.02),
      height: Get.height * 0.15,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Flutter Challenge",
            style: TextStyle(color: Colors.white70, fontSize: 30),
          ),
        ],
      ),
    );
  }

  _form() {
    return Center(
      child: Container(
        width: Get.width * 0.8,
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
        ),
        child: Center(
          child: SizedBox(
            width: Get.width * 0.7,
            height: Get.height * 0.65,
            child: Form(
              key: controller.formKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextFormField(
                            controller: control.txtNome,
                            decoration: InputDecoration(labelText: "Nome"),
                            textInputAction: TextInputAction.next,
                            focusNode: controller.nomeNode,
                            onFieldSubmitted: (term) {
                              controller.fieldFocusChange(Get.context,
                                  controller.nomeNode, controller.emailNode);
                            },
                            validator: (value) {
                              return control.validate(value);
                            },
                          ),
                        ),
                        TextFormField(
                          controller: control.txtEmail,
                          decoration: InputDecoration(labelText: "Email"),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: controller.emailNode,
                          onFieldSubmitted: (term) {
                            controller.fieldFocusChange(Get.context,
                                controller.emailNode, controller.telefoneNode);
                          },
                          validator: (value) => controller.checkEmail(value),
                        ),
                        TextFormField(
                          controller: control.txtTelefone,
                          decoration: InputDecoration(labelText: "Telefone"),
                          textInputAction: TextInputAction.next,
                          focusNode: controller.telefoneNode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          onFieldSubmitted: (term) {
                            controller.fieldFocusChange(Get.context,
                                controller.telefoneNode, controller.cpfNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Preenchimento obrigatório";
                            }
                            if (value.length < 14) {
                              return "Valor inválido";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller: control.txtCpf,
                          decoration: InputDecoration(labelText: "CPF"),
                          textInputAction: TextInputAction.next,
                          focusNode: controller.cpfNode,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (term) {
                            controller.fieldFocusChange(Get.context,
                                controller.cpfNode, controller.nascimentoNode);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter()
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Preenchimento obrigatório";
                            }
                            if (value.length < 14) {
                              return "Valor inválido";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                            controller: control.txtNascimento,
                            decoration: InputDecoration(
                                labelText: "Data de nascimento"),
                            textInputAction: TextInputAction.next,
                            focusNode: controller.nascimentoNode,
                            readOnly: true,
                            onFieldSubmitted: (term) {
                              controller.fieldFocusChange(
                                  Get.context,
                                  control.nascimentoNode,
                                  controller.cidadeNode);
                            },
                            onTap: () async {
                              final dateSelected = await showDatePicker(
                                  context: Get.context,
                                  locale: Locale('pt'),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980, 1, 1),
                                  lastDate: DateTime.now(),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme:
                                            ColorScheme.light().copyWith(
                                          primary: Colors.blueGrey,
                                        ),
                                      ),
                                      child: child,
                                    );
                                  });
                              if (dateSelected != null &&
                                  dateSelected != control.selectedDate.value) {
                                control.selectedDate.value = dateSelected;

                                control.txtNascimento.text =
                                    DateFormat('dd/MM/yyyy')
                                        .format(dateSelected.toLocal())
                                        .toString();
                              }
                            }),
                        TextFormField(
                          controller: control.txtCidade,
                          decoration: InputDecoration(labelText: "Cidade"),
                          textInputAction: TextInputAction.next,
                          focusNode: controller.cidadeNode,
                          onFieldSubmitted: (term) {
                            controller.fieldFocusChange(Get.context,
                                controller.cidadeNode, controller.estadoNode);
                          },
                          validator: (value) {
                            return control.validate(value);
                          },
                        ),
                        TextFormField(
                          controller: control.txtEstado,
                          decoration: InputDecoration(labelText: "Estado"),
                          textInputAction: TextInputAction.next,
                          focusNode: controller.estadoNode,
                          onFieldSubmitted: (term) {
                            controller.fieldFocusChange(Get.context,
                                controller.estadoNode, controller.paisNode);
                          },
                          validator: (value) {
                            return control.validate(value);
                          },
                        ),
                        TextFormField(
                          controller: control.txtPais,
                          decoration: InputDecoration(labelText: "País"),
                          textInputAction: TextInputAction.done,
                          focusNode: controller.paisNode,
                          validator: (value) {
                            return control.validate(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _saveButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                  color: Color(0xFF90A4AE),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.grey[800], Colors.grey[400]]),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF263238),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                  border: Border.all(color: Colors.grey[300], width: 3),
                  borderRadius: BorderRadius.circular(15)),
              child: FlatButton(
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 20, color: Color(0xFFECEFF1)),
                  ),
                  onPressed: () {
                    control.save();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
