import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // clip screen in half and fill top half with black colout
          // or background image
          ClipPath(
            child: Container(
              color: Colors.black.withOpacity(0.8),
            ),
            clipper: GetClipper(),
          ),
          //  Because this is a stack, we can use a
          //  position widget to position the next item
          //  (image) where we want it.
          Positioned(
            width: 350.0,
            /* Note the use of "MediaQuery.of(context).size"
            * to get dimension of screen */
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/profile_pic.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)
                      ),
                      boxShadow: [BoxShadow(blurRadius: 7.5, color: Colors.black)]
                  ),
                ),
                SizedBox(height: 90.0,),
                Text(
                  'Kawhi Leonard',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'
                  ),
                ),
                SizedBox(height: 15.0,),
                Text(
                  'Subscribe guys',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Raleway'
                  ),
                ),
                SizedBox(height: 25.0,),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: (){},
                      child: Center(
                        child: Text(
                          'Edit Name',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway'
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.red,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: (){},
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway'
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class GetClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

