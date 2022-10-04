import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wasalny/core/firebase/firebase_storage_consumer.dart';
import 'package:wasalny/core/helpers/location_helper.dart';
import 'package:wasalny/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:wasalny/features/maps/domain/usecases/fetch_suggestions.dart';
import 'package:wasalny/features/maps/domain/usecases/get_current_address.dart';
import 'package:wasalny/features/maps/domain/usecases/get_directions.dart';
import 'package:wasalny/features/maps/domain/usecases/get_place_details.dart';
import 'package:wasalny/features/user/data/datasources/user_remote_data_source.dart';
import 'package:wasalny/features/user/domain/repositories/user_repository.dart';
import 'package:wasalny/features/user/domain/usecases/signIn.dart';

import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/firebase/firebase_firestore_consumer.dart';
import 'core/firebase/phone_auth.dart';
import 'core/network/network_info.dart';
import 'features/maps/data/repositories/maps_ repository_imp.dart';
import 'features/maps/domain/repositories/maps_repository.dart';
import 'features/maps/presentation/cubit/maps/maps_cubit.dart';
import 'features/user/data/datasources/auth_remote_data_source.dart';
import 'features/user/data/repositories/auth_repository_impl.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/auth_repository.dart';
import 'features/user/domain/usecases/get_current_user.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/domain/usecases/logout.dart';
import 'features/user/domain/usecases/set_user.dart';
import 'features/user/domain/usecases/submit_otp.dart';
import 'features/user/domain/usecases/submit_phone_number.dart';
import 'features/user/domain/usecases/upload_profile_image.dart';
import 'features/user/presentaion/cubit/phone_auth/phone_auth_cubit.dart';
import 'features/user/presentaion/cubit/user/user_cubit.dart';

final instance = GetIt.instance;
Future<void> init() async {
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<Dio>(() => Dio());
  instance.registerLazySingleton<AppIntercepters>(() => AppIntercepters());
  instance.registerLazySingleton<LogInterceptor>(() => LogInterceptor());
  instance.registerLazySingleton<ApiConsumer>(() => DioConsumer(instance()));

  instance.registerLazySingleton<LocationHelper>(() => LocationHelperImpl());

  instance.registerLazySingleton<MapsRemoteDataSource>(() =>
      MapsRemoteDataSourceImpl(
          apiConsumer: instance(), locationHelper: instance()));

  instance.registerLazySingleton<MapsRepository>(
      () => MapsRepositoryImpl(instance(), instance()));

  instance.registerLazySingleton<MapsCubit>(() => MapsCubit(
      getCurrentAddress: instance(),
      fetchSuggestions: instance(),
      getDirections: instance(),
      getPlaceDetails: instance()));

  instance.registerLazySingleton<FetchSuggestionsUsecase>(
      () => FetchSuggestionsUsecase(instance()));
  instance.registerLazySingleton<GetCurrentAddressUsecase>(
      () => GetCurrentAddressUsecase(instance()));
  instance.registerLazySingleton<GetDirectionsUsecase>(
      () => GetDirectionsUsecase(instance()));
  instance.registerLazySingleton<GetPlaceDetailsUsecase>(
      () => GetPlaceDetailsUsecase(instance()));

  instance
      .registerLazySingleton<FirestoreConsumer>(() => FirestoreConsumerImpl());

  instance.registerLazySingleton<StorageConsumer>(() => StorageConsumerImpl());

  instance.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImpl(fireStore: instance(), storage: instance()));

  instance.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(instance(), instance()));

  instance.registerLazySingleton<UserCubit>(() => UserCubit(
        setUser: instance(),
        getUser: instance(),
        uploadProfileImage: instance(),
      ));

  instance
      .registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(instance()));
  instance
      .registerLazySingleton<SetUserUsecase>(() => SetUserUsecase(instance()));
  instance.registerLazySingleton<UploadProfileImageUsecase>(
      () => UploadProfileImageUsecase(instance()));

  instance
      .registerLazySingleton<PhoneAuthConsumer>(() => PhoneAuthConsumerImpl());
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(phoneAuth: instance()));

  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()));

  instance.registerLazySingleton<PhoneAuthCubit>(() => PhoneAuthCubit(
        signInUsecase: instance(),
        getCurrentUserUsecase: instance(),
        logoutUsecase: instance(),
      ));

  instance.registerLazySingleton<SubmitPhoneNumberUsecase>(
      () => SubmitPhoneNumberUsecase(instance()));
  instance.registerLazySingleton<SubmitOTPUsecase>(
      () => SubmitOTPUsecase(instance()));
  instance
      .registerLazySingleton<SignInUsecase>(() => SignInUsecase(instance()));
  instance.registerLazySingleton<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(instance()));
  instance
      .registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(instance()));
}
