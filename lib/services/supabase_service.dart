import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/models/user_health.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> uploadChunks(List<UserHealthModel> data, String uploadId,
      String userId, RxDouble progress) async {
    const batchLimit = 500;
    int concurrentLimit = 20;

    await _client.from('users').upsert({
      'id': uploadId,
      'timestamp': DateTime.now().toIso8601String(),
      'total_data_points': data.length,
      'user_id': userId,
    });

    List<Future<void>> uploadFutures = [];
    int totalChunks = (data.length / batchLimit).ceil();
    int completedChunks = 0;

    for (int i = 0; i < data.length; i += batchLimit) {
      final chunk = data.sublist(
          i, i + batchLimit > data.length ? data.length : i + batchLimit);

      if (uploadFutures.length >= concurrentLimit) {
        await Future.wait(uploadFutures);
        uploadFutures.clear();
      }

      uploadFutures.add(_uploadChunk(chunk, uploadId).then((_) {
        completedChunks++;
        double currentProgress = completedChunks / totalChunks;
        progress.value = currentProgress;
        debugPrint('Progress updated: ${currentProgress * 100}%');
      }));
    }

    if (uploadFutures.isNotEmpty) {
      await Future.wait(uploadFutures);
    }
  }

  Future<void> _uploadChunk(
      List<UserHealthModel> chunk, String uploadId) async {
    try {
      final data = chunk
          .map((dataPoint) => {
                ...dataPoint.toMap(),
                'upload_id': uploadId,
              })
          .toList();

      final response = await _client.from('health_data').upsert(data);
      if (response.error != null) {
        debugPrint('Error uploading chunk: ${response.error!.message}');
      }
    } catch (e) {
      debugPrint('Exception during upload chunk: $e');
    }
  }

  Future<void> deletePatient(String uploadId) async {
    try {
      final response = await _client.from('users').delete().eq('id', uploadId);

      if (response != null) {
        throw Exception('Failed to delete user: ${response.error!.message}');
      }
    } catch (e) {
      throw Exception('Failed to delete user: ${e.toString()}');
    }
  }

  Stream<List<Map<String, dynamic>>> getPatients() {
    return _client
        .from('users')
        .stream(primaryKey: ['id']).order('timestamp', ascending: false);
  }

  Stream<List<Map<String, dynamic>>> getPatientsDetails(String uploadId) {
    return _client
        .from('health_data')
        .stream(primaryKey: ['id'])
        .eq('upload_id', uploadId)
        .order('timestamp', ascending: false);
  }
}
