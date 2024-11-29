import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  const tSpaceMediaModel = SpaceMediaModel(
      description: "Meteors",
      mediaType: "image",
      title: "A Colorful",
      mediaUrl: "apod");

  test("should be a subclass of SpaceMediaEntity", () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test("should be return a valid model", () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    final result = SpaceMediaModel.fromJson(jsonMap);
    expect(result, tSpaceMediaModel);
  });
  test("should be return a jsonMap containing the proper data", () {
    final expectedMap = {
      "explanation": "Meteors",
      "media_type": "image",
      "title": "A Colorful",
      "url": "apod"
    };
    final result = tSpaceMediaModel.toJson();
    expect(result, expectedMap);
  });
}
