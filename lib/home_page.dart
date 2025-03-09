import 'package:flutter/material.dart';

class TemperatureCalculatorScreen extends StatefulWidget {
  const TemperatureCalculatorScreen({super.key});

  @override
  State<TemperatureCalculatorScreen> createState() => _TemperatureCalculatorScreenState();
}

class _TemperatureCalculatorScreenState extends State<TemperatureCalculatorScreen> {
  double _inputTemperature = 0;
  double _result = 0;
  String _selectedFromUnit = 'Celsius';
  String _selectedToUnit = 'Fahrenheit';
  final _temperatureController = TextEditingController();
  
  final List<String> _temperatureUnits = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
    'Reamur'
  ];

  void _calculateTemperature() {
    setState(() {
      _inputTemperature = double.tryParse(_temperatureController.text) ?? 0;
      
      // First convert to Celsius as base unit
      double tempInCelsius;
      
      switch (_selectedFromUnit) {
        case 'Celsius':
          tempInCelsius = _inputTemperature;
          break;
        case 'Fahrenheit':
          tempInCelsius = (_inputTemperature - 32) * 5 / 9;
          break;
        case 'Kelvin':
          tempInCelsius = _inputTemperature - 273.15;
          break;
        case 'Reamur':
          tempInCelsius = _inputTemperature * 5 / 4;
          break;
        default:
          tempInCelsius = _inputTemperature;
      }
      
      // Then convert from Celsius to target unit
      switch (_selectedToUnit) {
        case 'Celsius':
          _result = tempInCelsius;
          break;
        case 'Fahrenheit':
          _result = (tempInCelsius * 9 / 5) + 32;
          break;
        case 'Kelvin':
          _result = tempInCelsius + 273.15;
          break;
        case 'Reamur':
          _result = tempInCelsius * 4 / 5;
          break;
        default:
          _result = tempInCelsius;
      }
    });
  }

  String _getFormula() {
    if (_selectedFromUnit == _selectedToUnit) {
      return 'Sama';
    }
    
    switch('${_selectedFromUnit}_$_selectedToUnit') {
      case 'Celsius_Fahrenheit':
        return '°F = (°C × 9/5) + 32';
      case 'Celsius_Kelvin':
        return 'K = °C + 273.15';
      case 'Celsius_Reamur':
        return '°R = °C × 4/5';
      case 'Fahrenheit_Celsius':
        return '°C = (°F - 32) × 5/9';
      case 'Fahrenheit_Kelvin':
        return 'K = (°F - 32) × 5/9 + 273.15';
      case 'Fahrenheit_Reamur':
        return '°R = (°F - 32) × 4/9';
      case 'Kelvin_Celsius':
        return '°C = K - 273.15';
      case 'Kelvin_Fahrenheit':
        return '°F = (K - 273.15) × 9/5 + 32';
      case 'Kelvin_Reamur':
        return '°R = (K - 273.15) × 4/5';
      case 'Reamur_Celsius':
        return '°C = °R × 5/4';
      case 'Reamur_Fahrenheit':
        return '°F = (°R × 9/4) + 32';
      case 'Reamur_Kelvin':
        return 'K = (°R × 5/4) + 273.15';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Classic color palette
    final Color primaryColor = const Color(0xFF4A4A4A);
    final Color accentColor = const Color(0xFFBF9456);
    final Color backgroundLight = const Color(0xFFF8F5F2);
    final Color textDark = const Color(0xFF333333);
    final Color cardBg = Colors.white;
    
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Kalkulator Suhu',
          style: TextStyle(
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        color: backgroundLight,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ornamental Divider
              Row(
                children: [
                  Expanded(child: Divider(color: primaryColor.withOpacity(0.3), thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.thermostat, color: accentColor, size: 28),
                  ),
                  Expanded(child: Divider(color: primaryColor.withOpacity(0.3), thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              
              // Input card
              Card(
                elevation: 4,
                shadowColor: primaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: accentColor.withOpacity(0.5), width: 1),
                ),
                color: cardBg,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Input Suhu',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Masukkan nilai yang ingin dikonversi',
                        style: TextStyle(
                          fontSize: 14,
                          color: textDark.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _temperatureController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 16,
                          color: textDark,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Nilai Suhu',
                          labelStyle: TextStyle(color: primaryColor.withOpacity(0.7)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: accentColor, width: 2),
                          ),
                          filled: true,
                          fillColor: cardBg,
                          prefixIcon: Icon(Icons.science_outlined, color: accentColor),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Unit selection
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dari', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: _selectedFromUnit,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: accentColor, width: 2),
                                    ),
                                    filled: true,
                                    fillColor: cardBg,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  dropdownColor: cardBg,
                                  style: TextStyle(color: textDark, fontSize: 15),
                                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                                  items: _temperatureUnits.map((String unit) {
                                    return DropdownMenuItem<String>(
                                      value: unit,
                                      child: Text(unit),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedFromUnit = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              Icons.compare_arrows,
                              color: accentColor,
                              size: 28
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ke', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: _selectedToUnit,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: accentColor, width: 2),
                                    ),
                                    filled: true,
                                    fillColor: cardBg,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  dropdownColor: cardBg,
                                  style: TextStyle(color: textDark, fontSize: 15),
                                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                                  items: _temperatureUnits.map((String unit) {
                                    return DropdownMenuItem<String>(
                                      value: unit,
                                      child: Text(unit),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedToUnit = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Convert button with classic styling
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _calculateTemperature,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: accentColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Konversi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Ornamental Divider
              Row(
                children: [
                  Expanded(child: Divider(color: primaryColor.withOpacity(0.3), thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.analytics_outlined, color: accentColor, size: 28),
                  ),
                  Expanded(child: Divider(color: primaryColor.withOpacity(0.3), thickness: 1)),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Result card with classic styling
              Card(
                elevation: 4,
                shadowColor: primaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: accentColor.withOpacity(0.5), width: 1),
                ),
                color: cardBg,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hasil Konversi',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Classic-styled result display
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, Color(0xFF333333)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: accentColor.withOpacity(0.7),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _result.toStringAsFixed(2),
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                _selectedToUnit,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Classic-styled formula display
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: backgroundLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primaryColor.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.auto_stories, color: accentColor, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Formula Konversi',
                                  style: TextStyle(
                                    fontFamily: 'Serif',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: accentColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _getFormula(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Classic footer with a simple decorative element
              Center(
                child: SizedBox(
                  width: 150,
                  child: Divider(
                    color: accentColor,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                ),
              ),
              
              // Add a small ornament at the bottom
              Center(
                child: Icon(
                  Icons.brightness_1,
                  size: 12,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}