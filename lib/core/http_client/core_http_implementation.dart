import 'package:http/http.dart' as http;
import 'package:nasa_clean_arch/core/http_client/core_http_client.dart';

class CoreHttpImplementation implements CoreHttpClient {
  final client = http.Client();
  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(Uri.parse(url));
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> post(String url, {required Map<String, dynamic> body}) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
