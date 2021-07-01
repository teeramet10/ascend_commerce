import 'package:data/network_info.dart';

class MockNetworkInfoImpl implements NetworkInfo{

  MockNetworkInfoImpl(this.connected);

  bool connected;

  @override
  Future<bool> get isConnected => Future.value(this.connected);

}