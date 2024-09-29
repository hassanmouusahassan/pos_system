import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/main.dart';
 // The screen you want to navigate to after login

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // Adjust the font size and padding based on the screen width
    final double textSize = screenWidth > 600 ? 24 : 16; // Larger text for tablets
    final double titleSize = screenWidth > 600 ? 40 : 32;
    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: screenWidth * 0.1);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: isLandscape ? 2 : 1),
              // App Logo or Title
              Text(
                'Simple POS',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemBlue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome! Manage your store seamlessly.',
                style: TextStyle(
                  fontSize: textSize,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              // Username input
              CupertinoTextField(
                controller: _usernameController,
                placeholder: 'Username',
                padding: EdgeInsets.all(16),
                style: TextStyle(fontSize: textSize, color: Color(0xFF3C3C3C)), // Darker gray for input text
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 20),
              // Password input
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Password',
                obscureText: true,
                padding: EdgeInsets.all(16),
                style: TextStyle(fontSize: textSize, color: Color(0xFF3C3C3C)), // Darker gray for input text
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 40),
              // Login button with dynamic width based on screen size
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: screenWidth > 600 ? 400 : double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [CupertinoColors.activeGreen, CupertinoColors.activeBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Login',
                    style: TextStyle(color: CupertinoColors.white, fontSize: textSize),
                  ),
                  onPressed: () {
                    _navigateWithAnimation(context);
                  },
                ),
              ),
              Spacer(flex: isLandscape ? 2 : 1),
              // Footer text with dynamic font size
              Text(
                'Manage inventory, track sales, and more with Simple POS.',
                style: TextStyle(fontSize: textSize - 2, color: CupertinoColors.systemGrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);  // Slide from bottom to top
          const end = Offset.zero;  // Ends at its natural position
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
