import 'package:flutter/material.dart';
import 'package:malex_new/data/seed/branches.dart';
import 'package:malex_new/data/seed/cash_sale.dart';
import 'package:malex_new/data/seed/customer.dart';
import 'package:malex_new/data/seed/emails.dart';
import 'package:malex_new/data/seed/employees.dart';
import 'package:malex_new/data/seed/expense.dart';
import 'package:malex_new/data/seed/inventory.dart';
import 'package:malex_new/data/seed/invoice.dart';
import 'package:malex_new/data/seed/lead.dart';
import 'package:malex_new/data/seed/quotation.dart';
import 'package:malex_new/data/seed/sales.dart';
import 'package:malex_new/data/seed/settings.dart';
import 'package:malex_new/screens/accounting_tab.dart';
import 'package:malex_new/screens/branches_tab.dart';
import 'package:malex_new/screens/cash_sales_tab.dart';
import 'package:malex_new/screens/customers_tab.dart';
import 'package:malex_new/screens/dahboard.dart';
import 'package:malex_new/screens/emails_tab.dart';
import 'package:malex_new/screens/employees_tab.dart';
import 'package:malex_new/screens/expenses_tab.dart';
import 'package:malex_new/screens/inventory_tab.dart';
import 'package:malex_new/screens/invoices_tab.dart';
import 'package:malex_new/screens/leads_tab.dart';
import 'package:malex_new/screens/quotations_tab.dart';
import 'package:malex_new/screens/reports_tab.dart';
import 'package:malex_new/screens/sales_tab.dart';
import 'package:malex_new/screens/settings_tab.dart';
import 'package:malex_new/screens/time_qr/time_qr_tab.dart';
import 'package:malex_new/widgets/common/navigation_tile.dart';

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chemical Company Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF2C3E50)),
        ),
      ),
      home: const ExpenseTrackerDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExpenseTrackerDashboard extends StatefulWidget {
  const ExpenseTrackerDashboard({super.key});

  @override
  State<ExpenseTrackerDashboard> createState() => _ExpenseTrackerDashboardState();
}

class _ExpenseTrackerDashboardState extends State<ExpenseTrackerDashboard> {
  int _selectedIndex = 0;
  final ScrollController _navScrollController = ScrollController(); 

final List<NavigationItem> _navigationItems = const [
  NavigationItem('Dashboard', Icons.dashboard),
  NavigationItem('Expenses', Icons.receipt),
  NavigationItem('Sales', Icons.shopping_cart),
  NavigationItem('Cash Sales', Icons.point_of_sale),
  NavigationItem('Quotations', Icons.note_add),
  NavigationItem('Invoices', Icons.description),
  NavigationItem('Inventory', Icons.inventory),
  NavigationItem('Customers', Icons.people),
  NavigationItem('Leads', Icons.leaderboard),
  NavigationItem('Employees', Icons.badge),
  NavigationItem('Branches', Icons.business),
  NavigationItem('Time QR', Icons.qr_code),
  NavigationItem('Emails', Icons.email),
  NavigationItem('Accounting', Icons.calculate),
  NavigationItem('Reports', Icons.bar_chart),
  NavigationItem('Settings', Icons.settings),
];

