import 'dart:developer';
import 'package:facerecognition/components/widgets/alertx.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class TimeoutHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final Duration timeout;

  TimeoutHttpClient({this.timeout = const Duration(seconds: 30)});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request).timeout(timeout);
  }
}

class GraphQLBase {
  String? errorMessage;
  String errorMessageDefault = 'Something went wrong';

  final gstate = Get.find<GlobalController>();

  // Initialize the GraphQLClient
  Future<GraphQLClient> getGraphQLClient() async {
    await checkToken();

    final HttpLink httpLink = HttpLink(
      gstate.baseUrl,
      httpClient: TimeoutHttpClient(timeout: const Duration(seconds: 30)),
      defaultHeaders: {'Authorization': 'Bearer ${gstate.token}'},
    );
    print(['httpsdsddd', httpLink]);
    final Link link = httpLink;

    return GraphQLClient(cache: GraphQLCache(), link: link);
  }

  // Check if the token is expired and refresh it
  Future<void> checkToken() async {
    if (gstate.token.isEmpty) {
      log('Token is empty');
      return;
    }

    if (JwtDecoder.isExpired(gstate.token)) {
      log('Token is expired, refreshing token...');
      String query =
          '''
        query getRefreshToken {
          getRefreshToken(token: "${gstate.token}") {
            __typename
            ... on AuthUserResponse {
              token
            }
            ... on Error {
              message
            }
          }
        }
      ''';

      GraphQLClient client = await getGraphQLClient();
      final QueryOptions options = QueryOptions(document: gql(query));
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        log('Error refreshing token: ${result.exception}');
        return;
      }

      if (result.data != null) {
        String newToken = result.data!['getRefreshToken']['token'];
        gstate.setToken(newToken);
        log('Token refreshed successfully');
      } else {
        log('Failed to refresh token');
      }
    }
  }

  // Handle GraphQL query
  Future<Map<String, dynamic>?> query(
    String queryString, {
    Map<String, dynamic> variables = const {},
    bool showLoading = false,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(queryString),
      variables: variables,
    );

    if (showLoading) Alertx().loading();

    GraphQLClient client = await getGraphQLClient();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      log('Error query: ${result.exception}');
      errorMessage =
          result.exception?.graphqlErrors[0].message ?? errorMessageDefault;
    } else {
      result.data!.forEach((key, value) {
        if (value is List) {
          String typename = value[0]['__typename'];
          if (typename == 'InvalidInputError' || typename == 'Error') {
            errorMessage = value[0]['message'] ?? 'Error';
          }
        }
      });
    }

    if (showLoading) if (Get.isDialogOpen ?? false) Get.back();

    if (errorMessage != null) {
      Alertx().error(errorMessage);
    }

    return result.data;
  }

  // Handle GraphQL mutation
  Future<Map<String, dynamic>?> mutate(
    String mutationString, {
    Map<String, dynamic> variables = const {},
    bool showLoading = true,
  }) async {
    log('------------------request mutation------------------');
    log(mutationString);
    log('------------------------------------------------------');
    final MutationOptions options = MutationOptions(
      document: gql(mutationString),
      variables: variables,
    );
    print(['variables', variables]);
    if (showLoading) Alertx().loading();

    GraphQLClient client = await getGraphQLClient();
    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      log('Error mutation: ${result.exception}');
      try {
        errorMessage = result.exception!.graphqlErrors[0].message.toString();
      } catch (e) {
        log(e.toString());
      }
    } else {
      log(result.data.toString());
      result.data!.forEach((key, value) {
        if (value is List) {
          String typename = value[0]['__typename'];
          if (typename == 'InvalidInputError' || typename == 'Error') {
            errorMessage = value[0]['message'] ?? 'Error';
          }
        }
      });
    }

    if (showLoading) if (Get.isDialogOpen ?? false) Get.back();

    if (errorMessage != null) {
      Alertx().error(errorMessage);
    }

    return result.data;
  }
}
