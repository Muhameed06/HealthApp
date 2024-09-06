### Health App
This is a health tracking built with Dart and Flutter. It allows users to check patient health. It was built using MVC architecture and GetX for State Management

### Features

Upload Screen:

* Contains a progress bar to observe the current percentage of uploading.
* Includes a button ('Start Upload') to start uploading data for the patient.
* Includes a button ('View Uploads') to navigate to patients screen.
  
Patient Screen:

* Containts a list of patients and theirs id's. You can click on each of them and observe their current health.
* Containts a deletion icon on each cell to delete the specific patient.

Patient Details Screen:

* Containts a list of patients details and their current health.

### Instructions

| Command | Description |
| --- | --- |
| `git clone <repository-url>` | Cloning the Repository |
| `cd <project-directory>` | Navigating to the Project Directory |
| `flutter pub get` | Installing Dependencies |

### UploadPage:

* Click on 'Start Button' and upload the data
* Button will be disabled until data is uploaded
* A snackbar will display if data is uploaded successfully
* A snackbar will display if there is something wrong
  
### Patient Screen:

* Use the delete icon to delete patients
* Slide to refresh data
* Click on cell to navigate to that specific patient

### Third party libraries

* supabase_flutter - For backend
* get - For State Management
* get_it - For Dependency Injection
* percent_indicator - For circle progress bar
* uuid - For generating ids
* intl - For formatting 


## License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to adjust any details as needed!

### Resources
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

