import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'select_category_page.dart';

class InputDataPage extends StatefulWidget {
  const InputDataPage({super.key});

  @override
  State<InputDataPage> createState() => _InputDataPageState();

  static void clearControllers() {
    _InputDataPageState.nameController.clear();
    _InputDataPageState.dniController.clear();
    _InputDataPageState.emailController.clear();
    _InputDataPageState.phoneController.clear();
    _InputDataPageState.ageController.clear();
  }
}

class _InputDataPageState extends State<InputDataPage> {
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController dniController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signInAnonymously();
  }

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      debugPrint('Error al iniciar sesión anónima: $e');
    }
  }

  void goToSelectCategory() {
    final name = nameController.text.trim();
    final dni = dniController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final age = ageController.text.trim();

    if (name.isEmpty ||
        dni.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        age.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('COMPLETE SUS DATOS')));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectCategoryPage(
          nombre: name,
          dni: dni,
          email: email,
          telefono: phone,
          edad: age,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async => false, // Bloquea el botón de retroceso
          child: Scaffold(
            backgroundColor: const Color(0xFFF2F2F2),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF2F2F2),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'COMPLETE SUS DATOS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7F94),
                      ),
                    ),
                    const SizedBox(height: 0.1),
                    Container(
                      height: 2,
                      width: 200,
                      color: const Color(0xFF2E7F94),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre y Apellido:',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 94, 94, 94),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF2E7F94),
                      style: const TextStyle(color: Color(0xFF2E7F94)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Edad:',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 94, 94, 94),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF2E7F94),
                      style: const TextStyle(color: Color(0xFF2E7F94)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: dniController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'DNI:',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 94, 94, 94),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF2E7F94),
                      style: const TextStyle(color: Color(0xFF2E7F94)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email:',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 94, 94, 94),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF2E7F94),
                      style: const TextStyle(color: Color(0xFF2E7F94)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Teléfono:',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 94, 94, 94),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      cursorColor: const Color(0xFF2E7F94),
                      style: const TextStyle(color: Color(0xFF2E7F94)),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: goToSelectCategory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7F94),
                          foregroundColor: const Color(0xFFF2F2F2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          side: const BorderSide(
                            color: Color(0xFF2E7F94),
                            width: 2.0,
                          ),
                          elevation: 5,
                          shadowColor: Colors.grey,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize
                              .min, // Esto asegura que la fila solo ocupe el espacio necesario
                          children: [
                            Text('Siguiente'),
                            SizedBox(
                              width: 8,
                            ), // Agrega un pequeño espacio entre el texto y el icono
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // La imagen se posiciona en la parte inferior del Stack.
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/icon/icono-muni/base.png', // No olvides reemplazar esta ruta
            fit: BoxFit.cover, // Esto asegura que la imagen cubra el área
          ),
        ),
      ],
    );
  }
}