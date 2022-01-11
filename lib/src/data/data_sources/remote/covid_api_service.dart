import 'package:covid_app/src/data/models/country_model.dart';
import 'package:covid_app/src/data/models/get_all_countries_list_response.dart';
import 'package:covid_app/src/domain/entities/country.dart';
import 'package:dio/dio.dart';
import 'package:covid_app/src/core/constant.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'covid_api_service.g.dart';

@RestApi(baseUrl: kApiBaseUrl)
abstract class CovidApiService{
  factory CovidApiService(Dio dio, {String baseUrl}) = _CovidApiService;

  @GET('/v3/covid-19/countries')
  Future<HttpResponse<List<CountryModel>>> getAllCountriesList();
}