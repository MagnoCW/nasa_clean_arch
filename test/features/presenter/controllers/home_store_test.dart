import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUseCase extends Mock
    implements GetSpaceMediaFromDateUseCase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUseCase mockUsecase;
  setUp(() {
    mockUsecase = MockGetSpaceMediaFromDateUseCase();
    store = HomeStore(mockUsecase);
  });

  test("should be return the SpaceMedia from the usecase ", () async {
    when(() => mockUsecase(any()))
        .thenAnswer((_) async => const Right(tSpaceMediaModel));

    await store.getSpaceMediaFromDateUseCase(tDate);
    store.observer(onState: (state) {
      expect(state, tSpaceMediaModel);
      verify(() => mockUsecase(tDate)).called(1);
    });
  });

  final tFailure = ServerFailure();

  test("should be return a Failure from the usecase when is a error ",
      () async {
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(tFailure));

    await store.getSpaceMediaFromDateUseCase(tDate);
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => mockUsecase(tDate)).called(1);
    });
  });
}
