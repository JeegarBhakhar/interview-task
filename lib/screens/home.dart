import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interview/data/user.dart';
import 'package:interview/data/mock_data.dart';
import 'package:interview/widgets/avatar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  List<User> searchResult =[];
  List<User> users =[];
  @override
  void initState() {
    super.initState();
    users = User.fromJsonToList(allData());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _filterList(String query) {
    searchResult.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }

    users.forEach((userDetail) {
      setState(() {
        if (userDetail.firstName.toLowerCase().contains(query.toLowerCase())||userDetail.lastName.toLowerCase().contains(query.toLowerCase())||userDetail.role.toLowerCase().contains(query.toLowerCase())||userDetail.email.toLowerCase().contains(query.toLowerCase())) searchResult.add(userDetail);

      });

    });

  }

  @override
  Widget build(BuildContext context) {


    _getUserAvatar(url) {
      return url == '' ? Avatar().avatarIconWidget(Icon(FontAwesomeIcons.image)):
       Avatar().avatarWidget(url);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                onChanged: (value) {
                  _filterList(value);
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child:searchController.text.isEmpty? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final item = users[index];
                return ListTile(
                  title: Text(users[index].firstName+' '+users[index].lastName),
                  subtitle: Text(users[index].role),
                  leading: _getUserAvatar(users[index].avatar),

                  //leading: _getUserAvatar(users[index].avatar),
                );
              },
            ):ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final item = users[index];
                return ListTile(
                  title: Text(searchResult[index].firstName),
                  subtitle: Text(searchResult[index].role),
                  leading: _getUserAvatar(searchResult[index].avatar),

                  //leading: _getUserAvatar(users[index].avatar),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            users.add(User(id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d", avatar: '', firstName: "James", lastName: "May", email: "ssaull1c@tripod.com", role: "Developer"));
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}
