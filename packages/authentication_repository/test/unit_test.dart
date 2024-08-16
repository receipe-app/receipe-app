  import 'dart:convert';

  import 'package:authentication_repository/authentication_repository.dart';
  import 'package:flutter_test/flutter_test.dart';
  import 'package:dio/dio.dart';
  import 'package:http_mock_adapter/http_mock_adapter.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  void main() {
    late Dio dio;
    late DioAdapter dioAdapter;
    late AuthenticationRepository authRepository;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      authRepository = AuthenticationRepository();
    });

    group('AuthenticationRepository Tests', () {
      test('register method should return a User on successful registration',
              () async {
            final userResponse = {
              "localId": "testId",
              "email": "test@example.com",
              "idToken": "testToken",
              "refreshToken": "testRefreshToken",
              "expiresIn": "3600"
            };

            dioAdapter.onPost(
              'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBETfX8XDGAJBdBzkRZY68vBBeIYO0HWT0',
                  (server) => server.reply(200, userResponse),
              data: {
                "email": "test@example.com",
                "password": "test@example.com",
                "returnSecureToken": true,
              },
            );

            SharedPreferences.setMockInitialValues({});

            // Act
            final user = await authRepository.register(
              email: "test@example.com",
              password: "test@example.com",
            );

            // Assert
            expect(user.id, "testId");
            expect(user.email, "test@example.com");
            expect(user.token, "testToken");
          });

      test('login method should throw an error on failed login', () async {
        // Arrange
        final errorResponse = {
          "error": {"message": "INVALID_PASSWORD"}
        };

        dioAdapter.onPost(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBETfX8XDGAJBdBzkRZY68vBBeIYO0HWT0',
              (server) => server.reply(400, errorResponse),
          data: {
            "email": "test@example.com",
            "password": "wrong_password",
            "returnSecureToken": true,
          },
        );

        // Act & Assert
        expect(
              () async => await authRepository.login(
            email: "test@example.com",
            password: "wrong_password",
          ),
          throwsA("INVALID_PASSWORD"),
        );
      });

      test('checkTokenExpiry should return a user if token is not expired',
              () async {
            // Arrange
            final userData = jsonEncode({
              "localId": "testId",
              "email": "test@example.com",
              "idToken": "testToken",
              "refreshToken": "testRefreshToken",
              "expiresIn": DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
            });

            SharedPreferences.setMockInitialValues({"userData": userData});

            // Act
            final user = await authRepository.checkTokenExpiry();

            // Assert
            expect(user, isNotNull);
            expect(user?.token, "testToken");
          });

      test('checkTokenExpiry should return null if token is expired', () async {
        // Arrange
        final userData = jsonEncode({
          "localId": "testId",
          "email": "test@example.com",
          "idToken": "testToken",
          "refreshToken": "testRefreshToken",
          "expiresIn":
          DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
        });

        SharedPreferences.setMockInitialValues({"userData": userData});

        // Act
        final user = await authRepository.checkTokenExpiry();

        // Assert
        expect(user, isNull);
      });
    });
  }
