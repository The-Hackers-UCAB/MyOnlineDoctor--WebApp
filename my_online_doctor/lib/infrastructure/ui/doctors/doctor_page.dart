import 'package:flutter/material.dart';
import 'package:my_online_doctor/domain/models/doctor/doctor_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/theme.dart';

class DoctorPage extends StatelessWidget {
  static const routeName = '/doctor';

  DoctorRequestModel doctor;

  DoctorPage({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      appBar: _renderAppBar(context),
      body: _body(context),
      bottomNavigationBar: _renderBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
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
            left: 0,
            right: 0,
            child: _buildProfilePic(context),
          ),
          Positioned(
            top: 250,
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: const BoxDecoration(
                color: colorWhite,
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: _buildContent(context)),
            ),
          ),
        ],
      );

  Widget _buildProfilePic(BuildContext context) => Image.asset(
        doctor.gender == 'M'
            ? 'assets/images/doctor.jpeg'
            : 'assets/images/doctora.jpeg',
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.345,
        fit: BoxFit.cover,
      );

  Widget _buildContent(BuildContext context) => Column(
        children: [
          Text('${doctor.firstName} ${doctor.firstSurname}',
              style: mainTheme().textTheme.headline1),
          const SizedBox(height: 3),
          doctor.specialties.length > 1
              ? Text(
                  '${doctor.specialties[0].specialty} - ${doctor.specialties[1].specialty}',
                  style: mainTheme().textTheme.headline3)
              : Text(doctor.specialties[0].specialty,
                  style: mainTheme().textTheme.headline3),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: colorPrimary),
                  const SizedBox(width: 5),
                  Text('Caracas, Venezuela',
                      style: mainTheme().textTheme.headline6),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.yellow,
                      shadows: [Shadow(color: colorBlack, blurRadius: 0.5)],
                    ),
                    Text(
                      doctor.rating.toString().substring(0, 3),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ) //
            ],
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 10),
          Text('About', style: mainTheme().textTheme.headline2),
          const SizedBox(height: 5),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            style: mainTheme().textTheme.bodyText2,
          )
        ],
      );

  ButtonStyle _buttonStyle() => TextButton.styleFrom(
        backgroundColor: colorPrimary,
        primary: colorWhite,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      );
}
