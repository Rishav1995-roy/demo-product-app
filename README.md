# product_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# archutechure follwed
I have follwed mix of MVVM and clean architechure.

# state management tool
I have used bloc becuase for longer projects It is better to used rather than Provider or Riverpod

# app structure
lib\
--- network\
----- model\ 
        # Contains all the model class including the base model class where every will api and then it will parse to the respective model class
----- repository\
        # Contains all the repository class that will connect with the bloc of the every class. So the basic api parsing will not be happen in the bloc level or class level
----- service\
        # Each repository has own service class that will call the http class and basic api parsing will done here then the data will come pass to the repository.
---- resources\
------ animations
        # define all the lotties files here from assets
------ colors
        # define all the colors
------ images
        # define all the image files here from assets
------ strings
        # define all the hardcoded strings
----- screens\
[naming convetion: fetaure_name_screen]
------ bloc
        # define all the screen level bloc, event, states here
------ screens
        # define all the required screen for a particular feature
------ widgets
        # define all the required widgets for a particular feature and it should be stateless.
----- utils\
   # All the respective utils like conext extesions, text utils, local storage & common functions will be deined here so that It can be accsible from any screens or widgets.
----- app.dart
----- locator.dart
----- main.dart                                      


