import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/medical_record/medical_record_commando_provider_contract.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class EditRecordPage extends StatelessWidget {
  static const routeName = '/edit_record_page';
  final String id;

  const EditRecordPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      appBar: _renderAppBar(context),
      body: MyCustomForm(id: id),
      bottomNavigationBar: _renderBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
      backgroundColor: colorPrimary,
      title: Text('Modificacion del registro'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ));

  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      color: colorSecondary);
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final String id;
  const MyCustomForm({super.key, required this.id});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String? description;
  String? diagnostico;
  String? examenes;
  String? recipe;
  String? plan;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Descripcion", style: Theme.of(context).textTheme.headline6),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  description = value;
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text("Diagnostico", style: Theme.of(context).textTheme.headline6),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  diagnostico = value;
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text("Examenes", style: Theme.of(context).textTheme.headline6),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  examenes = value;
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text("Recipe", style: Theme.of(context).textTheme.headline6),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  recipe = value;
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text("Planning", style: Theme.of(context).textTheme.headline6),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  plan = value;
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      MedicalRecordCommandProviderContract provider =
                          MedicalRecordCommandProviderContract.inject();

                      try {
                        provider.editDescription(description!, widget.id);
                        provider.editDiagnostic(diagnostico!, widget.id);
                        provider.editExams(examenes!, widget.id);
                        provider.editPlanning(plan!, widget.id);
                        provider.editRecipe(recipe!, widget.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Cambio de Meical Record Hecho con Exito')),
                        );
                        final NavigatorServiceContract _navigatorManager =
                            NavigatorServiceContract.get();
                        _navigatorManager
                            .navigateToWithReplacement("/bottom_menu");
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Error al cambiar el Medical Record')),
                        );
                      }
                    }
                  },
                  child: const Text('Editar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
