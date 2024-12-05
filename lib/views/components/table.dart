import 'package:flutter/material.dart';

class DynamicTablePage extends StatefulWidget {
  final String role;

  DynamicTablePage({required this.role});

  @override
  _DynamicTablePageState createState() => _DynamicTablePageState();
}

class _DynamicTablePageState extends State<DynamicTablePage> {
  String selectedOption = "Aujourd'hui";
  List<String> dateOptions = [
    "Aujourd'hui",
    "Semaine dernière",
    "Mois dernier",
    "Tout"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table with Dynamic Data')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Search and options
          Container(
            width: 200,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Insérer la date désirée', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Rechercher',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dateOptions.map((option) {
                    return RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value as String;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Right side - Table and summary boxes
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top summary boxes
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildSummaryBoxes(),
                  ),
                ),
                // Table title
                Center(
                  child: Text(
                    _getTableTitle(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                // Table
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildTable(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Get table title based on role
  String _getTableTitle() {
    switch (widget.role) {
      case 'client':
        return 'Table des Commandes Client';
      case 'livreur':
        return 'Table des Commandes Livreur';
      case 'admin':
        return 'Table des Livraisons Admin';
      default:
        return 'Table des Commandes Restaurant';
    }
  }

  // Build the summary boxes based on role
  List<Widget> _buildSummaryBoxes() {
    if (widget.role == 'livreur') {
      return [
        _buildColoredBox('Total Income'),
        _buildColoredBox('Commandes Livrés'),
        _buildColoredBox('Commandes Annulés'),
      ];
    } else if (widget.role == 'client') {
      return [
        _buildColoredBox('Total Expenses'),
        _buildColoredBox('Commandes Effectuées'),
        _buildColoredBox('Commandes Annulés'),
      ];
    } else if (widget.role == 'admin') {
      return [
        _buildColoredBox('Total Income'),
        _buildColoredBox('Livraisons Recues'),
      ];
    } else {
      return [
        _buildColoredBox('Total Income'),
        _buildColoredBox('Commandes Effectuées'),
        _buildColoredBox('Commandes Annulés'),
      ];
    }
  }

  // Create a colored box for summary
  Widget _buildColoredBox(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Build the table based on role and date option
  Widget _buildTable() {
    List<DataColumn> columns = [];
    List<DataRow> rows = [];

    if (widget.role == 'client') {
      columns = [
        DataColumn(label: Text('ID Commande')),
        DataColumn(label: Text('Date Commande')),
        DataColumn(label: Text('Restaurant')),
        DataColumn(label: Text('Livreur Nom')),
        DataColumn(label: Text('Livreur ID')),
        DataColumn(label: Text('Temps d\'Arrivé')),
      ];
      rows = [
        DataRow(cells: [
          DataCell(Text('001')),
          DataCell(Text('24/09/2024')),
          DataCell(Text('Resto A')),
          DataCell(Text('John Doe')),
          DataCell(Text('123')),
          DataCell(Text('20 min')),
        ]),
      ];
    } else if (widget.role == 'livreur') {
      columns = [
        DataColumn(label: Text('ID Commande')),
        DataColumn(label: Text('Date Commande')),
        DataColumn(label: Text('Restaurant')),
        DataColumn(label: Text('Client Nom')),
        DataColumn(label: Text('Client ID')),
        DataColumn(label: Text('Temps d\'Arrivé')),
      ];
      rows = [
        DataRow(cells: [
          DataCell(Text('002')),
          DataCell(Text('24/09/2024')),
          DataCell(Text('Resto B')),
          DataCell(Text('Jane Smith')),
          DataCell(Text('456')),
          DataCell(Text('15 min')),
        ]),
      ];
    } else if (widget.role == 'admin') {
      columns = [
        DataColumn(label: Text('Livreur Nom')),
        DataColumn(label: Text('Date d\'Arrivé')),
      ];
      rows = [
        DataRow(cells: [
          DataCell(Text('Mark Johnson')),
          DataCell(Text('24/09/2024')),
        ]),
      ];
    }

    return DataTable(columns: columns, rows: rows);
  }
}
