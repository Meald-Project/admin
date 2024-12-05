import 'package:flutter/material.dart';
import 'contactInfo_page.dart';

class CollaboratorsPage extends StatefulWidget {
  const CollaboratorsPage({super.key});

  @override
  _CollaboratorsPageState createState() => _CollaboratorsPageState();
}

class _CollaboratorsPageState extends State<CollaboratorsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Updated user data for each role with additional fields
  final List<Map<String, String>> admins = List.generate(10, (index) => {
        'ID': '$index',
        'CIN': 'CIN-$index',
        'Nom Complet': 'Admin $index',
        'Email': 'admin$index@example.com',
        'Telephone': '01234567$index',
        'region': 'Region-$index',
        'payment Method': 'Payment-$index',
        'Date d\'embauche': '2022-01-01',
        'Dernière modification': '2022-01-01',
      });

  final List<Map<String, String>> livreurs = List.generate(10, (index) => {
        'ID': '$index',
        'CIN': 'CIN-$index',
        'Nom Complet': 'Livreur $index',
        'Email': 'livreur$index@example.com',
        'Telephone': '01234567$index',
        'Permis': 'Permis-$index',
        'region': 'Region-$index',
        'payment Method': 'Payment-$index',
        'Date d\'embauche': '2022-01-01',
        'Dernière modification': '2022-01-01',
      });

  final List<Map<String, String>> clients = List.generate(10, (index) => {
        'ID': '$index',
        'CIN': 'N/A',
        'Nom Complet': 'Client $index',
        'Email': 'client$index@example.com',
        'Telephone': '01234567$index',
        'region': 'Region-$index',
        'payment Method': 'Payment-$index',
        'Dernière modification': '2022-01-01',
      });

  final List<Map<String, String>> restaurants = List.generate(10, (index) => {
        'ID': '$index',
        'CIN': 'CIN-$index',
        'Nom Complet': 'Restaurant $index',
        'Email': 'restaurant$index@example.com',
        'Telephone': '01234567$index',
        'Pattente': 'Pattente-$index',
        'region': 'Region-$index',
        'payment Method': 'Payment-$index',
        'Date d\'embauche': '2022-01-01',
        'Dernière modification': '2022-01-01',
      });

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collaborators'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Admins'),
            Tab(text: 'Livreurs'),
            Tab(text: 'Clients'),
            Tab(text: 'Restaurants'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTable('Admins', admins),
          _buildTable('Livreurs', livreurs),
          _buildTable('Clients', clients),
          _buildTable('Restaurants', restaurants),
        ],
      ),
    );
  }

  Widget _buildTable(String role, List<Map<String, String>> data) {
    // Dynamically define columns based on the keys of the first data map
    final columns = data.isNotEmpty ? data.first.keys.toList() : [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
        rows: data.map((row) {
          return DataRow(
            cells: columns.map((col) {
              return DataCell(
                Text(row[col] ?? 'N/A'),
                onTap: () {
                  _showDetailDialog(role, row);
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  void _showDetailDialog(String role, Map<String, String> row) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactInfoPage(
          role: role,
          rowData: row.values.toList(),
        ),
      ),
    );
  }

  void _showPattenteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pattente Image'),
          content: Image.network(
            'https://cdn.nawaat.org/wp-content/uploads/2015/05/patente-WhateverSaloon-espace-culturel-tunisie.jpg', // Replace with actual image URL
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
