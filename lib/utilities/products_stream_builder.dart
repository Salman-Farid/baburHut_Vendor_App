import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_shop/views/main/product/details.dart';
import 'package:provider/provider.dart';
import '../components/loading.dart';
import '../constants/colors.dart';
import 'package:badges/badges.dart' as badges;
import '../models/cart.dart';
import '../providers/cart.dart';

class ProductStreamBuilder extends StatelessWidget {
  const ProductStreamBuilder({
    super.key,
    required this.productStream,
  });

  final Stream<QuerySnapshot<Object?>> productStream;

  // toggle isFav
  void toggleIsFav(bool status, var id) {
    final db = FirebaseFirestore.instance.collection('products').doc(id);
    db.update({'isFav': !status});
  }

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartData>(context, listen: false);
    var userId = FirebaseAuth.instance.currentUser!.uid;

    // add to cart
    void addToCart(
      var docId,
      var prodId,
      var sellerId,
      var prodName,
      var prodPrice,
      var prodImgUrl,
    ) {
      cartData.addToCart(
        CartItem(
          id: '',
          docId: docId,
          prodId: prodId,
          sellerId: sellerId,
          userId: userId,
          prodName: prodName,
          prodPrice: double.parse(prodPrice),
          prodImgUrl: prodImgUrl,
          totalPrice: double.parse(prodPrice),
        ),
      );
    }

    // remove from cart
    void removeFromCart(var prodId) {
      cartData.removeFromCart(prodId);
    }

    return Consumer<CartData>(
      builder: (context, data, child) => StreamBuilder<QuerySnapshot>(
        stream: productStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred ): '),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Loading(
                color: primaryColor,
                kSize: 30,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/sad.png',
                    width: 150,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'No data available!',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: data,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(data['images'][0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 5,
                          child: Text(
                            data['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 5,
                          child: Text(
                            '\$${data['price']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () => toggleIsFav(data['isFav'], data.id),
                            child: CircleAvatar(
                              backgroundColor: litePrimary,
                              child: Icon(
                                data['isFav']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              if (cartData.isItemOnCart(data['prod_id'])) {
                                removeFromCart(data['prod_id']);
                              } else {
                                addToCart(
                                  data.id,
                                  data['prod_id'],
                                  data['seller_id'],
                                  data['title'],
                                  data['price'],
                                  data['images'][0],
                                );
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: litePrimary,
                              child: Icon(
                                cartData.isItemOnCart(data['prod_id'])
                                    ? Icons.shopping_cart
                                    : Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
