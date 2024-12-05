import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoPage extends StatefulWidget {
  final String role;
  final List<String> rowData;

  const ContactInfoPage({super.key, required this.role, required this.rowData});

  @override
  _ContactInfoPageState createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<String> _tabs;

  @override
  void initState() {
    super.initState();
    // Initialize the tab controller and tabs based on the role
    _tabController = TabController(length: _getTabs(widget.role).length, vsync: this);
    _tabs = _getTabs(widget.role);
  }

  List<String> _getTabs(String role) {
  if (role.trim().toLowerCase() == 'restaurants') {
    return ['Commandes Livrées', 'Commandes Annulées', 'Commandes en Cours', 'Abonnement'];
  } else if (role.trim().toLowerCase() == 'admins') {
    return ['Associés', 'Historique de Paiement'];
  } else if (role.trim().toLowerCase() == 'clients') {
    return ['Historique des Commandes', 'Commandes Annulées', 'Commandes en Cours'];
  } else if (role.trim().toLowerCase() == 'livreurs') {
    return ['Historique des Commandes', 'Commandes Annulées', 'Commandes en Cours', 'Historique des Paiements'];
  } else {
    print('Unrecognized role: $role'); // Debugging output
    return ["Rien sélectionné"];
  }
}


Widget _buildHistoryTableContent(String tab) {
  List<Map<String, String>> historyData;
  List<DataColumn> tableColumns;

  switch (tab) {
    case 'Commandes Livrées':
      tableColumns = [
        const DataColumn(label: Text('ID_commande')),
        const DataColumn(label: Text('ID_client')),
        const DataColumn(label: Text('ID_restaurant')),
        const DataColumn(label: Text('ID_livreur')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Details_commande')),
        const DataColumn(label: Text('circuit_KM')),
        const DataColumn(label: Text('Temps_min')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'cash','RIB':'N/A'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'cash','RIB':'N/A'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    case 'Commandes Annulées':
      tableColumns = [
        const DataColumn(label: Text('ID_commande')),
        const DataColumn(label: Text('ID_client')),
        const DataColumn(label: Text('ID_restaurant')),
        const DataColumn(label: Text('ID_livreur')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Details_commande')),
        const DataColumn(label: Text('circuit_KM')),
        const DataColumn(label: Text('Annulée_par')),
        const DataColumn(label: Text('Temps_annulation')),
      ];
      historyData = [
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Annulée_Par':'#124g','Temps_annulation':'31-07-2025 17:30'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Annulée_Par':'#124g','Temps_annulation':'31-07-2025 17:30'},
      ];
      break;
    case 'Commandes en Cours':
            tableColumns = [
        const DataColumn(label: Text('ID_commande')),
        const DataColumn(label: Text('ID_client')),
        const DataColumn(label: Text('ID_restaurant')),
        const DataColumn(label: Text('ID_livreur')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Details_commande')),
        const DataColumn(label: Text('circuit_KM')),
        const DataColumn(label: Text('Temps_min')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'cash','RIB':'N/A'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'cash','RIB':'N/A'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    case 'Abonnement':
      tableColumns = [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('Date_dep')),
        const DataColumn(label: Text('Date_exp')),
        const DataColumn(label: Text('Statut')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID': '#12358', 'Date_dep': '2024-11-01','Date_exp': '2024-11-01', 'Description': 'Abonnement #1', 'Montant': '\$100','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    case 'Associés':
      tableColumns = [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('ID_associé')),
        const DataColumn(label: Text('Role_associé')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Details')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID': '#12359', 'ID_associé': '#56789', 'Role_associé': '#56789', 'Date': '2024-11-01', 'Details': 'Associé #1', 'Montant': '\$150','Methode_paiement':'carte','RIB':'1234567891'},
        {'ID': '#12359', 'ID_associé': '#56789', 'Role_associé': '#56789', 'Date': '2024-11-01', 'Details': 'Associé #1', 'Montant': '\$150','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    case 'Historique de Paiement':
      tableColumns = [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Description')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID': '#12360', 'Date': '2024-11-02', 'Description': 'Paiement reçu', 'Montant': '\$200','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    case 'Historique des Commandes':
            tableColumns = [
        const DataColumn(label: Text('ID_commande')),
        const DataColumn(label: Text('ID_client')),
        const DataColumn(label: Text('ID_restaurant')),
        const DataColumn(label: Text('ID_livreur')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Details_commande')),
        const DataColumn(label: Text('circuit_KM')),
        const DataColumn(label: Text('Temps_min')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'cash','RIB':'N/A'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'cash','RIB':'N/A'},
        {'ID_commande': '#12354','ID_restaurant': '#12354','ID_livreur': '#12354', 'Date': '2024-11-01', 'Details_commande': 'Commande #123','circuit_KM': '8','Temps_min':'30', 'Montant': '\$50','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    case 'Historique des Paiements':
       tableColumns = [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('Date')),
        const DataColumn(label: Text('Description')),
        const DataColumn(label: Text('Montant')),
        const DataColumn(label: Text('Methode_paiement')),
        const DataColumn(label: Text('RIB')),
      ];
      historyData = [
        {'ID': '#12360', 'Date': '2024-11-02', 'Description': 'Paiement reçu', 'Montant': '\$200','Methode_paiement':'carte','RIB':'1234567891'},
      ];
      break;
    default:
      tableColumns = [];
      historyData = [];
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: tableColumns,
      rows: historyData.map((item) {
        return DataRow(cells: tableColumns.map((column) {
          String columnLabel = column.label.toString().replaceAll("Text(\"", "").replaceAll("\")", "");
          return DataCell(Text(item[columnLabel] ?? 'N/A'));
        }).toList());
      }).toList(),
    ),
  );
}

  @override
@override
Widget build(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Red container holding the picture, info, and depenses
            Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 219, 240, 218),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Profile picture
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.jpg'),
                  ),
                  const SizedBox(width: 26),
                  // Expanded section for info and depenses
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Info sections (ID, Name, Email, etc.)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildInfoSections(context),
                        ),
                      ],
                    ),
                  ),
                  const Text('Depenses: 2500', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Action buttons under the red rectangle
            Row(
  children: [
    // Existing action buttons, all wrapped in Expanded to maintain equal width
    Expanded(
      child: _buildActionButton(context, 'Contact Info', _showContactInfoDialog),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: _buildActionButton(context, 'Modifier Utilisateur', _showUpdateUserDialog),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: _buildActionButton(context, 'Effacer utilisateur', _showDeleteUserDialog),
    ),
    const SizedBox(width: 10),
    // Show 'Ajouter Admin' button only if role is 'admins'
    if (widget.role.trim().toLowerCase() == 'admins')
      Expanded(
        child: _buildActionButton(context, 'Ajouter Admin', _showAjouterAdminDialog),
      ),
    const SizedBox(width: 10), // Add space between buttons
    // Show 'Payer Utilisateur' button if role is 'admins', 'livreurs', or 'restaurant'
    if (widget.role.trim().toLowerCase() == 'admins' || widget.role.trim().toLowerCase() == 'livreurs' || widget.role.trim().toLowerCase() == 'restaurants')
      Expanded(
        child: _buildActionButton(context, 'Payer Utilisateur', _showPayerDialog),
      ),
  ],
),

            const SizedBox(height: 20),
            _buildExpensesAndSearch(context),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: _tabs.map((tab) {
                  return _buildHistoryTableContent(tab);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<Widget> _buildInfoSections(BuildContext context) {
  List<Widget> infoWidgets = [
    _buildInfoRow('ID', widget.rowData[0]),
    _buildInfoRowWithIcon(context, 'CIN', widget.rowData[1], showIcon: widget.role.trim().toLowerCase() == 'admins' || widget.role.trim().toLowerCase() == 'restaurants' || widget.role.trim().toLowerCase() == 'livreurs', actionType: 'cin', icon: Icons.picture_in_picture),
    _buildInfoRow('Nom Complet', widget.rowData[2]),
    _buildInfoRow('E-mail', widget.rowData[3]),
    _buildInfoRow('Telephone', widget.rowData[4]),
  ];

  if (widget.role.trim().toLowerCase() == 'livreurs') {
    infoWidgets.addAll([
      _buildInfoRowWithIcon(context, 'Permis de Conduite', '', actionType: 'pattente', icon: Icons.card_membership),
      _buildInfoRow('Region', widget.rowData[3]),
    ]);
  } else if (widget.role.trim().toLowerCase() == 'restaurants') {
    infoWidgets.addAll([
      _buildInfoRowWithIcon(context, 'Location', '', actionType: 'location', icon: Icons.location_on),
      _buildInfoRowWithIcon(context, 'Pattente', '', actionType: 'pattente', icon: Icons.card_membership),
    ]);
  } else if (widget.role.trim().toLowerCase() == 'clients') {
    infoWidgets.add(_buildInfoRowWithIcon(context, 'Location', '', actionType: 'location', icon: Icons.location_on));
  }

  return [
    Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: infoWidgets.sublist(0, (infoWidgets.length / 2).ceil()),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: infoWidgets.sublist((infoWidgets.length / 2).ceil()),
          ),
        ),
      ],
    ),
  ];
}


 Widget _buildInfoRowWithIcon(BuildContext context, String label, String value, {bool showIcon = true, IconData? icon, String? actionType}) {
  return Row(
    children: [
      Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(value),
      if (showIcon)
        GestureDetector(
          onTap: () {
            if (actionType == 'cin') {
              _showCINImagePopup(context);
            } else if (actionType == 'pattente') {
              _showPattenteImagePopup(context);
            } else if (actionType == 'location') {
              _showLocationDialog(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(icon ?? Icons.location_on, color: Colors.green, size: 20),
          ),
        ),
    ],
  );
}

void _showCINImagePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('CIN Image'),
        content: Image.asset('assets/cin_image.png'), // Replace with actual CIN image path
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}


void _showPattenteImagePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pattente Image'),
        content: Image.asset('assets/pattente_image.png'), // Replace with actual Pattente image path
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}



  

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

Widget _buildActionButton(BuildContext context, String label, Function onPressed) {
  return ElevatedButton(
    onPressed: () => onPressed(context),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white, // Replaces 'primary'
      foregroundColor: Colors.black,  // Replaces 'onPrimary'
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(label),
  );
}


  Widget _buildExpensesAndSearch(BuildContext context) {
    return const Row(
      children: [
        Text("Historique de L'utilisateur :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
        SizedBox(width: 40),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

void _showLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLocationItem(context, 'Location 1', 'Address 1'),
            _buildLocationItem(context, 'Location 2', 'Address 2'),
            _buildLocationItem(context, 'Location 3', 'Address 3'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

Widget _buildLocationItem(BuildContext context, String location, String address) {
  return Row(
    children: [
      const Icon(Icons.location_on, color: Colors.green),
      Text(location),
      IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: address));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Address copied to clipboard')),
          );
        },
      ),
    ],
  );
}


void _showContactInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Contact Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Phone Number Input with Copy Button on the Right
            TextFormField(
              readOnly: true,
              initialValue: widget.rowData[4],
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Phone Number',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.copy, color: Colors.black),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.rowData[4]));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Phone number copied!')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Email Input with Email Button on the Right
            TextFormField(
              readOnly: true,
              initialValue: widget.rowData[3],
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mail, color: Colors.black),
                  onPressed: () {
                    final email = widget.rowData[3];
                    launch('mailto:$email');
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Send Alert Button Styled Like an Input Field
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () => _showAlertDialog(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color.fromARGB(255, 132, 131, 131)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Send Alert',
                    style: TextStyle(color: Colors.black,fontSize: 18 ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

 void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Alert to: ${widget.rowData[2]}'),
          content: const TextField(
            decoration: InputDecoration(hintText: 'Type your message'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Submit')),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ],
        );
      },
    );
  }

void _showUpdateUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners for dialog
        ),
        title: const Text(
          'Update User Info',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12), // Spacing between fields

              // Password field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12), // Spacing between fields

              // Confirm Password field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20), // Spacing between fields and button

              // Row for positioning the Close button to the right
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Aligning button to the right
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


  // Delete User Dialog
  void _showDeleteUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}

void _showAjouterAdminDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ajouter un Admin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildTextField("Full Name", (value) {}),
                _buildTextField("Email", (value) {}),
                _buildTextField("Password", (value) {}, obscureText: true),
                _buildTextField("Confirm Password", (value) {}, obscureText: true),
                _buildTextField("Phone", (value) {}),
                _buildTextField("Region", (value) {}),
                _buildFileUploadField("CIN (Upload)", (file) {}),
                _buildTextField("RIB", (value) {}),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission logic
                    Navigator.of(context).pop();  // Close dialog
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


Widget _buildTextField(String label, Function(String) onChanged, {bool obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

Widget _buildFileUploadField(String label, Function(String) onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton(
      onPressed: () {
        // Implement file upload logic here
        // Placeholder action
        onChanged('File Uploaded');
      },
      child: Text(label),
    ),
  );
}


void _showPayerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Payer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildPaymentMethodSelector(),
                _buildTextField("RIB", (value) {}),
                if (_isCardSelected) ...[
                  _buildTextField("Card Name", (value) {}),
                  _buildTextField("Card Coordinates", (value) {}),
                ],
                _buildTextField("Password", (value) {}, obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission logic
                    Navigator.of(context).pop();  // Close dialog
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

bool _isCardSelected = false;

Widget _buildPaymentMethodSelector() {
  return Row(
    children: [
      const Text("Payment Method: "),
      Radio(
        value: true,
        groupValue: _isCardSelected,
        onChanged: (value) {
          _isCardSelected = value!;
        },
      ),
      const Text("Card"),
      Radio(
        value: false,
        groupValue: _isCardSelected,
        onChanged: (value) {
          _isCardSelected = value!;
        },
      ),
      const Text("Cash"),
    ],
  );
}
