import 'package:dio/dio.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/snackbar_handler.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BackCardController extends GetxController {
  RxBool loading = false.obs;
  RxBool isloading = false.obs;

  // ignore: deprecated_member_use
  // var categoryList = List<Category>().obs;
  // var smartmixList = SmartMix().obs;

  // var startsmartmix = CategoryBrowse().obs;

  smartMixmoveOn({
    int cardId,
    String practiceType,
    Function onSuccess,
    var images,
    var content,
    var video,
    var id,
    var title,
  }) async {
    try {
      isloading.value = true;
      final response = await NetworkClient.post(
        '/smart-mix-move-on',
        {"card_id": cardId, "practice_type": practiceType},
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          id = response.data['data']['id'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images);
          }
        } else
          SnackbarHandler.errorToast(
              'Card Move on', 'Further No Cards available');
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      isloading.value = false;
    }
  }

  categorymoveOn({
    int cardId,
    String practiceType,
    Function onSuccess,
    var images,
    var content,
    var video,
    var id,
    var title,
  }) async {
    try {
      isloading.value = true;
      final response = await NetworkClient.post(
        '/category/move',
        {"card_id": cardId, "practice_type": practiceType},
      );
      print(response);

      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          id = response.data['data']['id'];
          images = response.data['data']['image'];
          title = response.data['data']['title'];

          video = response.data['data']['video'];
          content = response.data['data']['content'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images);
          }
        } else
          SnackbarHandler.errorToast(
              'Card Move on', 'Further No Cards available');
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      isloading.value = false;
    }
  }

  smartmixwork({
    int cardId,
    String practiceTypes,
    Function onSuccess,
    var images,
    var content,
    var video,
    var id,
    var title,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/needs/work',
        {"card_id": cardId, "practiceType": practiceTypes},
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          id = response.data['data']['id'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images);
          }
        } else
          SnackbarHandler.errorToast(
              'Card Need Work', 'Further No Cards available');
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  categorywork({
    int cardId,
    String practiceTypes,
    Function onSuccess,
    var images,
    var content,
    var video,
    var id,
    var title,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/category/needs/work',
        {"card_id": cardId, "practiceType": practiceTypes},
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          images = response.data['data']['image'];
          title = response.data['data']['title'];
          id = response.data['data']['id'];
          video = response.data['data']['video'];
          content = response.data['data']['content'];
          if (onSuccess != null) {
            onSuccess(title, id, video, content, images);
          }
        } else
          SnackbarHandler.errorToast(
              'Card Need Work', 'Further No Cards available');
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  restProgress({Function onSuccess, type}) async {
    try {
      loading.value = true;
      final response =
          await NetworkClient.post('/progress/reset?type=$type', {});
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess();
          print(response.realUri);
        }
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  // mentalPractice(type) async {
  //   print(type);
  //   try {
  //     loading.value = true;
  //     final response = await NetworkClient.get('/course?type=$type');
  //     List<dynamic> _categoryList = response.data['data']['categories'];
  //     categoryList.value =
  //         _categoryList.map((json) => Category.fromJson(json)).toList();

  //     var smartmixLists = response.data['data']['smart_mix_global'];
  //     smartmixList.value = SmartMix.fromJson(smartmixLists);
  //     // smartmixLists((json) => SmartMix.fromJson(json));
  //     print(smartmixList.value);
  //   } on DioError catch (e) {
  //     NetworkClient.errorHandler(e);
  //   } finally {
  //     loading.value = false;
  //   }
  //   try {
  //     loading.value = true;

  //     final response = await NetworkClient.get(
  //       '/smart-mix?type=$type',
  //     );

  //     print(response.realUri);
  //     var startsmartmixs = response.data['data'];
  //     startsmartmix.value = CategoryBrowse.fromJson(startsmartmixs);
  //     //startsmartmixs((json) => CategoryBrowse.fromJson(json));
  //     print(startsmartmix.value);
  //   } on DioError catch (e) {
  //     NetworkClient.errorHandler(e);
  //   } finally {
  //     loading.value = false;
  //   }
  // }
}
