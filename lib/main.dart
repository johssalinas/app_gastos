import 'package:app_gastos/lineChart.dart';
import 'package:app_gastos/price_ponits.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController? _controler;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();

    _controler = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(icon),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.clockRotateLeft),
            _bottomAction(FontAwesomeIcons.chartPie),
            const SizedBox(width: 48.0),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: _body(),
    );
  }

  Widget _body() {
    Widget pageItem(String name, int position) {
      Alignment alignment;

      const selected = TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blueGrey);

      final unselected = TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
          color: Colors.blueGrey.withOpacity(0.4));

      if (position == currentPage) {
        alignment = Alignment.center;
      } else if (position > currentPage) {
        alignment = Alignment.centerRight;
      } else {
        alignment = Alignment.centerLeft;
      }

      return Align(
          alignment: alignment,
          child: Text(
            name,
            style: position == currentPage ? selected : unselected,
          ));
    }

    Widget selector() {
      return SizedBox.fromSize(
        size: const Size.fromHeight(70.0),
        child: PageView(
          onPageChanged: (newPage) {
            setState(() {
              currentPage = newPage;
            });
          },
          controller: _controler,
          children: <Widget>[
            pageItem("Enero", 0),
            pageItem("Febrero", 1),
            pageItem("Marzo", 2),
            pageItem("Abril", 3),
            pageItem("Mayo", 4),
            pageItem("Junio", 5),
            pageItem("Julio", 6),
            pageItem("Agosto", 7),
            pageItem("Septiembre", 8),
            pageItem("Octubre", 9),
            pageItem("Noviembre", 10),
            pageItem("Diciembre", 11)
          ],
        ),
      );
    }

    Widget expenses() {
      return Center(
          child: Column(children: const <Widget>[
        Text('\$2361,41',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            )),
        Text('Total Expenses',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            )),
      ]));
    }

    Widget graph() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: LineChartWidget(pricePoints),
      );
    }

    Widget item(IconData icon, String name, int percent, double value) {
      return ListTile(
        leading: Icon(icon),
        title: Text(name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )),
        subtitle: Text('$percent% of expenses',
            style: const TextStyle(fontSize: 16.0, color: Colors.blueGrey)),
        trailing: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\$$value",
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0)),
            )),
      );
    }

    Widget list() {
      return Expanded(
        child: ListView.separated(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) =>
                item(FontAwesomeIcons.cartShopping, "Shopping", 14, 145.12),
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.blueAccent.withOpacity(0.15),
                height: 8.0,
              );
            }),
      );
    }

    return SafeArea(
      child: Column(
        children: <Widget>[
          selector(),
          expenses(),
          graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),
          list(),
        ],
      ),
    );
  }
}
