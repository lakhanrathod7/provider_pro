import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Provider.of<ProductProvider>(context, listen: false).fetchProducts();
        WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.deepPurple,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.deepPurpleAccent, Colors.deepPurple],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: ClipOval(
                                  child: Image.asset("assets/images/user.png"
                                    ,
                                    fit: BoxFit
                                        .cover, // Ensures the image fits properly
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.notifications_outlined,
                                            color: Colors.white),
                                        onPressed: () {
                                          // Notification button action
                                        },
                                      ),
                                      Positioned(
                                        right: 12,
                                        top: 12,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 8,
                                            minHeight: 8,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.shopping_bag_outlined,
                                      color: Colors.white),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              Text(
                                "Hi, Lakhan",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Welcome to The Online Store",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -25,
                    left: 20,
                    right: 20,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.purple, width: 2),
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
                  )
                ],
              ),
              SizedBox(
                height: 35,
              ),
              // Product List
      
              Expanded(
                child: productProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
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
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
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
                    : RefreshIndicator(
                  onRefresh: productProvider.fetchProducts,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    switchInCurve: Curves.easeInOut,
                    child: GridView.builder(
                      key: ValueKey(productProvider.products.length),
                      padding: const EdgeInsets.all(8),
                      itemCount: productProvider.products.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return GestureDetector(
                          onTap: () {
                            if (product.id != null) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                  const Duration(milliseconds: 600),
                                  pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                      ProductDetailScreen(
                                          productId: product.id!),
                                  transitionsBuilder: (context,
                                      animation,
                                      secondaryAnimation,
                                      child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOut,
                                      )),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content:
                                  Text('Product ID is missing!'),
                                ),
                              );
                            }
                          },
                          child: ProductCard(
                            product: product,
                            heroTag: product.id != null
                                ? 'product_image_${product.id}'
                                : 'product_image_placeholder',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}