  final List<DashboardCard> _dashboardCards = const [
    DashboardCard('Sales', Icons.attach_money, Color(0xFF4CAF50)),
    DashboardCard('Invoices', Icons.description, Color(0xFF2196F3)),
    DashboardCard('Inventory', Icons.inventory, Color(0xFFFF9800)),
    DashboardCard('Accounting', Icons.calculate, Color(0xFF9C27B0)),
    DashboardCard('Reports', Icons.bar_chart, Color(0xFFF44336)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _navigationItems[_selectedIndex].title,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80'),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Navigation
          // Sidebar Navigation
    Container(
            width: 240,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    controller: _navScrollController, // 👈 link controller
                    thumbVisibility: true,
                    child: ListView(
                      controller: _navScrollController, // 👈 same controller
                      padding: const EdgeInsets.only(top: 20),
                      children: _navigationItems.map((item) {
                        final index = _navigationItems.indexOf(item);
                        return NavigationTile(
                          item: item,
                          isSelected: _selectedIndex == index,
                          onTap: () => setState(() => _selectedIndex = index),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Footer – always visible
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MALEX CHEM SUPPLIES.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7F8C8D),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Monthly Budget',
                        style: TextStyle(fontSize: 14, color: Color(0xFF7F8C8D)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'KSh 45,000',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.65,
                        backgroundColor: Color(0xFFECF0F1),
                        valueColor: AlwaysStoppedAnimation(Color(0xFF3498DB)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: _buildCurrentTab(),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildCurrentTab() {
  switch (_selectedIndex) {
    case 0:
      return DashboardTab(
      cards: _dashboardCards,
      expenses: seedExpenses,
      categoryColorBuilder: _getCategoryColor,
    );
    case 1: 
    return ExpensesTab(  
      expenses: seedExpenses,
      categoryColorBuilder: _getCategoryColor,
      //onAdd: _handleAdd,
      //onFilter: _handleFilter,
      //onEdit: (e) => _handleEdit(e),
      //onDelete: (e) => _handleDelete(e),
      //onReceipt: (e) => _handleReceipt(e),
    );
    case 2:
      return SalesTab(
        sales: seedSales,
        statusColorBuilder: _getStatusColor,
       // onNewSale: _handleNewSale,
      );
    case 3:
      return CashSalesTab(
      sales: seedCashSales,
      //onNewSale: _handleNewCashSale,
    );
    case 4:
      return QuotationsTab(
      quotations: seedQuotations,
      statusColorBuilder: _getQuotationStatusColor,
      //onCreate: _handleCreateQuotation,
    );
    case 5:
      return InvoicesTab(
        invoices: seedInvoices,
        statusColorBuilder: _getInvoiceStatusColor,
        //onCreate: _handleCreateInvoice,
      );
    case 6:
      return InventoryTab(
      items: seedInventory,
      //onAddItem: _handleAddItem,
    );
    case 7:
      return CustomersTab(
      customers: seedCustomers,
      //onAddCustomer: _handleAddCustomer,
    );
    case 8:
      return LeadsTab(
      leads: seedLeads,
      statusColorBuilder: _getLeadStatusColor,
      //onAddLead: _handleAddLead,
    );
    case 9:
      return EmployeesTab(
      employees: seedEmployees,
      //onAddEmployee: _handleAddEmployee,
    );
    case 10:
      return BranchesTab(
      branches: seedBranches,
      //onAddBranch: _handleAddBranch,
    );
    case 11:
      return TimeQrTab(
      //onDownloadQr: _handleDownloadQr,
      //onShareQr: _handleShareQr,
    );
    case 12:
          return EmailsTab(
      emails: seedEmails,
      //onCompose: _handleCompose,
      //onOpen: _handleOpenEmail,
    );
    case 13:
      return AccountingTab(
      //onViewPnL: _handleViewPnL,
      //onViewBalanceSheet: _handleViewBalanceSheet,
      //onViewTransactions: _handleViewTransactions,
    );
    case 14:
      return ReportsTab(
      //onExpenseReport: _openExpenseReport,
      //onSalesReport: _openSalesReport,
      //onProfitabilityReport: _openProfitabilityReport,
      //onTaxReport: _openTaxReport,
      //onInventoryReport: _openInventoryReport,
      //onCustomBuilder: _openCustomBuilder,
    );
    case 15:
      return SettingsTab(
      initialSettings: seedSettings,
    //onSave: _handleSaveSettings,
    );  
    default:
      return DashboardTab(
      cards: _dashboardCards,
      expenses: seedExpenses,
      categoryColorBuilder: _getCategoryColor,
    );
  }
}
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Transportation':
        return const Color(0xFF3498DB);
      case 'Utilities':
        return const Color(0xFF2ECC71);
      case 'Office Supplies':
        return const Color(0xFF9B59B6);
      case 'Packaging':
        return const Color(0xFFE67E22);
      case 'Raw Materials':
        return const Color(0xFFE74C3C);
      case 'Containers':
        return const Color(0xFFF1C40F);
      case 'Safety':
        return const Color(0xFF1ABC9C);
      default:
        return const Color(0xFF95A5A6);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return const Color(0xFF2ECC71);
      case 'Processing':
        return const Color(0xFFF39C12);
      case 'Pending':
        return const Color(0xFF3498DB);
      default:
        return const Color(0xFF95A5A6);
    }
  }

  Color _getInvoiceStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return const Color(0xFF2ECC71);
      case 'Unpaid':
        return const Color(0xFFF39C12);
      case 'Overdue':
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFF95A5A6);
    }
  }
}

class NavigationItem {
  final String title;
  final IconData icon;

  const NavigationItem(this.title, this.icon);
}

class DashboardCard {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard(this.title, this.icon, this.color);
}

Color _getQuotationStatusColor(String status) {
  switch (status) {
    case 'Approved':
      return const Color(0xFF2ECC71);
    case 'Pending':
      return const Color(0xFFF39C12);
    case 'Rejected':
      return const Color(0xFFE74C3C);
    default:
      return const Color(0xFF95A5A6);
  }
}

Color _getLeadStatusColor(String status) {
  switch (status) {
    case 'Hot':
      return const Color(0xFFE74C3C);
    case 'Warm':
      return const Color(0xFFF39C12);
    case 'Cold':
      return const Color(0xFF3498DB);
    default:
      return const Color(0xFF95A5A6);
  }
}