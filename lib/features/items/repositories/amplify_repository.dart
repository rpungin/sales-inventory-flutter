import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/core/repositories/repository.dart';

abstract class AmplifyRepository implements Repository {
  @override
  String createNewId() => UUID.getUUID();
}
