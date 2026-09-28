import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../models/style_template.dart';

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository(ref.watch(apiClientProvider));
});

class TemplateRepository {
  TemplateRepository(this._api);

  final ApiClient _api;

  Future<List<StyleTemplate>> fetchTemplates({
    String? category,
    bool? trending,
  }) async {
    final query = <String, dynamic>{};
    if (category != null && category.isNotEmpty && category != 'All') {
      query['category'] = category;
    }
    if (trending != null) {
      query['trending'] = trending;
    }

    final response = await _api.get<dynamic>(
      '/api/v1/templates',
      queryParameters: query.isEmpty ? null : query,
    );

    return _mapTemplates(response.data);
  }

  Future<StyleTemplate> fetchTemplate(String idOrSlug) async {
    final response = await _api.get<dynamic>(
      '/api/v1/templates/$idOrSlug',
    );
    final data = response.data;
    if (data is! Map) {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Style not found.',
      );
    }
    return StyleTemplate.fromJson(Map<String, dynamic>.from(data));
  }

  Future<List<StyleCategory>> fetchCategories() async {
    final response = await _api.get<dynamic>('/api/v1/categories');
    final data = response.data;
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((item) => StyleCategory.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }

  List<StyleTemplate> _mapTemplates(dynamic data) {
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((item) => StyleTemplate.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }
}
