// ignore_for_file: must_be_immutable
//Fluter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:my_online_doctor/domain/models/appointment/get_medical_record_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/theme.dart';

class MedicalRecord extends StatelessWidget {
  static const routeName = '/medical_record_detail';

  GetMedicalRecordModel record;

  MedicalRecord({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      appBar: _renderAppBar(context),
      body: _body(context),
      bottomNavigationBar: _renderBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
      title: const Text("Descripción de la historia"),
      backgroundColor: colorPrimary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ));

  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      color: colorSecondary);

  Widget _body(BuildContext context) => Stack(
        children: [
          Positioned(
            top: 150,
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: const BoxDecoration(
                color: colorWhite,
              ),
              child: _buildContent(context),
            ),
          ),
        ],
      );

  Widget _buildContent(BuildContext context) => SingleChildScrollView(
        padding: generalMarginView,
        // este widget estaba antes solo...
        child: Column(
          children: [
            Text(
                'Doctor encargado: ${record.doctor.firstName} ${record.doctor.firstSurname}',
                style: mainTheme().textTheme.headline1),
            const SizedBox(height: 3),
            Text("Especialidad: ${record.specialty.specialty}",
                style: mainTheme().textTheme.headline3),
            const SizedBox(height: 15),
            Column(
              children: [
                const Text("Descripción: ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  record.description,
                  style: mainTheme().textTheme.headline3,
                ),
                const SizedBox(height: 10),
                const Text("Exámenes a realizar: ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  record.exam,
                  style: mainTheme().textTheme.headline3,
                ),
                const SizedBox(height: 10),
                const Text("Diagnóstico: ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  record.diagnostic,
                  style: mainTheme().textTheme.headline3,
                ),
                const SizedBox(height: 10),
                const Text("Recipe: ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  record.recipe,
                  style: mainTheme().textTheme.headline3,
                ),
              ],
            )
          ],
        ),
      );
}
