import 'package:flutter/material.dart';
import 'package:flutter_movie_app/pages/auth.dart';

import 'package:url_launcher/url_launcher.dart';
import '../controllers/_dbHelper.dart';
import '../models/movie.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CrudApp extends StatefulWidget {
  @override
  CrudAppState createState() => CrudAppState();
}

class CrudAppState extends State<CrudApp> {
  int? selectedId;

  get prefixIcon => null;

  void _pushAddForm() {
    String? _name;
    String? _director;
    String? _poster;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Widget _form() {
      return Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              child: Material(
                elevation: 8,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // added line
                      mainAxisSize: MainAxisSize.min, // added line
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.movie),
                          onPressed: _launchURLApp,
                        ),
                      ],
                    ),
                    labelText: 'Movie name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black, width: 3)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Movie name missing, tap on icon for suggestions';
                    }
                  },
                  onSaved: (String? value) {
                    _name = value;
                  },
                ),
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Padding(
                child: Material(
                  elevation: 8,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // added line
                          mainAxisSize: MainAxisSize.min, // added line
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.movie),
                              onPressed: _launchURLApp,
                            ),
                          ],
                        ),
                        labelText: 'Director name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 3)),
                        focusColor: Colors.amber[400]),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Director name missing,tap on icon for \nsuggestions\n';
                      }
                    },
                    onSaved: (String? value) {
                      _director = value;
                    },
                  ),
                ),
                padding: EdgeInsets.all(10.0)),
            Padding(
              child: Material(
                elevation: 8,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // added line
                      mainAxisSize: MainAxisSize.min, // added line
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.movie),
                          onPressed: _launchURLApp,
                        ),
                      ],
                    ),
                    labelText: 'Movie poster URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'URL missing,tap on icon for suggestions';
                    }
                  },
                  onSaved: (String? value) {
                    _poster = value;
                  },
                ),
              ),
              padding: EdgeInsets.all(10.0),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (selectedId != null) {
                      await DatabaseHelper.instance
                          .update(Movie(selectedId, _name, _director, _poster));
                    } else {
                      int currentID = UniqueKey().hashCode;
                      await DatabaseHelper.instance
                          .add(Movie(currentID, _name, _director, _poster));
                    }

                    Fluttertoast.showToast(
                      msg: selectedId != null
                          ? "Movie Updated"
                          : "Movie Added Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      textColor: Colors.black,
                      fontSize: 16,
                      backgroundColor: Colors.grey[200],
                    );

                    _formKey.currentState!.reset();
                  }
                },
                child: Text(selectedId != null ? 'Update movie' : 'Add movie'))
          ]));
    }

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white54,
            title: Text(
                selectedId != null ? 'Edit Existing Movie' : 'Add New Movie'),
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) => IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => CrudApp()));
                  }),
            ),
          ),
          body: _form());
    }));
  }

  Widget _buildListView() {
    return FutureBuilder<List<Movie>>(
      future: DatabaseHelper.instance.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Loading...'),
          );
        }
        return snapshot.data!.isEmpty
            ? Center(
                child: Text('Your movie list is empty'),
              )
            : ListView(
                children: snapshot.data!.map((movie) {
                  return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image(
                              image: NetworkImage(movie.poster.toString()),
                              width: 100,
                              height: 180,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(movie.name.toString(),
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(14),
                                child: Text(movie.director.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete_rounded,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            DatabaseHelper.instance
                                                .remove(movie.id);
                                          });
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            selectedId = movie.id;
                                          });
                                          _pushAddForm();
                                        })
                                  ])
                            ],
                          )
                        ],
                      ));
                }).toList(),
              );
      },
    );
  }

  _launchURLApp() async {
    const url = 'https://www.imdb.com/';

    await launch(url);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _buildListView()),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _pushAddForm,
        ));
  }
}
