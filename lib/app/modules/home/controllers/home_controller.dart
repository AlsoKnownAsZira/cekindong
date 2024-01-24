import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  List<Ongkir> ongkosKirim = [];

  RxBool isloading = false.obs;
  TextEditingController beratController = TextEditingController();
  RxString asalProv = "0".obs;
  RxString asalKota = "0".obs;
  RxString tujuanProv = "0".obs;
  RxString tujuanKota = "0".obs;
  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if (asalProv != "0" &&
        asalKota != "0" &&
        tujuanProv != "0" &&
        tujuanKota != "0" &&
        codeKurir != "" &&
        beratController != "") {
      //execute code
      try {
        isloading.value = true;
        var response = await Dio().post(
          "https://api.rajaongkir.com/starter/cost",
          options: Options(
            headers: {
              "key": "140e0f05297c77ae8ed7e1336a8a784f",
            },
          ),
          data: {
            "origin": asalKota.value,
            "destination": tujuanKota.value,
            "weight": beratController.text,
            "courier": codeKurir.value,
          },
        );
        isloading.value = false;
        List ongkir = response.data["rajaongkir"]["results"][0]["costs"]
            as List; //response.data sama dengan json.decode pada http request
        ongkosKirim = Ongkir.fromJsonList(ongkir);
        Get.defaultDialog(
          title: "ONGKOS KIRIM:",
          content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ongkosKirim
                  .map((e) => ListTile(
                        title: Text(e.service!.toUpperCase()),
                        subtitle: Text(e.description!.toUpperCase()),
                        trailing: Text("Rp ${e.cost![0].value}"),
                      ))
                  .toList()),
        );
      } catch (e) {
        print(e);
        Get.defaultDialog(title: "Error", middleText: "Tidak bisa cek ongkir!");
      }
    } else {
      Get.defaultDialog(
          title: "Error", middleText: "Lengkapi data terlebih dahulu!");
    }
  }
}
