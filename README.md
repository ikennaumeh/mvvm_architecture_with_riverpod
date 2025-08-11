# MVVM Architecture with Riverpod

A comprehensive Flutter project demonstrating clean MVVM (Model-View-ViewModel) architecture using Riverpod for state management. This project showcases best practices for building scalable, maintainable, and testable Flutter applications.

## 🏗️ Architecture Overview

This project follows the MVVM pattern with clear separation of concerns:

- **Model**: Data models and business logic
- **View**: UI components and widgets
- **ViewModel**: State management and business logic coordination
- **Services**: API calls, data persistence, and external integrations

## 📁 Project Structure

```
lib/
├── core/
│   └── either.dart              # Result handling utility
├── services/
│   ├── network_service.dart     # HTTP client and API communication
│   ├── animal_service.dart      # Domain-specific API services
│   └── error_handling.dart      # Centralized error handling
└── ui/
    ├── enums/
    │   └── request.dart         # HTTP request types
    ├── extensions/
    │   └── request_extension.dart # Request utility extensions
    └── views/
        └── home/
            ├── home_view.dart       # UI presentation layer
            ├── home_view_model.dart # Business logic and state management
            └── home_state.dart      # State model definitions
```

## 🔧 Core Components

### Network Service

The `NetworkService` class provides a centralized HTTP client using Dio:

```dart
final networkServiceProvider = Provider<NetworkService>((ref) => NetworkService());

class NetworkService with ErrorHandling {
  // Configured Dio instance with base URL and interceptors
  // Handles all HTTP communications
  // Includes debug logging and error handling
}
```

**Features:**
- Centralized HTTP configuration
- Debug logging in development mode
- Built-in error handling with custom error processing
- Timeout configuration
- JSON serialization/deserialization

### Domain Services

Domain-specific services handle business logic and API interactions:

```dart
final animalServiceProvider = Provider<AnimalService>((ref) => AnimalService(
  networkService: ref.watch(networkServiceProvider),
));

class AnimalService {
  // Domain-specific API calls
  // Returns Either<Exception, Data> for robust error handling
}
```

**Key Benefits:**
- Separation of concerns between network layer and business logic
- Type-safe error handling with Either pattern
- Dependency injection through Riverpod
- Easy testing and mocking

### MVVM Pattern Implementation

#### View Layer
```dart
class HomeView extends ConsumerStatefulWidget {
  // UI-only concerns
  // Observes ViewModel state changes
  // Dispatches user actions to ViewModel
}
```

#### ViewModel Layer
```dart
final homeViewModelProvider = StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(ref)
);

class HomeViewModel extends StateNotifier<HomeState> {
  // Business logic coordination
  // State management
  // Service orchestration
}
```

#### State Management
```dart
class HomeState {
  final UiState uiState;
  final List<String> houndList;
  final String? errorMessage;
  
  // Immutable state with copyWith pattern
  // Clear state definitions
}
```

## 🚀 Key Features

### 1. **Reactive State Management**
- Uses Riverpod for dependency injection and state management
- Automatic state updates trigger UI rebuilds
- Memory-efficient with `autoDispose` providers

### 2. **Error Handling Strategy**
- Either pattern for functional error handling
- Centralized error processing
- User-friendly error messages
- Debug information in development

### 3. **Separation of Concerns**
- Clear boundaries between layers
- Single responsibility principle
- Easy to test and maintain

### 4. **Type Safety**
- Strong typing throughout the application
- Compile-time error detection
- Better IDE support and refactoring

## 📋 UI State Management

The application uses a comprehensive state management approach:

```dart
enum UiState { idle, loading, success, error }
```

**State Flow:**
1. **Idle**: Initial state
2. **Loading**: Data fetching in progress
3. **Success**: Data loaded successfully
4. **Error**: Error occurred during operation

**UI Rendering:**
```dart
switch(state.uiState) {
  UiState.loading => CircularProgressIndicator(),
  UiState.success => DataWidget(data: state.data),
  UiState.error => ErrorWidget(message: state.errorMessage),
  _ => DefaultWidget(),
}
```

## 🛠️ Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  dio: ^5.3.2
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.2
  build_runner: ^2.4.7
