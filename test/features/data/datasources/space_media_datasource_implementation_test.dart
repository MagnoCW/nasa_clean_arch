import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/http_client/core_http_client.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements CoreHttpClient {}

void main() {
  late SpaceMediaDatasource datasource;
  late CoreHttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = SpaceMediaDatasourceImplementation(client: client);
  });

  final tDate = DateTime(2021, 02, 02);
  const urlExpected =
      "https://api.nasa.gov/planetery/apod?api key=DEMO_KEY&date=2021-02-02";
  test("should call the get method with correct url", () async {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
    await datasource.getSpaceMediaFromDate(tDate);
    verify(
      () => client.get(urlExpected),
    ).called(1);
  });

  test("should return a SpaceMediaModel when is successful", () async {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
    const tSpaceMediaModel = SpaceMediaModel(
        description: "Meteors",
        mediaType: "image",
        title: "A Colorful",
        mediaUrl: "apod");
    final result = await datasource.getSpaceMediaFromDate(tDate);
    expect(result, tSpaceMediaModel);
  });

  test("should throw a ServerException when the call is unsuccessful",
      () async {
    when(() => client.get(any()))
        .thenAnswer((_) async => HttpResponse(data: "", statusCode: 400));

    expect(() async => await datasource.getSpaceMediaFromDate(tDate),
        throwsA(isA<ServerException>()));
  });
}
