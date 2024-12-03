import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements SpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late SpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource: datasource);
  });

  const tSpaceMediaModel =
      SpaceMediaModel(description: '', mediaType: '', title: '', mediaUrl: '');

  final tDate = DateTime(2024, 02, 02);

  test("Should return space media model when calls the datasource", () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => (tSpaceMediaModel));

    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, const Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      "Should return a server failure when the call to the datasource unsucessfull",
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
