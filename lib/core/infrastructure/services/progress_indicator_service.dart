import 'package:injectable/injectable.dart';
import 'package:sigapp/core/domain/service/progress_indicator_service.dart';
import 'package:sigapp/core/infrastructure/ui/overlays/progress_indicator_bloc.dart';

@Singleton(as: ProgressIndicatorService)
class ProgressIndicatorServiceImpl extends ProgressIndicatorService {
  ProgressIndicatorServiceImpl(this._cubit);

  final ProgressIndicatorBloc _cubit;

  @override
  Future<void> hide() async {
    await _cubit.hide();
  }

  @override
  Future<void> show() async {
    await _cubit.show();
  }
}
