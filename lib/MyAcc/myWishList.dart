import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class myWishList extends StatefulWidget {
  const myWishList({super.key});

  @override
  State<myWishList> createState() => _myWishListState();
}

class _myWishListState extends State<myWishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wish List'),
        backgroundColor: Colors.purple,
      ),
      body: FavoriteProductsList(),
    );
  }
}

class FavoriteProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final favoriteProducts = snapshot.data?.docs ?? [];

        if (favoriteProducts.isEmpty) {
          return Center(
            child: Text('No favorite products yet.'),
          );
        }
        return ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteProducts[index].data() as Map<dynamic, dynamic>?;

            if (product == null) {
              return ListTile(
                title: Text('Product is null'),
                subtitle: Text('Description not available'),
                trailing: Text('Price N/A'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 122,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        leading: Image.network(
                          (product['image_url'] is List && product['image_url'].isNotEmpty)
                              ? product['image_url'][0].toString()
                              : 'No Image',
                        ),
                        title: Text(product['title'] ?? 'No Title'),
                        subtitle: Text(product['description'] ?? 'No Description'),
                        trailing: Text('\$ ${product['price'] ?? 'N/A'}'),
                        onTap: () {
                          print('tile press');
                        },
                      ),
                      IconButton(onPressed: (){
                        _removeFromFavorites(favoriteProducts[index].reference);
                      }, icon: Icon(Icons.delete_outline),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
  void _removeFromFavorites(DocumentReference documentReference) {
    documentReference.delete().then((value) {
      Fluttertoast.showToast(msg: 'Product removed from favorites');
    }).catchError((error) {
      print('Failed to remove product: $error');
    });
  }
}




/*ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text('Price: ${product.price}'),
            // Add more UI components as needed
          );
        },
      ),

 */
