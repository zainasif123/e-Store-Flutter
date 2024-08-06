import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store1/pages/category_product.dart';
import 'package:e_store1/pages/product_detail.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List catergories = [
    "images/watch.png",
    "images/laptop.png",
    "images/TV.png",
    "images/headphone.PNG",
  ];
  List catergoyname = ["Watch", "Laptop", "TV", "Headphone"];
  String? name, image;
  List<DocumentSnapshot> allProducts = [];
  List<DocumentSnapshot> searchResults = [];
  TextEditingController searchController = TextEditingController();

  fetchShraredPreferanceuser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc['Name'];
          image = userDoc['Image'];
        });
      } else {
        print('User document does not exist');
        // Handle the case where the user document does not exist
      }
    }
  }

  fetchAllProducts() async {
    List<String> collections = ["Headphone", "TV", "Watch", "Laptop"];
    List<DocumentSnapshot> tempProducts = [];

    for (String collection in collections) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collection).get();
      tempProducts.addAll(querySnapshot.docs);
    }

    setState(() {
      allProducts = tempProducts;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchShraredPreferanceuser();
    fetchAllProducts();
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    List<DocumentSnapshot> tempList = [];
    for (DocumentSnapshot product in allProducts) {
      if (product['Name'].toLowerCase().contains(query.toLowerCase())) {
        tempList.add(product);
      }
    }

    setState(() {
      searchResults = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecefe8),
      body: name == null && image == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Hi " + name!,
                              style: AppWidget.boldTextFieldStyle(),
                            ),
                            Text(
                              "welcome To e-sTORE",
                              style: AppWidget.lightTextFieldStyle(),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image!,
                            height: 60,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Product",
                            hintStyle: AppWidget.lightTextFieldStyle(),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    searchResults.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                var product = searchResults[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image.network(
                                        product['Image'],
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(product['Name']),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                              name: product['Name'],
                                              price:
                                                  product['Price'].toString(),
                                              description:
                                                  product['Desciption'],
                                              image: product['Image'],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            ),
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Categories",
                            style: AppWidget.semiboldTextStyle()),
                        Text(
                          "See all",
                          style: TextStyle(
                              color: Color(0xFFfd6f3e),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Color(0xFFfd6f3e),
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * .148,
                          child: Center(
                            child: Text(
                              "All",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .148,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: catergories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return CategoryTile(
                                  image: catergories[index],
                                  name: catergoyname[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("All Products", style: AppWidget.semiboldTextStyle()),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: allProducts.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var product = allProducts[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.network(
                                product['Image'],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                product['Name'],
                                style: AppWidget.semiboldTextStyle(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${product['Price']}",
                                    style: TextStyle(
                                      color: Color(0xFFfd6f3e),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                            name: product['Name'],
                                            price: product['Price'].toString(),
                                            description: product['Desciption'],
                                            image: product['Image'],
                                          ),
                                        ),
                                      );
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CategoryProduct(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 90,
        width: 90,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              Icon(Icons.arrow_forward)
            ]),
      ),
    );
  }
}