```

## 🚦 Getting Started

### 1. Clone and Setup
```bash
git clone <repository-url>
cd mvvm_riverpod
flutter pub get
```

### 2. Run the Application
```bash
flutter run
```

## 🔮 Coming Soon

This project is actively being developed with exciting features planned for the future:

### 🧪 Testing Implementation
- **Unit Testing**: Comprehensive ViewModel testing with mock services
- **Integration Testing**: End-to-end testing of complete user flows
- **Widget Testing**: Individual UI component testing
- **Test Coverage**: Automated coverage reporting and CI/CD integration

### 🚀 Advanced Riverpod Features
- **AsyncNotifier**: Enhanced async state management patterns
- **Family Providers**: Dynamic provider instances for lists and parameterized data
- **Scoped Providers**: Feature-scoped state management
- **Provider Observers**: Advanced debugging and logging capabilities
- **Code Generation**: Riverpod code generation for better developer experience

### 📱 Enhanced Architecture Features
- **Repository Pattern**: Data layer abstraction with caching strategies
- **Use Cases**: Business logic isolation with clean architecture principles
- **Dependency Injection**: Advanced DI patterns with multiple environments
- **Error Recovery**: Automatic retry mechanisms and offline support
- **Performance Monitoring**: Real-time performance metrics and optimization

### 🛠️ Developer Experience Improvements
- **Code Templates**: VS Code snippets for rapid MVVM development
- **Linting Rules**: Custom lint rules for architecture compliance
- **Documentation**: Interactive API documentation with examples
- **Migration Guides**: Step-by-step guides for adopting patterns

Stay tuned for these exciting updates! 🎉

## 📈 Performance Considerations

### Memory Management
- `autoDispose` providers automatically clean up unused state
- Efficient widget rebuilds through granular state observation
- Lazy initialization of services

### Network Optimization
- Request/response logging in debug mode only
- Configurable timeout settings
- Error retry mechanisms (can be implemented)

## 🔄 State Flow Diagram

```
User Action → ViewModel → Service → Network → API
     ↑                                           ↓
View ← State Update ← ViewModel ← Service ← Response
```

## 🎯 Best Practices Demonstrated

1. **Dependency Injection**: All dependencies injected through Riverpod providers
2. **Error Boundary**: Comprehensive error handling at every layer
3. **Immutable State**: State objects are immutable with copyWith pattern
4. **Single Source of Truth**: State centralized in ViewModels
5. **Testability**: Easy to mock and test individual components
6. **Scalability**: Clear patterns for adding new features

## 🔧 Extending the Architecture

### Adding a New Feature

1. **Create State Model**
```dart
class FeatureState {
  final UiState uiState;
  final List<DataModel> items;
  final String? errorMessage;

  FeatureState({required this.uiState, required this.items, this.errorMessage});

  FeatureState copyWith({...}) => FeatureState(...);
}
```

2. **Create ViewModel**
```dart
final featureViewModelProvider = StateNotifierProvider.autoDispose<FeatureViewModel, FeatureState>(
        (ref) => FeatureViewModel(ref)
);

class FeatureViewModel extends StateNotifier<FeatureState> {
  final Ref _ref;

  FeatureViewModel(this._ref) : super(FeatureState.initial());

  Future<void> loadData() async {
    // Implementation
  }
}
```

3. **Create View**
```dart
class FeatureView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featureViewModelProvider);

    return Scaffold(
      body: switch(state.uiState) {
      // Handle different states
      },
    );
  }
}
```

### Adding a New Service

1. **Create Service Class**
```dart
final newServiceProvider = Provider<NewService>((ref) => NewService(
  networkService: ref.watch(networkServiceProvider),
));

class NewService {
  final NetworkService networkService;

  NewService({required this.networkService});

  Future<Either<Exception, DataModel>> fetchData() async {
    // Implementation
  }
}
```

## 📚 Additional Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter MVVM Pattern](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Flutter Testing Guide](https://flutter.dev/docs/testing)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git branch -M feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

If you have any questions or need help with implementation, please:

1. Check the existing issues
2. Create a new issue with a detailed description
3. Join our community discussions

---

**Built with ❤️ using Flutter and Riverpod**