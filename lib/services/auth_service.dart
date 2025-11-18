// services/auth_service.dart
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Data dummy users
  final List<Map<String, String>> _users = [
    {
      'email': 'user@example.com',
      'username': 'user123',
      'password': 'password123',
      'fullName': 'John Doe',
    },
    {
      'email': 'test@example.com',
      'username': 'testuser',
      'password': 'test123',
      'fullName': 'Test User',
    },
  ];

  // Login method
  Map<String, dynamic> login(String identifier, String password) {
    final user = _users.firstWhere(
      (user) => user['email'] == identifier || user['username'] == identifier,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return {'success': false, 'message': 'User tidak ditemukan'};
    }

    if (user['password'] != password) {
      return {'success': false, 'message': 'Password salah'};
    }

    return {'success': true, 'user': user};
  }

  // Register method
  Map<String, dynamic> register(
      String email, String username, String password, String fullName) {
    // Check if email already exists
    if (_users.any((user) => user['email'] == email)) {
      return {'success': false, 'message': 'Email sudah terdaftar'};
    }

    // Check if username already exists
    if (_users.any((user) => user['username'] == username)) {
      return {'success': false, 'message': 'Username sudah terdaftar'};
    }

    // Add new user
    final newUser = {
      'email': email,
      'username': username,
      'password': password,
      'fullName': fullName,
    };
    _users.add(newUser);

    return {'success': true, 'user': newUser};
  }

  // Check if user is logged in (dummy implementation)
  bool isLoggedIn() {
    return false; // Always false for demo
  }
}
