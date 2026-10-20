import '../core/app_exception.dart';
import '../core/mock_helpers.dart';
import '../models/address.dart';
 
abstract class AddressRepository {
  Future<List<Address>> getAddresses();
  Future<Address> addAddress(Address address);
  Future<void> deleteAddress(int id);
}
 
class MockAddressRepository implements AddressRepository {
  int _nextId = 6;
 
  final List<Address> _addresses = [
    const Address(
      id: 5,
      label: 'Home',
      line1: '12 MG Road',
      line2: 'Near City Mall',
      city: 'Agra',
      pincode: '282001',
      latitude: 27.1767,
      longitude: 78.0081,
      isDefault: true,
    ),
  ];
 
  @override
  Future<List<Address>> getAddresses() async {
    await mockDelay(400);
    MockConfig.maybeFail();
    return List.unmodifiable(_addresses);
  }
 
  @override
  Future<Address> addAddress(Address address) async {
    await mockDelay();
    MockConfig.maybeFail();
    final created = address.copyWith(id: _nextId++);
    if (created.isDefault) {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }
    _addresses.add(created);
    return created;
  }
 
  @override
  Future<void> deleteAddress(int id) async {
    await mockDelay(400);
    MockConfig.maybeFail();
    final before = _addresses.length;
    _addresses.removeWhere((a) => a.id == id);
    if (_addresses.length == before) {
      throw const AppException('not_found', 'Address not found', statusCode: 404);
    }
  }
}