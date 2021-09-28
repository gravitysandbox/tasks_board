import 'package:equatable/equatable.dart';

abstract class UserCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
