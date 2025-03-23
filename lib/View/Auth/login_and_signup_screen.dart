import 'package:event_management_app/View/Widgets/login_widget.dart';
import 'package:event_management_app/View/Widgets/signup_widget.dart';
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
      _headerText = _tabController.index == 0 ? 'Login' : 'Sign Up';
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
          SizedBox(height: 80,),
          Center(child: Text(_headerText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 25),)),
          SizedBox(height: 50,),
          SizedBox(
            height: 50,
            width: 200,
            child: TabBar(
              controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelStyle: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w500),
                labelStyle: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w500),
                tabs: [
                  Tab(child: Text('Login'),),
                  Tab(child: Text('Sign Up'),),
                ]
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: [
                    LoginWidget(),
                    SignupWidget(),
                ]
            ),
          ),

        ],
      ),
    );
  }
}
