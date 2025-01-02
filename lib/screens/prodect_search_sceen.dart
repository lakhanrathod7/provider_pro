import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .searchProducts(query);
    } else {
      setState(() {
        _isSearching = false;
      });
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    }
  }

  Future<bool> _onWillPop() async {
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    return true; // Allows the screen to pop
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _performSearch('');
                },
              ),
            ),
            onChanged: _performSearch,
            onSubmitted: _performSearch,
          ),
        ),
        body: productProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : productProvider.errorMessage.isNotEmpty
            ? Center(child: Text(productProvider.errorMessage))
            : _isSearching
            ? ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            final product = productProvider.products[index];
            return ListTile(
              leading: Hero(
                tag: product.id != null
                    ? 'product_image_${product.id}'
                    : 'product_image_placeholder',
                child: product.images.isNotEmpty
                    ? Image.network(
                  product.images[0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.image),
              ),

              title: Text(product.title),
              subtitle: Text('\$${product.price}'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ProductDetailScreen(
              //         productId: product.id,
              //       ),
              //     ),
              //   );
              // },
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration:
                    const Duration(milliseconds: 600),
                    pageBuilder: (context, animation,
                        secondaryAnimation) =>
                        ProductDetailScreen(
                            productId: product.id),
                    transitionsBuilder: (context, animation,
                        secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(
                              1.0, 0.0), // Start from right
                          end: Offset.zero, // End at center
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        )),
                        child: child,
                      );
                    },
                  ),
                );
              },
            );
          },
        )
            : GridView.builder(
          padding: EdgeInsets.all(8),
          itemCount: productProvider.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 250,
          ),
          itemBuilder: (context, index) {
            final product = productProvider.products[index];
            return ProductCard(
              product: product,
              heroTag: product.id != null
                  ? 'product_image_${product.id}'
                  : 'product_image_placeholder',
            );
          },
        ),
      ),
    );
  }
}
