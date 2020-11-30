import 'package:flutter/material.dart';
import 'RestApiFS.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatefulWidget {
  String url;
  String title;
  NewsWidget({this.url, this.title});

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List dataS = [];
  String url;

  // Go to the website
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      url = widget.url;
    });
    getData(url).then((value) {
      setState(() {
        dataS = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(68, 39, 122, .1),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromRGBO(40, 23, 71, 1),
      ),
      body: Center(
          child: FutureBuilder(
              future: getData(url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else if (snapshot.hasData)
                  return ListView.builder(
                    padding: EdgeInsets.all(6),
                    itemCount: dataS.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _launchURL(dataS[index]['url']);
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                elevation: 4.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color.fromRGBO(40, 23, 71, 1),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          dataS[index]['title'].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: 360,
                                        color: Colors.black54,
                                        height: 2,
                                      ),
                                      dataS[index]['urlToImage'] != null
                                          ? Image.network(
                                              dataS[index]['urlToImage'],
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: 360,
                                              loadingBuilder: (context, child,
                                                      loadingProgress) =>
                                                  loadingProgress == null
                                                      ? child
                                                      : Container(
                                                          height: 200,
                                                          width: 360,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator())),
                                            )
                                          : Container(
                                              width: 360,
                                              height: 200,
                                              child: Center(
                                                child: Text(
                                                  'Image not found',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              })),
    );
  }
}
