import 'package:flutter/material.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:hive/hive.dart';

class FormCategoryPage extends StatefulWidget {
  @override
  _FormCategoryPageState createState() => _FormCategoryPageState();
}

class _FormCategoryPageState extends State<FormCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'A', 'April 18'));
    sampleData.add(new RadioModel(false, 'B', 'April 17'));
    sampleData.add(new RadioModel(false, 'C', 'April 16'));
    sampleData.add(new RadioModel(false, 'D', 'April 15'));
  }

  String _name;

  Color _color;

  String _selectedValue;

  void addCategory(Category cat) {
    Hive.box('categories').add(cat);
  }

  void getColor(String value) {
    _selectedValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PERFORMANCE'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
//                  hintText: 'Enter your email',
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      child: InkWell(),
                    ),
                    Container(
                      height: 400,
                      width: 100,
                      child: ListView.builder(
                        itemCount: sampleData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            highlightColor: Colors.red,
                            splashColor: Colors.blueAccent,
                            onTap: () {
                              setState(() {
                                sampleData.forEach(
                                    (element) => element.isSelected = false);
                                sampleData[index].isSelected = true;
                              });
                            },
                            child: RadioItem(sampleData[0]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('Add New Contact'),
                  onPressed: () {
                    _formKey.currentState.save();
//                  final newContact = Contact(_name, int.parse(_age));
//                  addContact(newContact);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 30.0,
            width: 30.0,
            child: Center(
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}
