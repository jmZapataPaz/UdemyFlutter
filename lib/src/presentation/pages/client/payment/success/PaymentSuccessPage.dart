import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage>
    with TickerProviderStateMixin {
  
  late AnimationController _checkController;
  late AnimationController _textController;
  late AnimationController _buttonController;
  late AnimationController _backgroundController;
  
  late Animation<double> _checkAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<Color?> _colorAnimation;

  AuthResponse? _authResponse;

  @override
  void initState() {
    super.initState();
    _recoverSession();
    _setupAnimations();
    _startAnimations();
  }

  Future<void> _recoverSession() async {
    final sharedPref = SharedPref();
    final userSession = await sharedPref.read('user');
    if (userSession != null) {
      setState(() {
        _authResponse = AuthResponse.fromJson(userSession);
      });
      print('Usuario recuperado en PaymentSuccessPage: ${_authResponse?.user.email}');
    } else {
      print('No hay sesión de usuario guardada');
    }
  }

  void _setupAnimations() {
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _checkAnimation = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutBack,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _buttonAnimation = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.bounceOut,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: const Color(0xFFF8F9FA),
    ).animate(_backgroundController);
  }

  void _startAnimations() async {
    _backgroundController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    _checkController.forward();
    
    await Future.delayed(const Duration(milliseconds: 400));
    _textController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _checkController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _colorAnimation.value!,
                  Colors.green.withOpacity(0.1),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    _buildAnimatedCheck(),
                    const SizedBox(height: 40),
                    _buildAnimatedTitle(),
                    const SizedBox(height: 16),
                    _buildAnimatedSubtitle(),
                    const SizedBox(height: 40),
                    _buildOrderInfo(),
                    const Spacer(),
                    _buildAnimatedButtons(context),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedCheck() {
    return ScaleTransition(
      scale: _checkAnimation,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(_textAnimation),
      child: FadeTransition(
        opacity: _textAnimation,
        child: const Text(
          '¡Pago Completado!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(_textAnimation),
      child: FadeTransition(
        opacity: _textAnimation,
        child: const Text(
          'Tu pedido ha sido procesado exitosamente.\n¡Gracias por tu compra!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return FadeTransition(
      opacity: _textAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            _buildInfoRow('Número de Orden:', '#ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}'),
            const SizedBox(height: 12),
            _buildInfoRow('Fecha:', _formatDate(DateTime.now())),
            const SizedBox(height: 12),
            _buildInfoRow('Estado:', 'Confirmado'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedButtons(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(_buttonAnimation),
      child: FadeTransition(
        opacity: _buttonAnimation,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                Navigator.popUntil(context, (route) {
                  return route.settings.name == 'client/home' || route.isFirst;
                });
                
                if (ModalRoute.of(context)?.settings.name != 'client/home') {
                  Navigator.pushReplacementNamed(context, 'client/home');
                }
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.green.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Volver al Inicio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}