#  Advanced Exercise Finder - MVVM Flutter Use Case

Advanced Exercise Finder is a Flutter app where you can search for exercises with multiple filtering features and create, delete and edit your own workout program. The application uses https://api-ninjas.com/api/exercises as a service.

## Screenshots

<img src="https://github.com/SamedHrmn/advanced-exercise-finder-flutter-usecase/assets/60006881/f377c51c-d356-42a1-b945-b22bb633a1e5" width="202">
<img src="https://github.com/SamedHrmn/advanced-exercise-finder-flutter-usecase/assets/60006881/6d0c1d0c-6c79-4336-92a3-c9d8e2a3c869" width="202">
<img src="https://github.com/SamedHrmn/advanced-exercise-finder-flutter-usecase/assets/60006881/ee09e45d-9348-4ff0-a852-fc6c0b498d7a" width="200">

## Project Structure - MVVM

<pre>
     lib--                                  
         |                                       
         |__core                                     
                |__cache
                |__components
                |__constants
                |__enums
                |__service
                |__util
         |__features                           
                |__home
                      |__model
                      |__view
                      |__viewmodel
                      |__widgets
                |__program
                      |__model
                      |__view
                      |__viewmodel
                      |__widgets
         
         locator.dart      
         main.dart
</pre>

## Dependencies
Core<br>get_it, json_annotation, flutter_dotenv<br>
Network<br>dio, dio_cache_interceptor, dio_cache_interceptor_hive_store<br>
State<br>provider<br>
Data<br>hive, hive_flutter<br>
Util<br>path_provider, flutter_slidable<br>

## How to run
1- Go https://api-ninjas.com/api/exercises and create an account.<br>
2- Create an .env folder in project directory and paste your api key as a RAPID_API_KEY and paste https://api.api-ninjas.com/v1/exercises as a API_BASE_URL.<br>
3- Run main.dart file.
