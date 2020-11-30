import 'package:flutter/material.dart';
import 'newsClass.dart';

void main() {
  runApp(MaterialApp(
    title: 'PAIP',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(68, 39, 122, .38),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home'),
          backgroundColor: Color.fromRGBO(40, 23, 71, 1),
        ),
        body: Stack(
          children: [
            GridView.count(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              mainAxisSpacing: 5,
              crossAxisSpacing: 3,
              crossAxisCount: 2,
              children: [
                newsWidgetCard(
                    'Bitcoin',
                    'https://news.bitcoin.com/wp-content/uploads/2020/10/report-bitcoin-set-for-its-biggest-breakout-yet.jpg',
                    'http://newsapi.org/v2/everything?q=bitcoin&from=2020-10-29&sortBy=publishedAt&apiKey=c753ec1c6ec24a5fa0ad05032b773ef2',
                    19,
                    context),
                newsWidgetCard(
                    'Business',
                    'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fblogs-images.forbes.com%2Falejandrocremades%2Ffiles%2F2018%2F12%2Fbusiness-3605367_1920-1200x741.jpg',
                    'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c753ec1c6ec24a5fa0ad05032b773ef2',
                    19,
                    context),
                newsWidgetCard(
                    'Apple',
                    'https://media.wired.com/photos/5d5af2b0cdb91100085b250e/125:94/w_2394,h_1800,c_limit/security_apple_1138155587.jpg',
                    'http://newsapi.org/v2/everything?q=apple&from=2020-11-28&to=2020-11-28&sortBy=popularity&apiKey=c753ec1c6ec24a5fa0ad05032b773ef2',
                    19,
                    context),
                newsWidgetCard(
                    'TechCrunch',
                    'https://i.pinimg.com/736x/0b/fb/7a/0bfb7a0186b1e2c89dd7bbd4d016a9ce.jpg',
                    'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c753ec1c6ec24a5fa0ad05032b773ef2',
                    19,
                    context),
                newsWidgetCard(
                    'Wall Street Journal',
                    'https://images.dowjones.com/wp-content/uploads/sites/43/2019/08/30175942/wsj-logo.png',
                    'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=c753ec1c6ec24a5fa0ad05032b773ef2',
                    17,
                    context),
              ],
            ),
          ],
        ));
  }
}

Widget newsWidgetCard(String title, String urlImage, String urlId, double size,
    BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsWidget(
              title: title,
              url: urlId,
            ))),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Color.fromRGBO(40, 23, 71, .7),
      child: Stack(
        children: [
          Image.network(
            urlImage,
            fit: BoxFit.cover,
            height: 135,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : Center(child: CircularProgressIndicator()),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
