import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/amplifyconfiguration.dart';
import 'package:sale_inventory/models/ModelProvider.dart';

class AmplifyService {
  AmplifyService._internal();
  static final AmplifyService _instance = AmplifyService._internal();
  factory AmplifyService() => _instance;

  Future<void> initialize() async {
    try {
      // Create the API plugin.
      //
      // If `ModelProvider.instance` is not available, try running
      // `amplify codegen models` from the root of your project.
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);

      // Create the Auth plugin.
      final auth = AmplifyAuthCognito();

      // Add the plugins and configure Amplify for your app.
      await Amplify.addPlugins([api, auth]);
      await Amplify.configure(amplifyconfig);

      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }
}
