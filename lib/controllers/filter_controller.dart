import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'search_controller.dart';

class FilterController extends GetxController{

  final storage = GetStorage();

  var filterType = 0.obs;
  // will update the filter categories according to the filter type:
  var selectedFilter = "".obs;
  var filtersSelected = <dynamic>[].obs;
  var tempResponse = <dynamic>[].obs;
  var tempFilteredData = <dynamic>[].obs;

  void updateFilterType(text){
    print("Before update: ${filterType.value}");
    if (text == "Gender, Age, Organization, Location and Disease of the patient"){
      filterType.value = 1;
    }
    // else type 3
    else if(text == "Disease of the patient"){
      filterType.value = 3;
    }
    print(filterType.value);
    print("After update: ${filterType.value}");
  }

  // performs the filter on the data and saves it in the tempFilteredData array
  // TO IMPLEMENT: FILTER LOGIC BASED ON THE ACTUAL API DATA
  void performFilterOnData(selectedFilter){
    List<dynamic> actualData = storage.read("actualResponse");

    if(selectedFilter[0] == "Gender"){
      print("performing gender filter now");
      performGenderFilter(actualData);
    }else if(selectedFilter[0] == "Age"){
      performAgeFilter(actualData);
    }else if(selectedFilter[0] == "Location"){
      performLocationFilter(actualData);
    }else if(selectedFilter[0] == "Organization"){
      performOrganizationFilter(actualData);
    }else if(selectedFilter[0] == "Disease"){
      print("performing disease filter now");
      performDiseaseFilter(actualData);
    }
  }
  

    void performGenderFilter(actualData){
      Map<String, int> gender = {};
      for(Map<String, dynamic>item in actualData){
        gender.update(item["gender"], (value) => value + 1, ifAbsent: () => 1);
      }
      tempFilteredData.value = gender.entries.map((entry) => {entry.key: entry.value}).toList();
      tempResponse.value = tempFilteredData.value;
      print(tempFilteredData.value);
    }

    void performAgeFilter(actualData){
      Map<String, int> age = {"< 18 years" : 0, "18 - 25 years" : 0, "26 - 50 years" : 0, "> 50 years" : 0};
      for(Map<String, dynamic> item in actualData){
        if(item["age"] < 18){
          age["< 18 years"] = (age["< 18 years"]! + 1);
        }else if (item["age"] >= 18 && item["age"] <= 25){
          age["18 - 25 years"] = (age["18 - 25 years"]! + 1);
        }else if (item["age"] >= 26 && item["age"] <= 50){
          age["26 - 50 years"] = (age["26 - 50 years"]! + 1);
        }else{
          age["> 50 years"] = (age["> 50 years"]! + 1);
        }
      }
      tempFilteredData.value = age.entries.map((entry) => {entry.key: entry.value}).toList();
      tempResponse.value = tempFilteredData.value;
    }

    void performLocationFilter(actualData){
      Map<String, int> location = {};
      for(Map<String, dynamic>item in actualData){
        location.update(item["location"], (value) => value + 1, ifAbsent: () => 1);
      }
      tempFilteredData.value = location.entries.map((entry) => {entry.key: entry.value}).toList();
      tempResponse.value = tempFilteredData.value;
    }

    void performOrganizationFilter(actualData){
      Map<String, int> organization = {};
      for(Map<String, dynamic>item in actualData){
        organization.update(item["organization"], (value) => value + 1, ifAbsent: () => 1);
      }
      tempFilteredData.value = organization.entries.map((entry) => {entry.key: entry.value}).toList();
      tempResponse.value = tempFilteredData.value;
    }

    void performDiseaseFilter(actualData){
      Map<String, int> diseases = {};
      for(Map<String, dynamic>item in actualData){
        diseases.update(item["organization"], (value) => value + 1, ifAbsent: () => 1);
      }
      tempFilteredData.value = diseases.entries.map((entry) => {entry.key: entry.value}).toList();
      tempResponse.value = tempFilteredData.value;
    }

}