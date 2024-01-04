import 'package:cekindong/app/data/models/province_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('cekindong - Cek Ongkir Disini!'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownSearch<Province>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) => ListTile(
                  selected: isSelected,
                  title: Text("${item.province}"),
                ),
              ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih Provinsi",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder()),
                ),
                asyncItems: (text) async {
                  var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "140e0f05297c77ae8ed7e1336a8a784f"
                    },
                  );
                  return Province.fromJsonList(
                      response.data["rajaongkir"]["results"]);
                })
          ],
        ));
  }
}
