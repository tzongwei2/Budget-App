import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return Scaffold(
         body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                const SizedBox(height:190),
                Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white, // Optional: Set container background color
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                  'assets/owl.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                ),),
                const Text("Track Money, Save Money"),
                const SizedBox(height:100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'continue with',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height:25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      login_logo(imagePath: 'assets/google.png'),
                      const SizedBox(width:25),
                      login_logo(imagePath: 'assets/facebook.png'),
                    ]
                  ),
              ]
            ),
          ),
    );
  }
}

Widget login_logo({required String imagePath,}) {
  return InkWell(
    onTap: (){},
    child: Container(
      width: 90,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    ),
  );
}