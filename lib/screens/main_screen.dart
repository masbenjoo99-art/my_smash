import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../banksampah/bank_search_screen.dart';
import 'smart_drop_box_search_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialTabIndex;

  const MainScreen({super.key, this.initialTabIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      body: Column(
        children: [
        
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E5E5), 
                  width: 0.5,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x08000000), 
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.recycling), 
                  text: 'Bank Sampah',
                ),
                Tab(
                  icon: Icon(Icons.smart_toy),
                  text: 'Smart Drop Box',
                ),
              ],
             
              labelColor: const Color(0xFF216BC2),
              unselectedLabelColor: const Color(0xFF9E9E9E),
              indicatorColor: const Color(0xFF216BC2),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              dividerColor: Colors.transparent,
            ),
          ),
          
        
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
              
                BankSearchScreen(), 
                SmartDropBoxSearchScreen(), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
