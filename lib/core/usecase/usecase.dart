import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failures, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
