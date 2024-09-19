import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:product_app/network/repository/product_repository.dart';
import 'package:product_app/network/services/auth_token_interceptor.dart';
import 'package:product_app/network/services/http_client.dart';
import 'package:product_app/network/services/product_services.dart';
import 'package:product_app/utils/connectivity_module.dart';

final locator = GetIt.instance;

/// Register all the dependencies here
Future<void> initializeDependencies() async {
  /// Registering [HttpClient] which will help us execute all api calls
  /// This will be shared with all the services
  HttpClient httpClient =
      HttpClient(InterceptedClient.build(interceptors: [ApiInterceptor()]));
  locator.registerLazySingleton<HttpClient>(() => httpClient);

  /// Internet connectivity module
  InternetConnectivityModule internetConnectivityModule =
      InternetConnectivityModule.instance;
  locator.registerLazySingleton<InternetConnectivityModule>(
      () => internetConnectivityModule);

  /// Internet status change notifier
  InternetStatusController internetStatusController =
      InternetStatusController.instance;
  locator.registerLazySingleton<InternetStatusController>(
      () => internetStatusController);

  /// Product Service
  ProductServices productServices = ProductServices(locator<HttpClient>());
  locator.registerLazySingleton<ProductServices>(() => productServices);

  /// Product Repository
  ProductRepository productRepository =
      ProductRepository(locator<ProductServices>());
  locator.registerLazySingleton<ProductRepository>(() => productRepository);  
    
}
