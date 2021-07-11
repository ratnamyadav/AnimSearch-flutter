import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:anim_search/providers/data_provider.dart';
import 'package:anim_search/widgets/home_card.dart';
import 'error_screen.dart';

class AnimeGridPage extends StatefulWidget {
  @override
  _AnimeGridPageState createState() => _AnimeGridPageState();
}

class _AnimeGridPageState extends State<AnimeGridPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Provider.of<DataProvider>(context, listen: false).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final screenHeight = device.size.height;
    final screenWidth = device.size.width;

    final homeData = Provider.of<DataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: homeData.isError
            ? ErrorScreen()
            : homeData.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                      strokeWidth: 5,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: getData,
                    color: Colors.orange,
                    strokeWidth: 2.5,
                    child: GridView.builder(
                      padding: EdgeInsets.all(15).copyWith(
                        left: 20,
                        right: 20,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5 / 2.5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: homeData.searchList.length,
                      itemBuilder: (context, index) => HomeCard(
                        homeData: homeData.searchList[index],
                        cardIndex: index,
                      ),
                    ),
                  ),
      ),
    );
  }
}
