import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/appointment/appointment_detail_page.dart';

import '../object_mothers/appointment_object_mother.dart';

Widget createWidgetForTesting(Widget child) {
  return MaterialApp(
    home: child,
  );
}

void main() {
  setUpAll(() {
    InjectionManager.setupInjections();
  });

  testWidgets(
      'El detalle de una cita Solicitada tiene el botón de agendar cita',
      (tester) async {
    // Arrange
    final appointmentMock = AppointmentExamples.scheduledAppointment();
    // Act
    await tester.pumpWidget(createWidgetForTesting(
        AppointmentDetailPage(appointment: appointmentMock)));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(TextConstant.scheduleAppointment.text), findsOneWidget);
  });

  testWidgets(
      'El detalle de una cita solicitada tiene el botón de rechazar cita',
      (tester) async {
    // Arrange
    final appointmentMock = AppointmentExamples.scheduledAppointment();
    // Act
    await tester.pumpWidget(createWidgetForTesting(
        AppointmentDetailPage(appointment: appointmentMock)));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(TextConstant.rejectAppointment.text), findsOneWidget);
  });

  testWidgets(
      'El detalle de una cita solicitada no tiene el botón de cancelar cita',
      (tester) async {
    // Arrange
    final appointmentMock = AppointmentExamples.scheduledAppointment();
    // Act
    await tester.pumpWidget(createWidgetForTesting(
        AppointmentDetailPage(appointment: appointmentMock)));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text(TextConstant.cancelAppointment.text), findsNothing);
  });
}
