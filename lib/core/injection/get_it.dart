import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'get_it.config.dart';

final getIt = GetIt.instance;

@injectableInit
configureDependencies() => getIt.init();
