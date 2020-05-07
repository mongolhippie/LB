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
import 'package:enum_to_string/enum_to_string.dart';
import 'package:awesome_button/awesome_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:littlebusiness/logic/Item.dart';
import '../elements/ext.dart';

class FormItemPage extends StatefulWidget {
  @override
  _FormItemPageState createState() => _FormItemPageState();
}

class _FormItemPageState extends State<FormItemPage> {
  final _formKey = GlobalKey<FormState>();
  // Active image file
  File _imageFile;
  String _name;
  units _unit;
  double _price;
  double _cost;
  double _unitAvailable;
  String _category;

  List<Category> categories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getListCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (categories.length == 0) {
      return AlertDialog(
        title: Text("No Categories"),
        content: Text("Before you add an item, you must create a Category"),
        actions: [
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Create Category"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/categoryform');
            },
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Item',
            style: TextStyle(fontFamily: 'Comfortaa'),
          ),
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
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontFamily: 'Comfortaa'),
                              labelText: 'Name',
                            ),
                            onSaved: (value) => _name = value.capitalize(),
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
                      child: DefaultTextStyle(
                        style: TextStyle(fontFamily: 'Comfortaa'),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomRadioButton(
                                buttonColor: Colors.white,
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
                                radioButtonValue: (value) => _unit =
                                    EnumToString.fromString(
                                        units.values, value),
                                horizontal: false,
                                selectedColor: kSelectedGreen,
                                enableShape: true,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
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
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
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
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
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
                                  Expanded(
                                    child: Platform.isIOS
                                        ? iOSPicker()
                                        : androidDropdown(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: _imageFile == null ? true : false,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: AwesomeButton(
                              height: 40,
                              blurRadius: 10.0,
                              splashColor: Color.fromRGBO(255, 255, 255, .4),
                              borderRadius: BorderRadius.circular(37.5),
                              onTap: () => _pickImage(ImageSource.camera),
                              color: Colors.white,
                              child: Text(
                                "Camera",
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  color: kBorderGreen,
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
                              onTap: () => _pickImage(ImageSource.gallery),
                              color: Colors.white,
                              child: Text(
                                "Gallery",
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  color: kBorderGreen,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: kBorderGreen, width: 2)),
                      child: Text(
                        'Add New Item',
                        style: TextStyle(fontFamily: 'Comfortaa'),
                      ),
                      color: Colors.white,
                      textColor: kBorderGreen,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (_imageFile == null) {
                            return showOneButtonDialog(context, "No photo",
                                "You should select or take a photo for the Item");
                          } else if (_category == null) {
                            return showOneButtonDialog(context, "No category",
                                "You should select a Category for the Item");
                          }
                          // copy the file to a new path
                          if (addItem(Item(_name, _category, _unit.toString(),
                              _price, _cost, _unitAvailable))) {
                            var nameTrim = _name.trim().replaceAll(' ', '');
                            AppUtil.createFolderInAppDir('items');
                            _imageFile.copy('$pathAPP/items/$nameTrim.jpg');
                            Navigator.pop(context, 1);
                          } else {
                            showOneButtonDialog(context, 'Name repeated!',
                                'There is already a Item with this name');
                          }
                        } else {
                          print("no verificado");
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
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (var i = 0; i < categories.length; i++) {
      var newItem = DropdownMenuItem(
        child: Text(categories[i].getName()),
        value: categories[i].getID().toString(),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      hint: Text("Category"),
      value: _category,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          _category = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<Text> pickerItems = [];
    for (var i = 0; i < categories.length; i++) {
      pickerItems.add(Text(categories[i].getName()));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          _category = categories[selectedIndex].getID().toString();
        });
      },
      children: pickerItems,
    );
  }
}
