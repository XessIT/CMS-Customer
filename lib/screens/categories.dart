import 'package:cms_customer/screens/post.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.cleaning_services_outlined, 'label': 'Cleaning'},
    {'icon': Icons.build_circle_outlined, 'label': 'Repairing'},
    {'icon': Icons.electrical_services_outlined, 'label': 'Electrician'},
    {'icon': Icons.chair_outlined, 'label': 'Carpenter'},
    {'icon': Icons.filter_tilt_shift_outlined, 'label': 'Fitting'},
    {'icon': Icons.emoji_transportation_outlined, 'label': 'Transport'},
    {'icon': Icons.add_home_work_outlined, 'label': 'Construction'},
    {'icon': Icons.engineering_outlined, 'label': 'Mechanic'},
    {'icon': Icons.format_paint_outlined, 'label': 'Painting'},
    {'icon': Icons.plumbing_outlined, 'label': 'Plumbing'},
    {'icon': Icons.local_hospital_outlined, 'label': 'Pest Control'},
    {'icon': Icons.tv_outlined, 'label': 'Appliance Repair'},
    {'icon': Icons.landscape_outlined, 'label': 'Landscaping'},
    {'icon': Icons.grass_outlined, 'label': 'Lawn Care'},
    {'icon': Icons.nature_outlined, 'label': 'Tree Services'},
    {'icon': Icons.pool_outlined, 'label': 'Pool Maintenance'},
    {'icon': Icons.clean_hands_outlined, 'label': 'Window Cleaning'},
    {'icon': Icons.roofing_outlined, 'label': 'Gutter Cleaning'},
    {'icon': Icons.wash_outlined, 'label': 'Pressure Washing'},
    {'icon': Icons.garage_outlined, 'label': 'Garage Door Repair'},
    {'icon': Icons.lock_outlined, 'label': 'Locksmith'},
    {'icon': Icons.security_outlined, 'label': 'Home Security Installation'},
    {'icon': Icons.home_outlined, 'label': 'Smart Home Installation'},
    {'icon': Icons.chair_alt_outlined, 'label': 'Furniture Assembly'},
    {'icon': Icons.cleaning_services_outlined, 'label': 'Carpet Cleaning'},
    {'icon': Icons.local_laundry_service_outlined, 'label': 'Upholstery Cleaning'},
    {'icon': Icons.fireplace_outlined, 'label': 'Chimney Sweeping'},
    {'icon': Icons.wallpaper_outlined, 'label': 'Drywall Repair'},
    {'icon': Icons.clean_hands_rounded, 'label': 'Tile and Grout Cleaning'},
    {'icon': Icons.masks_outlined, 'label': 'Mold Remediation'},
    {'icon': Icons.water_damage_outlined, 'label': 'Water Damage Restoration'},
    {'icon': Icons.fact_check_outlined, 'label': 'Home Inspection'},
    {'icon': Icons.deck_outlined, 'label': 'Deck and Patio Repair'},
    {'icon': Icons.drive_eta_outlined, 'label': 'Driveway Sealing'},
    {'icon': Icons.home_outlined, 'label': 'Siding Repair'},
    {'icon': Icons.water_damage_sharp, 'label': 'Basement Waterproofing'},
    {'icon': Icons.scatter_plot_outlined, 'label': 'Radon Mitigation'},
    {'icon': Icons.propane_tank, 'label': 'Septic Tank Services'},
    {'icon': Icons.delete_outline, 'label': 'Junk Removal'},
    {'icon': Icons.local_shipping_outlined, 'label': 'Moving Services'},
    {'icon': Icons.storage_outlined, 'label': 'Storage Solutions'},
    {'icon': Icons.ac_unit_outlined, 'label': 'Snow Removal'},
    {'icon': Icons.window_outlined, 'label': 'Window Installation'},
    {'icon': Icons.door_back_door_outlined, 'label': 'Door Installation'},
    {'icon': Icons.fence_outlined, 'label': 'Fence Repair'},
    {'icon': Icons.format_paint_outlined, 'label': 'Flooring Installation'},
    {'icon': Icons.bed_outlined, 'label': 'Curtain and Blind Installation'},
    {'icon': Icons.wb_sunny_outlined, 'label': 'Solar Panel Installation'},
    {'icon': Icons.electric_car_outlined, 'label': 'Electrical Vehicle Charger Installation'},
    {'icon': Icons.power_outlined, 'label': 'Generator Installation'},
    {'icon': Icons.device_thermostat_outlined, 'label': 'Insulation Services'},
    {'icon': Icons.ac_unit_sharp, 'label': 'HVAC Duct Cleaning'},
    {'icon': Icons.air_outlined, 'label': 'Air Quality Testing'},
    {'icon': Icons.science_outlined, 'label': 'Radon Testing'},
    {'icon': Icons.settings_system_daydream_outlined, 'label': 'Lawn Irrigation System Repair'},
    {'icon': Icons.spa_outlined, 'label': 'Sprinkler System Installation'},
    {'icon': Icons.eco_outlined, 'label': 'Greenhouse Installation'},
    {'icon': Icons.filter_alt_outlined, 'label': 'Water Filtration System Installation'},
    {'icon': Icons.thermostat_outlined, 'label': 'Water Heater Repair'},
    {'icon': Icons.water_outlined, 'label': 'Sump Pump Installation'},
    {'icon': Icons.roofing_outlined, 'label': 'Roof Cleaning'},
    {'icon': Icons.energy_savings_leaf_outlined, 'label': 'Home Energy Audit'},
    {'icon': Icons.maps_home_work, 'label': 'Ceiling Fan Installation'},
    {'icon': Icons.light_outlined, 'label': 'Light Fixture Installation'},
    {'icon': Icons.alarm_outlined, 'label': 'Alarm System Repair'},
    {'icon': Icons.theater_comedy_outlined, 'label': 'Home Theater Installation'},
    {'icon': Icons.tv_outlined, 'label': 'TV Mounting'},
    {'icon': Icons.network_check_outlined, 'label': 'Home Network Installation'},
    {'icon': Icons.satellite_outlined, 'label': 'Satellite Dish Installation'},
    {'icon': Icons.hot_tub_outlined, 'label': 'Hot Tub Repair'},
    {'icon': Icons.install_desktop, 'label': 'Sauna Installation'},
    {'icon': Icons.fort_outlined, 'label': 'Gazebo Installation'},
    {'icon': Icons.hourglass_empty_outlined, 'label': 'Shed Assembly'},
    {'icon': Icons.toys_outlined, 'label': 'Playset Assembly'},
    {'icon': Icons.storm_outlined, 'label': 'Storm Window Installation'},
    {'icon': Icons.door_sliding_outlined, 'label': 'Storm Door Installation'},
    {'icon': Icons.install_desktop_outlined, 'label': 'Awning Installation'},
    {'icon': Icons.wb_sunny_outlined, 'label': 'Skylight Installation'},
    {'icon': Icons.kitchen_outlined, 'label': 'Cabinet Refacing'},
    {'icon': Icons.countertops_outlined, 'label': 'Countertop Installation'},
    {'icon': Icons.storage_outlined, 'label': 'Garage Organization'},
    {'icon': Icons.account_box_outlined, 'label': 'Closet Organization'},
    {'icon': Icons.house_outlined, 'label': 'Attic Insulation'},
    {'icon': Icons.vertical_align_center_outlined, 'label': 'Attic Ventilation'},
    {'icon': Icons.subway_outlined, 'label': 'Crawl Space Encapsulation'},
    {'icon': Icons.volume_off_outlined, 'label': 'Soundproofing'},
    {'icon': Icons.tungsten_outlined, 'label': 'Window Tinting'},
    {'icon': Icons.nature_outlined, 'label': 'Stump Grinding'},
    {'icon': Icons.heat_pump_outlined, 'label': 'Well Pump Repair'},
    {'icon': Icons.drive_eta_outlined, 'label': 'Driveway Paving'},
    {'icon': Icons.foundation_outlined, 'label': 'Foundation Repair'},
    {'icon': Icons.water_drop_outlined, 'label': 'Leak Detection'},
    {'icon': Icons.construction_outlined, 'label': 'Concrete Resurfacing'},
    {'icon': Icons.stop_circle_rounded, 'label': 'Stone Masonry'},
    {'icon': Icons.wallpaper_sharp, 'label': 'Retaining Wall Installation'},
    {'icon': Icons.landscape_outlined, 'label': 'Hardscaping'},
    {'icon': Icons.light_outlined, 'label': 'Landscape Lighting'},
    {'icon': Icons.local_florist_outlined, 'label': 'Garden Design'},
    {'icon': Icons.outdoor_grill_outlined, 'label': 'Outdoor Kitchen Installation'},
    {'icon': Icons.fireplace_outlined, 'label': 'Fire Pit Installation'},
  ];

  late List<Map<String, dynamic>> _filteredCategories;

  @override
  void initState() {
    super.initState();
    _filteredCategories = List.from(_categories);
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _categories
          .where((category) =>
          category['label'].toString().toLowerCase().contains(query))
          .toList();
    });
  }

  Widget buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostRequestScreen(
                category: {'icon': icon, 'label': label},
              ),
            ),
          );
          },
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF3F5FD),
      appBar: AppBar(
        //backgroundColor: Color(0xFF22538D),
        backgroundColor: Color(0xFFFFD188),
        title: Text('Post Request',style: TextStyle(color: Colors.black) ,),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Find a service',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align( alignment: Alignment.centerLeft, child: Text('Select Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
            // ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: _filteredCategories.map((category) {
                  return buildCategoryItem(category['icon'], category['label']);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
