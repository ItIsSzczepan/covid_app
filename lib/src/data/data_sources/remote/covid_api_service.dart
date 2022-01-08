import 'package:covid_app/src/data/models/get_summary_response.dart';
import 'package:dio/dio.dart';
import 'package:covid_app/src/core/constant.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'covid_api_service.g.dart';

@RestApi(baseUrl: kApiBaseUrl)
abstract class CovidApiService{
  factory CovidApiService(Dio dio, {String baseUrl}) = _CovidApiService;

  @GET('/summary')
  Future<HttpResponse<GetSummaryResponse>> getSummary();
}