import 'package:flutter/material.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/bloc/Category/category_bloc.dart';
import 'package:com.talel.boycott/Features/Categorie/Presentation/pages/Category_pages.dart';
import 'package:com.talel.boycott/Features/Categorie/domain/entities/category.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Statistique extends StatefulWidget {
  
  const Statistique({Key? key}) : super(key: key);

  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  late Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
  }

  Map<String, double> _generateDataMap(List<Category> categories) {
  Map<String, double> map = {};

    for (var category in categories) {
      map[category.name] = double.parse(category.products_count.toString());
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriePages()));
        },
        child: Icon(Icons.arrow_circle_left_sharp, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
       if (state is LoadedCategory) {
         dataMap = _generateDataMap(state.categorys);
        return Container(
        child: Center(
          child: PieChart(
            dataMap: dataMap,
            chartRadius: MediaQuery.of(context).size.width / 1.7,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.bottom,
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            colorList: _generateColorList(dataMap.length),
          ),
        ),
       );
       }
       return Container();
      } 
    ));
  }

  List<Color> _generateColorList(int length) {
    List<Color> colorList = List.generate(length, (index) {
      return index % 2 == 0 ? Colors.red : Colors.yellow;
    });
    return colorList;
  }
}
