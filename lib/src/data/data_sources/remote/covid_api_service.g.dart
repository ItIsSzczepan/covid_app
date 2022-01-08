// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CovidApiService implements CovidApiService {
  _CovidApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.covid19api.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<GetSummaryResponse>> getSummary() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<GetSummaryResponse>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/summary',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetSummaryResponse.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
