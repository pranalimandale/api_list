import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItemIndex =0;
  Future<List<User>> _getUser()async{
    var data = await http.get("https://jsonplaceholder.typicode.com/users");
    var jsonData = json.decode(data.body);

    List<User> users = [];
    for(var u in jsonData){
      User user = User(u["id"],u["name"],u["username"],u["email"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: Row(
        children:<Widget> [
          buildNavBarItem(Icons.home,0),
          buildNavBarItem(Icons.search,1),
          buildNavBarItem(Icons.verified_user,2),
          buildNavBarItem(Icons.person,3),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Explore our Delicious offers flat 25%',style: TextStyle(color:Colors.black,),
        ),
      ),

      body: Container(
        child: FutureBuilder(
          future: _getUser(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data==null){
              return Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            }
            else{
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.network("https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
                                width: 300, height: 200, fit: BoxFit.contain),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNbG0DNfCqEl0RwzNQb11QUG4Edsna7ESCsg&usqp=CAU",
                                width: 300, height: 200, fit: BoxFit.contain),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFu7Yg50Dy05xGJxrgS6_0vGumwHw_tgaB7A&usqp=CAU",
                                width: 300, height: 200, fit: BoxFit.contain),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context,int index){
                          return Card(
                              elevation: 2,
                              color: Colors.white,
                              child:ListTile(
                                leading: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSX_z2rWfGh9Ue5JrtfTlGaW7aReLDw5rH3gA&usqp=CAU"),
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].username),
                              )
                          );
                        }
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
  Widget buildNavBarItem(IconData icon,int index){
    return GestureDetector(
        onTap: () {
          },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width/4,
          decoration: index == _selectedItemIndex
              ? BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4,color: Colors.red),
            ),
            gradient: LinearGradient(colors: [
              Colors.red.withOpacity(0.3),
              Colors.red.withOpacity(0.015),
            ],
                begin: Alignment.bottomCenter,end: Alignment.topCenter
            ),
            // color: index == _selectedItemIndex ? Colors.green : Colors.white,
          )
              : BoxDecoration(),
          child: Icon(
            icon,
            color: index == _selectedItemIndex ? Colors.black : Colors.grey,
          ),
        )
    );
  }
}


class User {
  final int id;
  final String name;
  final String username;
  final String email;
  User(this.id,this.name,this.username,this.email);
}