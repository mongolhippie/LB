import 'dart:io';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:littlebusiness/constants.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/DAO.dart';
import 'package:flutter/services.dart';
import '../elements/alerts.dart';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';

import 'package:awesome_button/awesome_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:littlebusiness/logic/Item.dart';

class FormItemPage extends StatefulWidget {
  @override
  _FormItemPageState createState() => _FormItemPageState();
}

class _FormItemPageState extends State<FormItemPage> {
  final _formKey = GlobalKey<FormState>();
  // Active image file
  File _imageFile;
  String _name;
  String _unit;
  String _category;
  double _price;
  double _cost;
  double _unitAvailable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Item'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (_imageFile != null) ...[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Image.file(_imageFile),
                              height: 130,
                            ),
                            FlatButton(
                              child: Icon(Icons.refresh),
                              onPressed: _clear,
                            ),
                          ],
                        ),
//            Uploader(file: _imageFile)
                      ],
                      if (_imageFile != null)
                        SizedBox(
                          width: 10,
                        ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          onSaved: (value) => _name = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  if (_imageFile == null)
                    SizedBox(
                      height: 20,
                    ),
                  Text('Unit'),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomRadioButton(
                            buttonColor: Theme.of(context).canvasColor,
                            buttonLables: [
                              "Each",
                              "Liters",
                              "Weight",
                            ],
                            buttonValues: [
                              "Each",
                              "Liters",
                              "Weight",
                            ],
//                            width: MediaQuery.of(context).size.width / 3.6,
                            radioButtonValue: (value) => _unit = value,
                            horizontal: false,
                            selectedColor: borderBlue,
                            enableShape: true,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Price',
                                  ),
                                  onSaved: (value) =>
                                      _price = double.parse(value),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Cost',
                                  ),
                                  onSaved: (value) =>
                                      _cost = double.parse(value),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Units available',
                                  ),
                                  onSaved: (value) =>
                                      _unitAvailable = double.parse(value),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Platform.isIOS ? iOSPicker() : androidDropdown(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AwesomeButton(
                          height: 40,
                          blurRadius: 10.0,
                          splashColor: Color.fromRGBO(255, 255, 255, .4),
                          borderRadius: BorderRadius.circular(37.5),
                          onTap: () => _pickImage(ImageSource.camera),
                          color: Colors.redAccent,
                          child: Text(
                            "Camera",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: AwesomeButton(
                          height: 40,
                          blurRadius: 10.0,
                          splashColor: Color.fromRGBO(255, 255, 255, .4),
                          borderRadius: BorderRadius.circular(37.5),
                          onTap: () => print("tapped"),
                          color: Colors.redAccent,
                          child: Text(
                            "Gallery",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    child: Text('Add New Contact'),
                    color: Colors.teal,
                    textColor: Colors.white,
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
//                        if (addItem(Item( _name, , _unit, _price, _cost, _unitAvailable))) {
//                          Navigator.pop(context, 1);
//                        } else {
//                          showOneButtonDialog(context, 'Name repeated!',
//                              'There is already a Item with this name');
//                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  DropdownButton<String> androidDropdown() {
    Hive.openBox<Category>('categories');
    final categoriesBox = Hive.box<Category>('categories');
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (var i = 0; i < categoriesBox.length; i++) {
      print('1 objetillo');
      var newItem = DropdownMenuItem(
        child: Text(categoriesBox.getAt(i).getName()),
        value: categoriesBox.getAt(i).getID().toString(),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          _category = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    final categoriesBox = Hive.box<Category>('categories');
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<Text> pickerItems = [];
    for (var i = 0; i < categoriesBox.length; i++) {
      pickerItems.add(Text(categoriesBox.getAt(i).getName()));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          _category = categoriesBox.getAt(selectedIndex).getID().toString();
        });
      },
      children: pickerItems,
    );
  }
}
