import 'package:flutter/material.dart';
import 'package:full_proj_pks/components/product_item.dart';
import 'package:full_proj_pks/pages/add_product_page.dart';
import 'package:full_proj_pks/models/product_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _sortBy = "price"; // Устанавливаем начальное значение для сортировки
  String _sortOrder = "asc"; // Устанавливаем начальное значение для порядка сортировки
  RangeValues _priceRange = RangeValues(0, 10000); // Диапазон цены по умолчанию

  @override
  void initState() {
    super.initState();
    // Загружаем продукты при инициализации страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductManager>(context, listen: false).fetchProducts(
        searchQuery: _searchQuery,
        minPrice: _priceRange.start, // Используем начальное значение диапазона
        maxPrice: _priceRange.end, // Используем конечное значение диапазона
        sortBy: _sortBy,
        sortOrder: _sortOrder,
      );
    });
  }

  void navigateToAddProductPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductPage()),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
    Provider.of<ProductManager>(context, listen: false).fetchProducts(
      searchQuery: _searchQuery,
      minPrice: _priceRange.start, // Используем текущий диапазон цены
      maxPrice: _priceRange.end,
      sortBy: _sortBy,
      sortOrder: _sortOrder,
    );
  }

  void _onSortChanged(String sortBy, String sortOrder) {
    setState(() {
      _sortBy = sortBy;
      _sortOrder = sortOrder;
    });
    Provider.of<ProductManager>(context, listen: false).fetchProducts(
      searchQuery: _searchQuery,
      minPrice: _priceRange.start, // Используем текущий диапазон цены
      maxPrice: _priceRange.end,
      sortBy: _sortBy,
      sortOrder: _sortOrder,
    );
  }

  void _onPriceRangeChanged(RangeValues values) {
    setState(() {
      _priceRange = values;
    });
    Provider.of<ProductManager>(context, listen: false).fetchProducts(
      searchQuery: _searchQuery,
      minPrice: _priceRange.start, // Используем текущий диапазон цены
      maxPrice: _priceRange.end,
      sortBy: _sortBy,
      sortOrder: _sortOrder,
    );
  }


  @override
  Widget build(BuildContext context) {
    final productManager = Provider.of<ProductManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "VINYL STORE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 40,
              color: Color.fromRGBO(102, 155, 188, 1),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Поиск...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: _sortBy, // Устанавливаем значение для сортировки
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _onSortChanged(newValue, _sortOrder);
                  }
                },
                dropdownColor: const Color.fromRGBO(57, 62, 65, 1), // Цвет фона выпадающего списка
                style: const TextStyle(color: Colors.white), // Цвет текста выбранного значения
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white54, // Цвет иконки стрелки
                ),
                items: <String>['price', 'name']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == 'price' ? 'Цена' : 'Название',
                      style: const TextStyle(color: Colors.white54), // Светлый цвет текста
                    ),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: _sortOrder, // Устанавливаем значение для порядка сортировки
                dropdownColor: const Color.fromRGBO(57, 62, 65, 1),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _onSortChanged(_sortBy, newValue);
                  }
                },
                items: <String>['asc', 'desc']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'asc' ? 'По возрастанию' : 'По убыванию',
                      style: const TextStyle(color: Colors.white54),
                    ),

                  );
                }).toList(),
              ),
            ],
          ),
          // Добавляем RangeSlider для выбора диапазона цены
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Диапазон цены:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 10000,
                  divisions: 100, // Количество делений
                  labels: RangeLabels(
                    _priceRange.start.round().toString(),
                    _priceRange.end.round().toString(),
                  ),
                  onChanged: _onPriceRangeChanged,
                ),
              ],
            ),
          ),
          Expanded(
            child: productManager.products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 0.76,
              ),
              itemCount: productManager.products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductItem(
                  product: productManager.products[index],
                  index: index,);
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(102, 155, 188, 1),
        onPressed: () => navigateToAddProductPage(context),
        child: const Icon(Icons.add_box_rounded),
        tooltip: "Добавить товар",
      ),
    );
  }
}