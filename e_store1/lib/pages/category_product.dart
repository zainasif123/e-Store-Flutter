import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store1/pages/product_detail.dart';
import 'package:e_store1/services/database.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  final String category;

  CategoryProduct({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  Stream<QuerySnapshot>? CategoryStream;

  getonLoad() async {
    CategoryStream = DatabaseMethod().getProduct(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getonLoad();
  }

  Widget allproduct() {
    return StreamBuilder(
      stream: CategoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          padding: EdgeInsets.all(0), // Adjust padding if needed
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 0), // Add padding to avoid edge collision
              child: Card(
                elevation: 4, // Add shadow effect if needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        ds['Image'],
                        height: MediaQuery.of(context).size.height * .2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ds['Name'],
                              style: AppWidget.semiboldTextStyle()),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${ds['Price'].toString()}",
                                  style: TextStyle(
                                      color: Color(0xFFfd6f3e),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProductDetail(
                                                  name: ds['Name'],
                                                  price: ds['Price'],
                                                  description: ds["Desciption"],
                                                  image: ds['Image'])));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFfd6f3e),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: allproduct(),
      ),
    );
  }
}
