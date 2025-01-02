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
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });

  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productProvider.errorMessage.isNotEmpty
          ? Center(child: Text(productProvider.errorMessage))
          : RefreshIndicator(
        onRefresh: productProvider.fetchProducts,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeInOut,
          child: GridView.builder(
            key: ValueKey(productProvider
                .products.length), // Trigger animation on refresh
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
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: GestureDetector(
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
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product ID is missing!'),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
