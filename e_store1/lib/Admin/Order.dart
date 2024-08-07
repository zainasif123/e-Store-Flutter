import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store1/widget/support_widget.dart';
import 'package:flutter/material.dart';

class OrderReceived extends StatefulWidget {
  const OrderReceived({super.key});

  @override
  State<OrderReceived> createState() => _OrderReceivedState();
}

class _OrderReceivedState extends State<OrderReceived> {
  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('Orders');

  Future<void> _updateOrderStatus(String orderId) async {
    try {
      await _ordersCollection.doc(orderId).update({'status': 'delivered'});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Order marked as delivered successfully ",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Failed to update order: $e',
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          "Add Product",
          style: AppWidget.semiboldTextStyle(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 5),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _ordersCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final orders = snapshot.data!.docs;

                  if (orders.isEmpty) {
                    return Center(child: Text('No orders found.'));
                  }

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          height: 250, // Adjust height if needed
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  order['image'],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  width: 10), // Space between image and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Name: ${order['name']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'UserID: ${order['userid']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Email: ${order['email']}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Product Name: ${order['productname']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Price: \$${order['price']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Status: ${order['status']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: order['status'] == 'delivered'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.done, color: Colors.green),
                                onPressed: () {
                                  _updateOrderStatus(order.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
