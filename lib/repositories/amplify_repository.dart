import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/repositories/repository.dart';

abstract class AmplifyRepository implements Repository {
  @override
  String createNewId() => UUID.getUUID();
}
