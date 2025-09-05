import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  final Map<String, dynamic> initialSettings;
  final VoidCallback? onSave;

  const SettingsTab({
    Key? key,
    required this.initialSettings,
    this.onSave,
  }) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late Map<String, dynamic> _settings;

  @override
  void initState() {
    super.initState();
    _settings = Map.from(widget.initialSettings);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                // Company Settings
                _section('Company Settings', Icons.business, [
                  _textField('Company Name', 'companyName', _settings['companyName']),
                  _dropdown(
                    'Currency',
                    'currency',
                    _settings['currency'],
                    ['KSh', 'USD', 'EUR', 'GBP'],
                  ),
                  _dropdown(
                    'Date Format',
                    'dateFormat',
                    _settings['dateFormat'],
                    ['yyyy-MM-dd', 'dd/MM/yyyy', 'MM/dd/yyyy', 'dd MMM yyyy'],
                  ),
                  _dropdown(
                    'Time Format',
                    'timeFormat',
                    _settings['timeFormat'],
                    ['HH:mm', 'hh:mm a', 'hh:mm'],
                  ),
                ]),

                // Notifications
                _section('Notifications', Icons.notifications, [
                  _switch('Enable Notifications', 'notifications', _settings['notifications']),
                  _switch('Email Notifications', 'emailNotifications', _settings['emailNotifications']),
                ]),

                // Inventory
                _section('Inventory', Icons.inventory, [
                  _switch('Low Stock Alerts', 'lowStockAlert', _settings['lowStockAlert']),
                  _slider(
                    'Low Stock Threshold',
                    'lowStockThreshold',
                    _settings['lowStockThreshold'].toDouble(),
                    5,
                    100,
                  ),
                ]),

                // Financial
                _section('Financial', Icons.attach_money, [
                  _textField('Tax Rate (%)', 'taxRate', _settings['taxRate'].toString()),
                  _textField('Invoice Terms', 'invoiceTerms', _settings['invoiceTerms']),
                ]),

                // Appearance
                _section('Appearance', Icons.palette, [
                  _dropdown(
                    'Theme',
                    'theme',
                    _settings['theme'],
                    ['Light', 'Dark', 'System'],
                  ),
                ]),

                // Actions
                _section('Actions', Icons.build, [
                  _actionTile('Backup Data', Icons.backup, () {}),
                  _actionTile('Restore Data', Icons.restore, () {}),
                  _actionTile('Clear Cache', Icons.delete, () {}, color: const Color(0xFFE74C3C)),
                ]),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () => widget.onSave?.call(),
                    icon: const Icon(Icons.save),
                    label: const Text('Save Settings'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3498DB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF3498DB)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        ...children,
      ],
    );
  }

  Widget _textField(String label, String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: (v) => setState(() => _settings[key] = v),
      ),
    );
  }

  Widget _dropdown(String label, String key, String value, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map((o) => DropdownMenuItem(value: o, child: Text(o)))
            .toList(),
        onChanged: (v) => setState(() => _settings[key] = v),
      ),
    );
  }

  Widget _switch(String label, String key, bool value) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: (v) => setState(() => _settings[key] = v),
    );
  }

  Widget _slider(String label, String key, double value, double min, double max) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ${value.toInt()}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C3E50),
              )),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            onChanged: (v) => setState(() => _settings[key] = v.toInt()),
          ),
        ],
      ),
    );
  }

  Widget _actionTile(String title, IconData icon, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? const Color(0xFF3498DB)),
      title: Text(title),
      onTap: onTap,
    );
  }
}