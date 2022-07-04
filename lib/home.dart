// ignore_for_file: unnecessary_this

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:farmer_asseser/result.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ownVariety = true;
  String? imagePath;
  XFile? capturedImage;
  void _getImage() async {
    try {
      XFile? imageXfile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (imageXfile == null) return null;
      final imageTemp = XFile(imageXfile.path);
      setState(() {
        capturedImage = imageTemp;
        imagePath = imageXfile.path;
      });
    } catch (e) {
      debugPrint('error Message is ${e.toString()}');
    }
  }

  // List<dynamic> fruitItems = [
  //   {'id': 1, 'label': "Apple"},
  //   {'id': 2, 'label': "Banana"},
  //   {'id': 3, 'label': "Mango"}
  // ];
  // final vegesItems = <String>[
  //   ' spinach',
  //   'onion ',
  // ];
  // List<dynamic> commodities = [
  //   {'Id': 1, 'Lablel': 'Apple1', 'ParentId': 1},
  //   {'Id': 2, 'Lablel': 'Apple2', 'ParentId': 1},
  //   {'Id': 3, 'Lablel': 'Apple3', 'ParentId': 1},
  //   {'Id': 4, 'Lablel': 'Apple4', 'ParentId': 1},
  //   {'Id': 5, 'Lablel': 'Apple5', 'ParentId': 1},
  //   {'Id': 1, 'Lablel': 'banana1', 'ParentId': 2},
  //   {'Id': 1, 'Lablel': 'banana2', 'ParentId': 2},
  // ];

  String? _selectedCategory;

  var category = {'Fruits': 'FR', 'Vegetable': "VG", 'Grains': 'GR'};
  TextEditingController varietyController = TextEditingController();

  List categories = [];
  categorydependentDropDown() {
    category.forEach((key, value) {
      setState(() {
        _selectedCategory = category[0];
      });
      categories.add(key);
    });
  }

  String _selectedCommodity = "";
  var state = {
    'Banana': 'FR',
    'Apple': 'FR',
    'Orange': 'FR',
    'MuskMelon': 'FR',
    'Sapota': 'FR',
    'Onion': 'VG',
    'potato': 'VG',
    'Tomato': 'VG',
    'Shelling Peas': 'VG',
    'Bitter Gourd': 'VG',
    'Cauliflower': 'VG',
  };

  List _commmodities = [];
  commmodityDependentDropDown(countryShortName) {
    state.forEach((key, value) {
      if (countryShortName == value) {
        _commmodities.add(key);
      }
    });
    _selectedCommodity = _commmodities[0];
  }

  String _selectedVariety = "";
  var variety = {
    'Apple Kashmiri': 'Apple',
    'Kinnor': 'Apple',
    'Royal Delicious': 'Apple',
    'Royal Gold': 'Apple',
    'Apple Golden ': 'Apple',
    'American': 'Apple',
    'Pittu': 'Apple',
    'Dwarf Cavendish': 'Banana',
    'Robusta': 'Banana',
    'Rasthali': 'Banana',
    'Safed': 'Banana',
    'Velechi Musa': 'Banana',
    'Karpuravalli': 'Banana',
    'Monthan': 'Banana',
    'Arka ranjhas': 'MuskMelon',
    'Annamalai': 'MuskMelon',
    'Lenow safed': 'MuskMelon',
    'punjab sunahri': 'MuskMelon',
    'Durgapura Madhu': 'MuskMelon',
    'Arka Jest': 'MuskMelon',
    'Pusa Asaarbati': 'MuskMelon',
    'Hara Madhu': 'MuskMelon',
    'Cricket ball': 'Sapota',
    'Gandhevi Barada ': 'Sapoata',
    'Baharu': 'Sapoata',
    'Baramasi': 'Sapoata',
    'DHS-1': 'Sapoata',
    'DHS-2': 'Sapoata',
    'calcutta Round': 'Sapoata',
    'kalipatti': 'Sapoata',
    'Kinnow mandarin': 'Orange',
    'Sumithra mandar': 'Orange',
    'darjeeling Mandarin': 'Orange',

    ////////////////////
    'Bhima Raj': 'Onion',
    'Bhima Red': 'Onion',
    'Bhima Super': 'Onion',
    'Ludhiana': 'Onion',
    'Kufri Sindhuri': 'potato',
    'Kufri ChanderMukhi': 'potato',
    'Kufri Jyoti': 'potato',
    'Kufri Lauvkar': 'potato',
    'Arka Saurabh': 'Tomato',
    'Arka Vikas': 'Tomato',
    'Arka Ahuti': 'Tomato',
    'Arka Ashish': 'Tomato',
    'Arkel': 'Shelling Peas',
    'Jwahar Matar-4': 'Shelling Peas',
    'Bonneville': 'Shelling Peas',
    'P-8': 'Shelling Peas',
    'MDU 1': 'Bitter Gourd',
    'Arka Harit': 'Bitter Gourd',
    'Priya': 'Bitter Gourd',
    'Preethi': 'Bitter Gourd',
    'Pusa Deepali': 'Cauliflower',
    'Early Kunwari': 'Cauliflower',
    'Pushpa': 'Cauliflower',
    'Aishwarya': 'Cauliflower',
  };

  List _varieties = [];
  varietyDependentDropDown(stateShortName) {
    variety.forEach((key, value) {
      if (stateShortName == value) {
        _varieties.add(key);
      }
    });
    _selectedVariety = _varieties[0];
  }

  int _selectedsize = 0;
  var sizes = {
    '65': 'Onion',
    '45': 'Onion',
    '25': 'Onion',
    70: 'potato',
    50: 'potato',
    70: 'potato',
    '65': 'Tomato',
    '55': 'Tomato',
    '45': 'Tomato',
    '65': 'Shelling Peas',
    '55': 'Shelling Peas',
    '45': 'Shelling Peas',
    '150': 'Bitter Gourd',
    '100': 'Bitter Gourd',
    '60': 'Bitter Gourd',
    '65': 'Cauliflower',
    '55': 'Cauliflower',
    '45': 'Cauliflower',
  };

  List _sizeofcommodity = [];
  sizeDependentDropDown(countryShortName) {
    sizes.forEach((key, value) {
      if (countryShortName == value) {
        _sizeofcommodity.add(key);
      }
    });
    _selectedsize = _sizeofcommodity[0];
  }

  String _selectedDefect = "";
  var DefectType = {
    'Cut': 'Onion',
    'Split-Double-split': 'Onion',
    'Sprouted': 'Onion',
    'rooting': 'Onion',
    'Cracks-cut': 'potato',
    'greening': 'potato',
    'Holes': 'potato',
    'mechanical-injury': 'potato',
    'Dry-crack-cut': 'Tomato',
    'sunburn': 'Tomato',
    'Mechanical-injury': 'Tomato',
    'Discolouration': 'Tomato',
    'Under-developed': 'Shelling Peas',
    'BlackBrown-spots': 'Shelling Peas',
    'Dry_skin': 'Shelling Peas',
    'Skin_color_defect': 'Bitter Gourd',
    'color': 'Bitter Gourd',
    'holes': 'Bitter Gourd',
    'brushing': 'Cauliflower',
    'color': 'Cauliflower',
    'wooliness': 'Cauliflower',
  };

  List _defects = [];
  defectDependentDropDown(countryShortName) {
    DefectType.forEach((key, value) {
      if (countryShortName == value) {
        _defects.add(key);
      }
    });
    _selectedDefect = _defects[0];
  }

  int _selectedDefectValue = 0;
  var defectValue = {
    '1': 'Cut',
    '2': 'Cut',
    '15': 'Cut',
    '2': 'Split-Double-split',
    '5': 'Split-Double-split',
    '8': 'Split-Double-split',
    '2': 'Sprouted',
    '5': 'Sprouted',
    '8': 'Sprouted',
    '2': 'rooting',
    '5': 'rooting',
    '8': 'rooting',
    5: 'Cracks-cut',
    6: 'Cracks-cut',
    15: 'Cracks-cut',
    '2': 'greening',
    '3': 'greening',
    '4': 'greening',
    '1': 'Holes',
    '2': 'Holes',
    '3': 'Holes',
    '2': 'mechanical-injury',
    '3': 'mechanical-injury',
    '4': 'mechanical-injury',
    '2': 'Dry-crack-cut',
    '3': 'Dry-crack-cut',
    '4': 'Dry-crack-cut',
    '2': 'sunburn',
    '3': 'sunburn',
    '4': 'sunburn',
    '2': 'Mechanical-injury',
    '2': 'Mechanical-injury',
    '4': 'Mechanical-injury',
    '3': 'Discolouration',
    '5': 'Discolouration',
    '6': 'Discolouration',
    '3': 'Under-developed',
    '5': 'Under-developed',
    '6': 'Under-developed',
    '1': 'BlackBrown-spots',
    '2': 'BlackBrown-spots',
    '3': 'BlackBrown-spots',
    '10': 'Dry_skin',
    '20': 'Dry_skin',
    '21': 'Dry_skin',
    '3': 'Skin_color_defect',
    '5': 'Skin_color_defect',
    '7': 'Skin_color_defect',
    '70': 'color',
    '40': 'color',
    '39': 'color',
    '0': 'holes',
    '1': 'holes',
    '2': 'holes',
    '3': 'brushing',
    '5': 'brushing',
    '7': 'brushing',
    '3': 'color',
    '5': 'color',
    '7': 'color',
    '3': 'wooliness',
    '5': 'wooliness',
    '7': 'wooliness',
  };

  List _defectvalues = [];
  defectvalueDependentDropDown(countryShortName) {
    defectValue.forEach((key, value) {
      if (countryShortName == value) {
        _defectvalues.add(key);
      }
    });
    _selectedDefectValue = _defectvalues[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categorydependentDropDown();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    varietyController.dispose();
  }

  bool isbytes = false;

  String rank = '';
  String shelflife = '';
  String myImage = '';
  late Uint8List bytes;

  Future<void> uploadImage(Map<String, dynamic> data) async {
    debugPrint('$data');
    try {
      final http.Response res = await http.post(
          Uri.parse(
              'http://ec2-3-110-203-9.ap-south-1.compute.amazonaws.com:8000/post/'),
          body: jsonEncode(data),
          headers: {
            'content-type': 'application/json',
            'accept': "application/json"
          });

      debugPrint('${res.statusCode}');
      debugPrint('Response: ${res.body}');
      debugPrint('Response: ${res.runtimeType}');
      //debugPrint(jsonDecode(res).toString());
      Map<String, dynamic> map = jsonDecode(res.body);
      setState(() {
        rank = map['rank'].toString();
        shelflife = map['shelflife'].toString();
        myImage = map['img_str'].toString();
        bytes = Base64Decoder().convert(myImage);
        isbytes = true;
      });

      debugPrint(rank);
      debugPrint(shelflife);
      debugPrint(myImage);
    } catch (e) {
      debugPrint('$e');
    }

    // final param = jsonDecode(res.body.toString());
  }

  void _apiCallSetStates(path) {
    var data = {
      'category': _selectedCategory,
      'commodity_name': _selectedCommodity,
      'commodity_variety': _selectedVariety,
      'commodity_size': _selectedsize,
      'commodity_defect_type': _selectedDefect,
      'commodity_defect_value': _selectedDefectValue
    };

    uploadImage(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text('Farmer_Asseser'),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 23,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            _selectedCategory == null
                                ? 'Fruits/Vegetable/Grains'
                                : "$_selectedCategory",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          child: DropdownButton(
                            value: _selectedCategory,
                            onChanged: (newValue) {
                              setState(() {
                                _varieties = [];
                                _commmodities = [];
                                _sizeofcommodity = [];
                                _defects = [];
                                _defectvalues = [];

                                commmodityDependentDropDown(category[newValue]);
                                _selectedCategory = newValue.toString();
                              });
                            },
                            items: categories.map((country) {
                              return DropdownMenuItem(
                                child: Text(
                                  country,
                                  style: TextStyle(fontSize: 10),
                                ),
                                value: country,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$_selectedCommodity",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        SizedBox(
                          width: 400,
                          child: DropdownButton(
                            value: _selectedCommodity,
                            onChanged: (newValue) {
                              print(newValue);

                              setState(() {
                                print(newValue);
                                _varieties = [];
                                _sizeofcommodity = [];
                                _defects = [];
                                _defectvalues = [];

                                sizeDependentDropDown(newValue);
                                defectDependentDropDown(newValue);

                                varietyDependentDropDown(newValue);
                                _selectedCommodity = newValue.toString();
                              });
                            },
                            items: _commmodities.map((comd) {
                              return DropdownMenuItem(
                                child: new Text(comd),
                                value: comd,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$_selectedVariety",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        Container(
                          width: 400,
                          child: DropdownButton(
                            value: _selectedVariety,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedVariety = "$newValue";
                              });
                            },
                            items: _varieties.map((city) {
                              return DropdownMenuItem(
                                child: new Text(city),
                                value: city,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      " Size of ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: DropdownButton(
                                      value: _selectedsize,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _defectvalues = [];

                                          _selectedsize = newValue as int;
                                        });
                                      },
                                      items: _sizeofcommodity.map((size) {
                                        return DropdownMenuItem(
                                          child: new Text(size.toString()),
                                          value: size,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "defectType   ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: DropdownButton(
                                      value: _selectedDefect,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _defectvalues = [];
                                          defectvalueDependentDropDown(
                                              newValue);

                                          _selectedDefect = "$newValue";
                                        });
                                      },
                                      items: _defects.map((city) {
                                        return DropdownMenuItem(
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: new Text(
                                                city,
                                                style: TextStyle(fontSize: 10),
                                              )),
                                          value: city,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                        SizedBox(
                          height: 23,
                        ),
                        Container(
                          width: 150,
                          child: DropdownButton(
                            value: _selectedDefectValue,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedDefectValue = newValue as int;
                              });
                            },
                            items: _defectvalues.map((city) {
                              return DropdownMenuItem(
                                child: new Text(city.toString()),
                                value: city,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                            controller: varietyController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.keyboard),
                                hintText: 'type Here',
                                labelText: 'Enter variety '),
                            onSaved: (val) {
                              setState(() {
                                _selectedVariety = val.toString();
                              });
                            }),
                        Text(
                          '$_selectedVariety',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // GestureDetector(
                              //   onTap: () {
                              //     _getImage();
                              //   },
                              //   child: Container(
                              //     height: 60,
                              //     width: 160,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(8),
                              //         color: Colors.grey),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceAround,
                              //       children: [
                              //         Icon(
                              //           Icons.image,
                              //           size: 35,
                              //         ),
                              //         Text(
                              //           'Select a picture',
                              //           style: TextStyle(color: Colors.black),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Container(
                                child: isbytes
                                    ? Image.memory(bytes)
                                    : Image.asset('assets/cloudy.png'),
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(height: 20),
                        Text('Rank $rank'),
                        SizedBox(height: 20),
                        Text('shelflife $shelflife'),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          splashColor: Colors.red,
                          onTap: () {
                            _apiCallSetStates(imagePath);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MyResults(
                            //             bytes: bytes,
                            //             rank: rank,
                            //             shelflife: shelflife)));
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.purple),
                            child: Center(child: Text('Post')),
                          ),
                        )
                      ])),
            )));
  }
}