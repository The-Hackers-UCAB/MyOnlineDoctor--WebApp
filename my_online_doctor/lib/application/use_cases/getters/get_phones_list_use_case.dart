import 'package:my_online_doctor/domain/enumerations/phone_prefix_enum.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

abstract class GetPhonesUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetPhonesUseCaseContract>(_GetPhonesUseCase());

  static GetPhonesUseCaseContract get() => getIt<GetPhonesUseCaseContract>();

  /// Methods
  Future<List<String>> run();
}

class _GetPhonesUseCase extends GetPhonesUseCaseContract {
  @override
  Future<List<String>> run() async =>
      PhonePrefix.values.map((e) => e.phoneType).toList();
}
