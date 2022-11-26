import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harivara_assesment/services/app_services.dart';
import 'package:harivara_assesment/widgets/my_checkbox.dart';
import 'package:harivara_assesment/widgets/text_field_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List alphabets = [];
List numbers = [];
bool isLoading = true;

int totalNumberonEachSide = 0;

int initialTotalSelectionForBothSide = 0;
int totalSelectedForBothSide = 0;

int initialSelectedAlphabetCount = 0;
int selectedAlphabetCount = 0;

int initialSelectedNumberCount = 0;
int selectedNumberCount = 0;

String errorCode = '';

AppServices appServices = AppServices();

TextEditingController totalboxEachSideController = TextEditingController();
TextEditingController maxNoOfSelBothsideController = TextEditingController();
TextEditingController noOfAlphabetController = TextEditingController();
TextEditingController noOfNumberController = TextEditingController();

class _HomePageState extends State<HomePage> {
  void readDataFromJson() async {
    final String response = await rootBundle.loadString('assets/mydata.json');
    final data = await json.decode(response);
    setState(() {
      alphabets = data['alphabets'];
      numbers = data['numbers'];
      isLoading = false;
    });
  }

  void checkTotalSelectionAllowedForBothSides(bool status, String alpOrNumb) {
    if (status == true) {
      totalSelectedForBothSide = totalSelectedForBothSide + 1;
      if (totalSelectedForBothSide > initialTotalSelectionForBothSide) {
        setState(() {
          errorCode = '412';
        });
      }
      if (alpOrNumb == 'ALP') {
        selectedAlphabetCount = selectedAlphabetCount + 1;
        if (selectedAlphabetCount > initialSelectedAlphabetCount) {
          setState(() {
            errorCode = '410';
          });
        }
      } else {
        selectedNumberCount = selectedNumberCount + 1;
        if (selectedNumberCount > initialSelectedNumberCount) {
          setState(() {
            errorCode = '411';
          });
        }
      }
    } else {
      totalSelectedForBothSide = totalSelectedForBothSide - 1;
      if (totalSelectedForBothSide > initialTotalSelectionForBothSide) {
        setState(() {
          errorCode = '412';
        });
      } else {
        setState(() {
          errorCode = '0';
        });
      }
      if (alpOrNumb == 'ALP') {
        selectedAlphabetCount = selectedAlphabetCount - 1;
        if (selectedAlphabetCount > initialSelectedAlphabetCount) {
          setState(() {
            errorCode = '410';
          });
        }
      } else {
        selectedNumberCount = selectedNumberCount - 1;
        if (selectedNumberCount > initialSelectedNumberCount) {
          setState(() {
            errorCode = '411';
          });
        }
      }
    }
  }

  @override
  void initState() {
    readDataFromJson();
    super.initState();
  }

  @override
  void dispose() {
    totalboxEachSideController.dispose();
    maxNoOfSelBothsideController.dispose();
    noOfAlphabetController.dispose();
    noOfNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Harivara',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFieldWidget(
            label: 'Total no of boxes to be displayed on each side',
            textEditingController: totalboxEachSideController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  totalNumberonEachSide = 0;
                  errorCode = '0';
                });
              } else if (int.parse(value) > 11) {
                setState(() {
                  errorCode = '416';
                });
              } else {
                setState(() {
                  totalNumberonEachSide = int.parse(value);
                  errorCode = '0';
                });
              }
            },
          ),
          TextFieldWidget(
            label:
                'Max no of Total Selections allowed for selecting on both the sides',
            textEditingController: maxNoOfSelBothsideController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  initialTotalSelectionForBothSide = 0;
                  errorCode = '0';
                });
              } else {
                setState(() {
                  initialTotalSelectionForBothSide = int.parse(value);
                  errorCode = '0';
                });
              }
            },
          ),
          TextFieldWidget(
            label: 'Max no of Alphabets allowed for selecting',
            textEditingController: noOfAlphabetController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  initialSelectedAlphabetCount = 0;
                  errorCode = '0';
                });
              } else if (int.parse(value) > 11) {
                setState(() {
                  errorCode = '414';
                });
              } else {
                setState(() {
                  initialSelectedAlphabetCount = int.parse(value);
                  errorCode = '0';
                });
              }
            },
          ),
          TextFieldWidget(
            label: 'Max no of Numbers allowed for selecting',
            textEditingController: noOfNumberController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  initialSelectedNumberCount = 0;
                  errorCode = '0';
                });
              } else if (int.parse(value) > 11) {
                setState(() {
                  errorCode = '415';
                });
              } else {
                setState(() {
                  initialSelectedNumberCount = int.parse(value);
                  errorCode = '0';
                });
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.yellow,
                    height: 550,
                    child: isLoading == true
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: totalNumberonEachSide,
                            itemBuilder: (context, index) {
                              return MyCheckBox(
                                label: alphabets[index],
                                value: false,
                                alphabetOrNumber: 'ALP',
                                onTotalSelectionChanged:
                                    (bool status, String alpOrNum) =>
                                        checkTotalSelectionAllowedForBothSides(
                                            status, alpOrNum),
                              );
                            },
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 550,
                    child: isLoading == true
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: totalNumberonEachSide,
                            itemBuilder: (context, index) {
                              return MyCheckBox(
                                label: numbers[index].toString(),
                                value: false,
                                alphabetOrNumber: 'NUM',
                                onTotalSelectionChanged:
                                    (bool status, String alpOrNumber) =>
                                        checkTotalSelectionAllowedForBothSides(
                                            status, alpOrNumber),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    totalboxEachSideController.clear();
                    maxNoOfSelBothsideController.clear();
                    noOfAlphabetController.clear();
                    noOfNumberController.clear();
                    setState(() {
                      totalNumberonEachSide = 0;
                      initialTotalSelectionForBothSide = 0;
                      totalSelectedForBothSide = 0;
                      initialSelectedAlphabetCount = 0;
                      selectedAlphabetCount = 0;
                      initialSelectedNumberCount = 0;
                      selectedNumberCount = 0;
                      errorCode = '';
                    });
                  },
                  child: Container(
                    height: 80,
                    color: Colors.purple,
                    child: const Center(
                      child: Text(
                        'Reset All Values to 0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 80,
                  color: errorCode == '0' ? Colors.green : Colors.red,
                  child: Center(
                    child: errorCode == '0'
                        ? const Text(
                            'Success',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            appServices.checkError(errorCode),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
