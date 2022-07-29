import 'package:my_online_doctor/domain/enumerations/genre_enum.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

abstract class GetGenreUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetGenreUseCaseContract>(_GetGenreUseCase());

  static GetGenreUseCaseContract get() => getIt<GetGenreUseCaseContract>();

  /// Methods
  Future<List<String>> run();
}

class _GetGenreUseCase extends GetGenreUseCaseContract {
  @override
  Future<List<String>> run() async =>
      Genre.values.map((e) => e.genre).toList();
}
