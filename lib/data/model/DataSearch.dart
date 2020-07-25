import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/data/model/country.dart';

class DataSearch extends SearchDelegate<List<String>> {
  List<String> countries = [];
  List<String> countryCode = [];
  Map<String,String> countriesCode = Map();
  Future getCountryList() async {
    final jsonString = await rootBundle.loadString('assets/country.json');
    List jsonResponse = json.decode(jsonString);
    List<Country> _country =
    jsonResponse.map((e) => Country.fromJson(e)).toList();
    for (var i = 0; i < _country.length; i++) {
      countriesCode[_country[i].enShortName] = _country[i].dialCode;
    }
    return countriesCode;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed:(){
      query = '';
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
      close(context, null);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getCountryList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          final searchCode = countriesCode.keys.where((element) => element.toLowerCase().startsWith(query.toLowerCase()));
          return ListView.builder(
              itemCount: searchCode.length,
              itemBuilder: (context,index)=>ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${searchCode.elementAt(index)}'),
                  ],) ,
                onTap: (){
                  close(context, [searchCode.elementAt(index),countriesCode[searchCode.elementAt(index)]]);
                },
              ));
        }
        else{
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: getCountryList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          final searchCode = countriesCode.keys.where((element) => element.toLowerCase().startsWith(query.toLowerCase()));
          return ListView.builder(
              itemCount: searchCode.length,
              itemBuilder: (context,index)=>ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${searchCode.elementAt(index)}'),
                    // Text('${countriesCode[searchCode.elementAt(index)]}')
                  ],) ,
                onTap: (){
//                  query = searchCode.elementAt(index).toLowerCase();
                  close(context, [searchCode.elementAt(index),countriesCode[searchCode.elementAt(index)]]);
                },
              ));
        }
        else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}