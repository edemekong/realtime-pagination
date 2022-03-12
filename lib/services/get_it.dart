import 'package:get_it/get_it.dart';
import 'package:provider_clean_code/repositories/user_repository.dart';

class GetItService {
  static final getIt = GetIt.instance;

  static Future<void> initialize() async {
    getIt.registerSingleton<UserRepository>(UserRepository());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
