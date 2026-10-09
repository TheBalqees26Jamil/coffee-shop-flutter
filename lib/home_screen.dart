import 'package:flutter/material.dart';
import 'app_common.dart';

// ─────────────────────────────────────────────
class Coffee {
  final String name;
  final String subtitle;
  final String category;
  final String image;
  final double price;
  final double rating;

  const Coffee({
    required this.name,
    required this.subtitle,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
  });
}

const String _u = 'https://images.unsplash.com/photo-';

const List<Coffee> coffees = [
  Coffee(
    name: 'Cappuccino',
    subtitle: 'with Chocolate',
    category: 'Cappuccino',
    image: '${_u}1509042239860-f550ce710b93?w=500&q=80',
    price: 4.53,
    rating: 4.8,
  ),
  Coffee(
    name: 'Cappuccino',
    subtitle: 'with Oat Milk',
    category: 'Cappuccino',
    image: '${_u}1514432324607-a09d9b4aefdd?w=500&q=80',
    price: 3.90,
    rating: 4.9,
  ),
  Coffee(
    name: 'Cappuccino',
    subtitle: 'with Cinnamon',
    category: 'Cappuccino',
    image: '${_u}1541167760496-1628856ab772?w=500&q=80',
    price: 4.20,
    rating: 4.7,
  ),
  Coffee(
    name: 'Cappuccino',
    subtitle: 'Classic',
    category: 'Cappuccino',
    image: '${_u}1495474472287-4d71bcdd2085?w=500&q=80',
    price: 3.60,
    rating: 4.6,
  ),
  Coffee(
    name: 'Machiato',
    subtitle: 'with Caramel',
    category: 'Machiato',
    image: '${_u}1461023058943-07fcbe16d735?w=500&q=80',
    price: 4.80,
    rating: 4.5,
  ),
  Coffee(
    name: 'Machiato',
    subtitle: 'Double Shot',
    category: 'Machiato',
    image: '${_u}1447933601403-0c6688de566e?w=500&q=80',
    price: 5.10,
    rating: 4.4,
  ),
  Coffee(
    name: 'Latte',
    subtitle: 'with Vanilla',
    category: 'Latte',
    image: '${_u}1541167760496-1628856ab772?w=500&q=80',
    price: 4.10,
    rating: 4.7,
  ),
  Coffee(
    name: 'Americano',
    subtitle: 'Black & Strong',
    category: 'Americano',
    image: '${_u}1447933601403-0c6688de566e?w=500&q=80',
    price: 2.90,
    rating: 4.3,
  ),
];

const List<String> categories = ['Cappuccino', 'Machiato', 'Latte', 'Americano'];

const String avatarUrl = '${_u}1507003211169-0a1dd7228f2d?w=200&q=80';

// ──────────────────────────────────────────────
class CoffeeHomeScreen extends StatefulWidget {
  const CoffeeHomeScreen({super.key});

  @override
  State<CoffeeHomeScreen> createState() => _CoffeeHomeScreenState();
}

class _CoffeeHomeScreenState extends State<CoffeeHomeScreen> {
  String _selectedCategory = 'Cappuccino';
  String _query = '';
  int _navIndex = 0;

  List<Coffee> get _filtered {
    return coffees.where((c) {
      final matchCategory = c.category == _selectedCategory;
      final matchQuery =
          c.name.toLowerCase().contains(_query.toLowerCase()) ||
          c.subtitle.toLowerCase().contains(_query.toLowerCase());
      return _query.isEmpty ? matchCategory : matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildCategories(),
                Expanded(child: _buildGrid()),
                _buildBottomNav(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Location',
                  style: TextStyle(color: AppColors.muted, fontSize: 12)),
              SizedBox(height: 2),
              Row(
                children: [
                  Text('Bilzen, Tanjungbalai',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  Icon(Icons.keyboard_arrow_down,
                      size: 18, color: AppColors.muted),
                ],
              ),
            ],
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const SizedBox(
              width: 44,
              height: 44,
              child: NetImage(avatarUrl),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          onChanged: (v) => setState(() => _query = v),
          decoration: const InputDecoration(
            hintText: 'Search coffee',
            hintStyle: TextStyle(color: Color(0xFFE6D3C4)),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            suffixIcon: Icon(Icons.tune, color: Colors.white),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 38,
      margin: const EdgeInsets.only(top: 20, bottom: 16),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final selected = cat == _selectedCategory && _query.isEmpty;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedCategory = cat;
              _query = '';
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: selected ? AppColors.accent : AppColors.muted,
                  width: 1,
                ),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : AppColors.muted,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid() {
    final items = _filtered;
    if (items.isEmpty) {
      return const Center(
        child: Text('No coffee found',
            style: TextStyle(color: AppColors.muted)),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (context, index) => _CoffeeCard(coffee: items[index]),
    );
  }

  Widget _buildBottomNav() {
    const icons = [
      Icons.home_rounded,
      Icons.favorite_rounded,
      Icons.shopping_bag_rounded,
      Icons.notifications_rounded,
    ];
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (i) {
          final selected = i == _navIndex;
          return IconButton(
            onPressed: () => setState(() => _navIndex = i),
            icon: Icon(
              icons[i],
              color: selected ? AppColors.highlight : AppColors.muted,
              size: 26,
            ),
          );
        }),
      ),
    );
  }
}

// ───────────────────────────────────────────────
class _CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  const _CoffeeCard({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: NetImage(coffee.image),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Color(0xCC1B0E09),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star,
                            size: 12, color: AppColors.highlight),
                        const SizedBox(width: 3),
                        Text('${coffee.rating}',
                            style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            coffee.name,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            coffee.subtitle,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${coffee.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${coffee.name} added to cart'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: AppColors.accent,
                    ),
                  );
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}