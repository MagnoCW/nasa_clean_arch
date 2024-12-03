import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

abstract class SpaceMediaRepository {
  Future<Either<Failures, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
