import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/core/errors/failure.dart';
import 'package:nasa_clean_arch/core/usecase/usecase.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';

class getSpaceMediaFromDateUseCase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final SpaceMediaRepository repository;

  getSpaceMediaFromDateUseCase({required this.repository});
  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date);
  }
}
