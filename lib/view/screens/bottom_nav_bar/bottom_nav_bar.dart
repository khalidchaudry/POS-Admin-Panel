import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/provider/theme_provider.dart';
import 'package:simplecashier/view/screens/inventory_screen/inventory_screen.dart';
import 'package:simplecashier/view/screens/screens.dart';

import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   int currentIndex=0;
  List pages=[
    const HomeScreen(),
    const AddItemsScreen(),
    const ItemsScreen(),
    const ReceiptScreen(),
    const InventoryScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
var themeCheck=Provider.of<ThemeProvider>(context).darkTheme;
    return Scaffold(bottomNavigationBar:  BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: true,
        selectedItemColor: themeCheck?Colors.black:Colors.white,
        selectedFontSize: 17,
        items: const [
          BottomNavigationBarItem(
icon: BottomNavBarBoxWidget(image: Images.menu),            label: 'Home',

          ),
          BottomNavigationBarItem(
icon: BottomNavBarBoxWidget(image: Images.add),            label: 'Add',
          ),
          BottomNavigationBarItem(
icon: BottomNavBarBoxWidget(image: Images.list),            label: 'Items',
          ),
                   BottomNavigationBarItem(
icon: BottomNavBarBoxWidget(image: Images.receipts),            label: 'Receipts',
          ),
          BottomNavigationBarItem(
icon: BottomNavBarBoxWidget(image: Images.inventory),            label: 'Inventory',
          ),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),

      body:        pages[currentIndex],
//        Row(
//         mainAxisAlignment: MainAxisAlignment.end,
        
//         children: [
//          if(MediaQuery.of(context).size.width>550)
// NavigationRail(  
//           selectedIndex:currentIndex,   
//           backgroundColor: AppColor.navigationRailBgColor,
//           destinations:  const [
   
//          NavigationRailDestination(
//      label: Text('Home'),

//           icon: BottomNavBarBoxWidget(image: Images.menu)
 
//         ),

//          NavigationRailDestination(

//          label: Text('Add Items'),

//           icon: BottomNavBarBoxWidget(image:Images.add)

//         ),
   
//          NavigationRailDestination(

//           label: Text('Items'),

//          icon: BottomNavBarBoxWidget(image:Images.list)

//         ),
//  NavigationRailDestination(

//           label: Text('Receipts'),

//    icon: BottomNavBarBoxWidget(image:Images.receipts)

//         ),
//         NavigationRailDestination(
//           label: Text('Inventory'),
//           selectedIcon: Tooltip(message: 'Inventory',),
//    icon: BottomNavBarBoxWidget(image:Images.inventory)
//         ),
//                 ],
  
//                 onDestinationSelected: (value) {

//             setState(() {
//               currentIndex=value;
//             });
//           },

//                 ),
//         Expanded(child: pages[currentIndex],)
        
//       ],)
      
      );
  }
}