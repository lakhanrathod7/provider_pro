import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/screens/prodect_search_sceen.dart';

import '../provider/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen initializes
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
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
                  child: GridView.builder(

                    padding: const EdgeInsets.all(8),
                    itemCount: productProvider.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                          mainAxisExtent: 250,
                          //childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = productProvider.products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: product.id,
                          );
                        },
                        child: ProductCard(
                          product: product,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
