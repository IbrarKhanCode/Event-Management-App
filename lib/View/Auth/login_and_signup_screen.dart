import 'package:flutter/material.dart';

class LoginAndSignupScreen extends StatefulWidget {
  const LoginAndSignupScreen({super.key});

  @override
  State<LoginAndSignupScreen> createState() => _LoginAndSignupScreenState();
}

class _LoginAndSignupScreenState extends State<LoginAndSignupScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  String _headerText = 'Login';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_updateHeaderText);
  }

  void _updateHeaderText(){
    setState(() {
      _headerText = _tabController.index == 0 ? 'Login' : 'Sign In';
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateHeaderText);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          SizedBox(height: 50,),
          Text(_headerText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
          SizedBox(height: 50,),

        ],
      ),
    );
  }
}
