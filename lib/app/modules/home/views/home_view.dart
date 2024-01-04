import 'package:cekindong/app/data/models/province_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../data/models/city_model.dart';

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
                    labelText: "Pilih Provinsi Asal",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder()),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "140e0f05297c77ae8ed7e1336a8a784f"},
                );
                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.asalProv.value = value?.provinceId ?? "0",
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<City>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) => ListTile(
                  selected: isSelected,
                  title: Text("${item.type} ${item.cityName}"),
                ),
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Kota/Kabupaten ASal",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder()),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.asalProv}",
                  queryParameters: {"key": "140e0f05297c77ae8ed7e1336a8a784f"},
                );
                return City.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.asalKota.value = value?.cityId ?? "0",
            ),
            const SizedBox(
              height: 40,
            ),
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
                    labelText: "Pilih Provinsi Tujuan",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder()),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "140e0f05297c77ae8ed7e1336a8a784f"},
                );
                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.tujuanProv.value = value?.provinceId ?? "0",
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<City>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) => ListTile(
                  selected: isSelected,
                  title: Text("${item.type} ${item.cityName}"),
                ),
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Kota/Kabupaten Tujuan",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder()),
              ),
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.tujuanProv}",
                  queryParameters: {"key": "140e0f05297c77ae8ed7e1336a8a784f"},
                );
                return City.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.tujuanKota.value = value?.cityId ?? "0",
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<Map<String, dynamic>>(
              items: [
                {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                {"code": "pos", "name": "POS Indonesia (POS)"},
                {"code": "tiki", "name": "Titipan Kilat (TIKI)"},
              ],
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) => ListTile(
                  selected: isSelected,
                  title: Text("${item["name"]}"),
                ),
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Jasa Kirim",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder())
                    ,
              ),
              dropdownBuilder:(context, selectedItem) => Text("${selectedItem?["name"] ?? "Pilih Jasa Kirim"}") ,
            ),
          const  SizedBox(height: 20),
          ElevatedButton(onPressed: (){}, child: const Text("Cek Ongkir Disini"))
          ],
        ));
  }
}
