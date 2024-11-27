import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/failure.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements SpaceMediaRepository {}

void main() {
  late getSpaceMediaFromDateUseCase usecase;
  late SpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = getSpaceMediaFromDateUseCase(repository: repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
      description: "description",
      mediaType: "image",
      title: "title",
      mediaUrl:
          "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg");
  final tDate = DateTime(2024, 02, 02);
  test("Should get space media entity for a given data from the repository",
      () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    final result = await usecase(tDate);
    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test("Should return a server failure when don't succed", () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    final result = await usecase(tDate);
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
