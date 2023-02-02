import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchController extends GetxController{

  final myText = "".obs;
  var storage = GetStorage();
  // don't change this - stores the actual API response
  var responseData = <dynamic>[].obs;
  
  // to store the temporary filtered data array
  var filteredData = <dynamic>[].obs;
  var queryType = 0.obs;


  // sends request to the api with the given text as query
  // change the name of the API when received 

  Future<dynamic> sendRequest(myText) async {
    const String API_URL = "https://hgqg4q8s9h.execute-api.us-east-1.amazonaws.com/prod/enterprise/dataVault";
    print("Now sending the request with text: ${myText}");
    
    // change to post later on 
    final response;

    // whenever you get the correct api-url:
    if(queryType == 1){
      // send only string to the API:
      response = await http.post(
        Uri.parse(API_URL),
        body: jsonEncode(<String, String>{
          'query' : myText
        }));

        var data = jsonDecode(response.body);
        // print(data);
        responseData.value = data;
        // print(responseData.value);
        storage.write("actualResponse", responseData.value);
        // print(storage.read("actualResponse"));

        if(response.statusCode == 200){
          return responseData.value; 
        }else{
          return responseData.value;
        }


    }else if(queryType == 3){
      response = await http.post(
        Uri.parse(API_URL),
        body: jsonEncode(<String, dynamic>{
          'query' : myText,
          'year' : 2021
        }),
      );

      var data = jsonDecode(response.body);
      // print("Query 3 data: ${data}");

      responseData.value = data.entries.map((e) => {e.key: e.value}).toList();
      storage.write("actualResponse", responseData.value);
      print(storage.read("actualResponse"));

      // print("Query3 response: ${responseData.value}");

      if(response.statusCode == 200){
        return responseData.value; 
      }else{
        return responseData.value;
      }
    }


    // storing the API response
    

    // storing the API response for when we get the correct API; 
    // if (queryType == 1){
    //   for(Map<String, dynamic> item in data){
    //     responseData.value.add(item);
    //   } 
    // }else if (queryType == 3){
    //   for(Map<String, dynamic> item in data.values){
    //     responseData.value.add(item);
    //   }
    // }
  }


  // will update the type of query based on the query entered by the user. 
  // include query type 2 whenever it gets available 
  void updateQueryType(myText){

    // check if patient word is mentioned:
    if (myText == "Gender, Age, Organization, Location and Disease of the patient"){
      queryType.value = 1;
    }
    // else type 3
    else if(myText == "Disease of the patient"){
      queryType.value = 3;
    }
    print(queryType.value);
  }

// 
}