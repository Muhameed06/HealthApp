import 'dart:math';
import 'package:get/get.dart';
import 'package:health_app/models/user_health.dart';
import 'package:health_app/services/supabase_service.dart';
import 'package:uuid/uuid.dart';

class UploadController extends GetxController {
  var isLoading = false.obs;
  var progress = 0.0.obs;
  var isUploading = false.obs;
  var uploads = <Map<String, dynamic>>[].obs;
  var uploadDetails = <Map<String, dynamic>>[].obs;
  final SupabaseService _supabaseService = SupabaseService();
  final Uuid uuid = const Uuid();

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
  }

  Future<void> uploadData(List<UserHealthModel> data) async {
    String uploadId = uuid.v4();
    String userId = "User_${Random().nextInt(1000)}";

    isUploading.value = true;
    progress.value = 0.0;

    await _supabaseService.uploadChunks(data, uploadId, userId, progress);

    isUploading.value = false;
    progress.value = 1.0;
    Get.snackbar(
        'Success', 'Upload of the patient with id: $userId was successful',
        duration: const Duration(milliseconds: 1500));

    fetchPatients();
  }

  Future<void> deleteUser(String uploadId) async {
    try {
      await _supabaseService.deletePatient(uploadId);
      fetchPatients();
      Get.snackbar('Success', 'Patient was deleted successfully',
          duration: const Duration(milliseconds: 1500));
      progress.value = 0.0;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchPatients() async {
    isLoading.value = true;
    _supabaseService.getPatients().listen((data) {
      uploads.value = data;
      isLoading.value = false;
    });
  }

  Future<void> fetchPatientDetails(String uploadId) async {
    isLoading.value = true;
    _supabaseService.getPatientsDetails(uploadId).listen((data) {
      uploadDetails.value = data;
      isLoading.value = false;
    });
  }
}
