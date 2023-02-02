import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vault/controllers/chart_controller.dart';
import 'package:vault/controllers/filter_controller.dart';
import 'package:vault/controllers/search_controller.dart';
import 'package:vault/utils/responsive.dart';
import 'package:vault/widgets/custom_appbar_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({super.key});

  final searchController = Get.put(SearchController());
  final filterController = Get.put(FilterController());
  final chartController = Get.put(ChartController());
  final textController = TextEditingController();
  var storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Responsive.isDesktop(context)
              ? const SizedBox(height: 20, width: 20)
              : const SizedBox(height: 0, width: 0),
          CustomAppBarWidget(
            title: "Analytics -Data Vault",
            subTitle: "",
          ),

          // Text("Analytics -Data Vault",
          //     style: TextStyle(
          //         fontSize: 25,
          //         fontWeight: FontWeight.w900,
          //         color: HexColor("#297D68"))),
          // const SizedBox(
          //   height: 15,
          // ),

          Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  // height: 75,
                  // width: Responsive.isDesktop(context)? context.width * 0.7 : context.width * 0.8,
                  // search bar for entering query
                  child: TextField(
                    // setting the value of the text
                    controller: textController,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    onChanged: (value) => searchController.myText.value = value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Responsive.isDesktop(context)
                          ? Colors.white
                          : HexColor("#F1F1F1"),
                      border: const OutlineInputBorder(),
                      hintText: "Ex: How many patients have diabetes?",
                      // add the send query method here
                      suffixIcon: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () async {
                                    // WORKING
                                    FocusScope.of(context).unfocus();
                                    print(
                                        "The current text is: ${searchController.myText.value}");
                                    searchController.updateQueryType(
                                        searchController.myText.value);
                                    filterController.updateFilterType(
                                        searchController.myText.value);

                                    // send request and store the response back
                                    await searchController.sendRequest(
                                        searchController.myText.value);
                                    filterController.tempResponse.value =
                                        storage.read("actualResponse");
                                    if (searchController.queryType.value == 3) {
                                      chartController
                                          .convertActualDataToChartData();
                                    }
                                    print(chartController.chartData.value);
                                    print(chartController.chartData.value[0].x);
                                    print(chartController.chartData.value[0].y);
                                  }),
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  print(
                                      "The current text right now is: ${searchController.myText.value}");
                                  searchController.myText.value = "";
                                  print(
                                      "The current query type right now is: ${searchController.queryType}");
                                  searchController.queryType.value = 0;
                                  print(
                                      "The current text right now is: ${searchController.myText.value}");
                                  print(
                                      "The current query type right now is: ${searchController.queryType}");
                                  filterController.tempFilteredData.value = [];
                                  textController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                              )
                            ],
                          )),
                    ),
                    // focusNode: focusNode,
                    autofocus: true,
                  ),
                ),
                const SizedBox(height: 15, width: 15),
                // add filter button to open filter dialog box
                Container(
                  height: 50,
                  width: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Responsive.isDesktop(context)
                            ? Colors.white
                            : null),
                    child: IconButton(
                        icon: const Icon(Icons.filter_list),
                        // opens the filter menu
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                // ignore: unrelated_type_equality_checks
                                if (filterController.filterType == 1) {
                                  return MyDialog(items: const [
                                    'Gender',
                                    'Age',
                                    'Location',
                                  ]);
                                  // ignore: unrelated_type_equality_checks
                                } else if (filterController.filterType == 2) {
                                  return MyDialog(items: const [
                                    'Gender',
                                    'Age',
                                    'Location',
                                    'Organization'
                                  ]);
                                } else {
                                  return AlertDialog(
                                      title: const Text("Filters"),
                                      content: const Text(
                                          "No filters available for this query"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        )
                                      ]);
                                }
                              });
                        }),
                  ),
                )
              ]),
          const Padding(padding: EdgeInsets.all(5)),
          Obx(
            () => (searchController.queryType.value == 1 ||
                    searchController.queryType.value == 2)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Recent ( ${filterController.tempResponse.value.length} )",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: HexColor("#297D6B"))),
                    ),
                  )
                : (searchController.queryType.value == 0)
                    ? const SizedBox(width: 100, height: 100)
                    : Padding(
                        padding: const EdgeInsets.all(50),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: context.width * 0.7,
                            height: 400,
                            child: DecoratedBox(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: BarChart(BarChartData(
                                  alignment: BarChartAlignment.center,
                                  maxY: 20,
                                  minY: 0,
                                  borderData: FlBorderData(
                                      border: const Border(
                                    top: BorderSide.none,
                                    right: BorderSide.none,
                                    left: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1),
                                  )),
                                  barGroups: chartController.chartData.value
                                      .map((dataItem) => BarChartGroupData(
                                              x: dataItem.x,
                                              barRods: [
                                                BarChartRodData(
                                                    fromY: 0,
                                                    toY: dataItem.y.toDouble(),
                                                    width: 20,
                                                    color: HexColor("#40AB94")),
                                              ]))
                                      .toList())),
                            ),
                          ),
                        ),
                      ),
          ),

          // render the cards on the screen
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: filterController.tempFilteredData.value == null ||
                          filterController.filterType != 1 &&
                              filterController.filterType != 2
                      ? 0
                      : filterController.tempFilteredData.value.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: InkWell(
                            onTap: () {
                              //
                            },
                            child: Column(children: [
                              // filterController.filterType.value != 1
                              // ? Text("Data item ${index}")
                              // Column(children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                      filterController.tempFilteredData
                                          .value[index].keys.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: HexColor("#297D6B"))),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                      "Number of people: ${filterController.tempFilteredData.value[index][filterController.tempFilteredData.value[index].keys.first]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: HexColor("#40AB94"))),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class MyDialog extends StatelessWidget {
  MyDialog({super.key, required this.items});
  final filterController = Get.put(FilterController());
  List filtersSelected = [];
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filters", style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          return Obx(() => CheckboxListTile(
              title: Text(item, style: TextStyle(fontWeight: FontWeight.bold)),
              value: filterController.filtersSelected.contains(item),
              onChanged: (bool? newValue) {
                if (!filterController.filtersSelected.contains(item)) {
                  filterController.filtersSelected.add(item);
                  print(filterController.filtersSelected);
                } else {
                  if (filterController.filtersSelected.contains(item)) {
                    filterController.filtersSelected
                        .removeWhere((category) => category == item);
                    print(filterController.filtersSelected);
                  }
                }
              }));
        }).toList(),
      ),
      actions: <Widget>[
        FloatingActionButton(
            child: Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              // should send the filter array to the perform filter function
              filterController
                  .performFilterOnData(filterController.filtersSelected);
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
