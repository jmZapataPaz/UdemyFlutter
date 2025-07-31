import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/ClientProductListItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProductListPage extends StatefulWidget {
  const ClientProductListPage({super.key});

  @override
  State<ClientProductListPage> createState() => _ClientProductListPageState();
}

class _ClientProductListPageState extends State<ClientProductListPage> {
  ClientProductListBloc? _bloc;
  Category? category;
  bool _initialized = false; 

  final List<String> priceFilters = ['Precio: Menor a mayor', 'Precio: Mayor a menor'];
  String selectedPriceFilter = 'Precio: Menor a mayor';

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)?.settings.arguments as Category;
    _bloc = BlocProvider.of<ClientProductListBloc>(context);
    if (!_initialized && category != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bloc?.add(GetProductsByCategory(id_category: category!.id!));
      });
      _initialized = true;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos - ${category?.name ?? "Categoría"}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'client/shoppingBag');
            },
            icon: Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: BlocListener<ClientProductListBloc, ClientProductListState>(
        listener: (context, state){
          final responseState = state.response;
          if(responseState is Success){
            if(responseState.data is bool && responseState.data == true){
              _bloc?.add(GetProductsByCategory(id_category: category!.id!)); 
            }
          }
        },
        child: Column(
          children: [
            BlocBuilder<ClientProductListBloc, ClientProductListState>(
              builder: (context, state) {
                final responseState = state.response;
                if (responseState is Success) {
                  List<Product> products = responseState.data as List<Product>;
                  if (products.isNotEmpty) {
                    return _buildPriceFilterChips(context);
                  }
                }
                return SizedBox.shrink(); 
              },
            ),
            Expanded(
              child: BlocBuilder<ClientProductListBloc, ClientProductListState>(
                builder: (context, state){
                  final responseState = state.response;
                  if(responseState is Loading){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  if(responseState is Success) {
                    List<Product> products = responseState.data as List<Product>;
                    final screenWidth = MediaQuery.of(context).size.width;
                    final isTablet = screenWidth > 600;
                    List<Product> filteredProducts = List<Product>.from(products);
                    if (selectedPriceFilter == 'Precio: Menor a mayor') {
                      filteredProducts.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
                    } else if (selectedPriceFilter == 'Precio: Mayor a menor') {
                      filteredProducts.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
                    }

                    if (filteredProducts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.checkroom,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No hay productos en esta categoría',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Explora otras categorías para encontrar productos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (isTablet) {
                      return GridView.builder(
                        padding: EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, 
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ClientProductListItem(_bloc, filteredProducts[index]);
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index){
                          return ClientProductListItem(_bloc, filteredProducts[index]);
                        },
                      );
                    }
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.checkroom,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No hay productos en esta categoría',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Explora otras categorías para encontrar productos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildPriceFilterChips(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Container(
      height: 56,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * (isTablet ? 0.02 : 0.03)),
        itemCount: priceFilters.length,
        itemBuilder: (context, index) {
          String filter = priceFilters[index];
          bool isSelected = selectedPriceFilter == filter;
          return Container(
            margin: EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedPriceFilter = filter;
                });
              },
              selectedColor: Colors.black,
              backgroundColor: Colors.grey[200],
              checkmarkColor: Colors.white,
              elevation: isSelected ? 4 : 2,
              pressElevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? Colors.black! : Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}