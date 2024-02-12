import 'package:flutter/material.dart';

class GuideLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'GuideLines',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
          backgroundColor:Color(0xFF4285F4),
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous page
            },
          ),
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(color: Colors.white),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Image.asset(
        //               'assets/lpg.png',
        //               height: 64,
        //               width: 64,
        //             ),
        //             SizedBox(height: 8),
        //             Text(
        //               'LPG leakage detector',
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 24,
        //               ),
        //             ),
        //             Text(
        //               'CodeMub',
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 15,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.share),
        //         title: Text('Share app'),
        //         onTap: () {
        //           // TODO: Implement share app functionality
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.star),
        //         title: Text('Rate App'),
        //         onTap: () {
        //           // TODO: Implement rate app functionality
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.bug_report),
        //         title: Text('Report Bug'),
        //         onTap: () {
        //           // TODO: Implement report bug functionality
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: SafetyGuidelinesPage(),
      ),
    );
  }
}

class SafetyGuidelinesPage extends StatefulWidget {
  @override
  _SafetyGuidelinesPageState createState() => _SafetyGuidelinesPageState();
}

class _SafetyGuidelinesPageState extends State<SafetyGuidelinesPage> {
  List<ExpansionPanelItem> _items = [
    ExpansionPanelItem(
      headerText: 'Proper Ventilation',
      contentText: '''
      1.Ensure that the kitchen is well-ventilated to prevent the accumulation of gas fumes, which can be harmful or flammable.
      2.Install an exhaust fan or range hood to facilitate the removal of gas byproducts.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'Regular Equipment Checks',
      contentText: '''
      1.Inspect gas pipes, hoses, and regulators at least once a month for any signs of wear, corrosion, or damage.
      2.Pay close attention to hose connections, ensuring they are tight and secure.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'No Naked Flames',
      contentText: '''
      Keep all open flames, such as candles, matches, and lighters, at a safe distance from the cooking area.
      Use spark ignition devices or electronic lighters designed for gas appliances.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'Emergency Shut-off Procedures',
      contentText: '''
      Locate the main gas shut-off valve in your home and ensure everyone in the household knows its location.
      In the event of a suspected gas leak, turn off the gas supply by closing the main shut-off valve and ventilate the area.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'No DIY Repairs',
      contentText: '''
      Do not attempt to repair or modify gas appliances, pipes, or connections unless you are a certified gas technician.
      Hire qualified professionals for installations, repairs, and maintenance.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'Gas Leak Detection',
      contentText: '''
      Familiarize yourself with the distinct odor of LPG, often described as a "rotten egg" smell. Gas suppliers add this odorant for easy detection.
      If you smell gas, do not use electrical switches, appliances, or phones. Evacuate the premises immediately and call emergency services.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'No Overcrowding',
      contentText: '''
      Avoid overcrowding the kitchen during cooking times to minimize the risk of accidental knocks or bumps that could lead to gas-related incidents.
      Establish clear communication regarding safety procedures with everyone in the household.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'Secure Gas Cylinders',
      contentText: '''
      Position LPG cylinders in an upright and well-ventilated outdoor area on a flat, non-combustible surface.
      Use safety straps or restraints to secure cylinders to a stable structure to prevent them from falling or tipping over.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'Fire Safety Equipment',
      contentText: '''
      Keep a multi-purpose fire extinguisher rated for flammable liquids, such as Class B and Class C, in the kitchen.
      Regularly check the pressure gauge, ensure the pin is intact, and follow manufacturer guidelines for maintenance.
      ''',
      isExpanded: false,
    ),
    ExpansionPanelItem(
      headerText: 'Emergency Evacuation Plan',
      contentText: '''
      Develop a comprehensive emergency evacuation plan for your household, clearly indicating escape routes and meeting points.
      Practice the plan regularly, ensuring that everyone is familiar with evacuation procedures and knows how to use emergency exits.
      ''',
      isExpanded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.all(0),
          elevation: 1,
          dividerColor: Colors.grey,
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !isExpanded;
            });
          },
          children: _items.map<ExpansionPanel>((ExpansionPanelItem item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerText),
                );
              },
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item.contentText),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExpansionPanelItem {
  final String headerText;
  final String contentText;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerText,
    required this.contentText,
    required this.isExpanded,
  });
}
