import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:flutter/material.dart';

class ProfileInfoContent extends StatelessWidget {

  User? user;
  ProfileInfoContent(this.user);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        _imageBackground(context),
        Column(
          children: [
            _imageProfile(context),
            Spacer(),
            _cardProfileInfo(context)
          ],
        )
      ],
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background3.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _imageProfile(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.only(top: screenWidth * (isTablet ? 0.15 : 0.25)),
      width: screenWidth * (isTablet ? 0.40 : 0.4),
      child: AspectRatio(
        aspectRatio: 1/1,
        child: ClipOval(
          child: user !=null ? FadeInImage.assetNetwork(
            placeholder: 'assets/img/user_image.png', 
            image: user!.image!,
            fit: BoxFit.cover,
            fadeInDuration: Duration(seconds: 1),
          )
          :Container(),
        ),
      ),
    );
  }

  Widget _cardProfileInfo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), 
          topRight: Radius.circular(35)
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * (isTablet ? 0.1 : 0.04),
          vertical: screenWidth * (isTablet ? 0.05 : 0.04),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: screenWidth * (isTablet ? 0.005 : 0.002),
                ),
                title: Text(
                  '${user?.name ?? ''} ${user?.lastname ?? ''}',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.03 : 0.045),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Nombre de Usuario',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.025 : 0.035),
                  ),
                ),
                leading: Icon(
                  Icons.person, 
                  color: Colors.black,
                  size: screenWidth * (isTablet ? 0.04 : 0.06),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: screenWidth * (isTablet ? 0.005 : 0.002),
                ),
                title: Text(
                  user?.email ?? '',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.03 : 0.045),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Correo del Usuario',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.025 : 0.035),
                  ),
                ),
                leading: Icon(
                  Icons.email, 
                  color: Colors.black,
                  size: screenWidth * (isTablet ? 0.04 : 0.06),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: screenWidth * (isTablet ? 0.005 : 0.002),
                ),
                title: Text(
                  user?.phone ?? '',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.03 : 0.045),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Teléfono del Usuario',
                  style: TextStyle(
                    fontSize: screenWidth * (isTablet ? 0.025 : 0.035),
                  ),
                ),
                leading: Icon(
                  Icons.phone, 
                  color: Colors.black,
                  size: screenWidth * (isTablet ? 0.04 : 0.06),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  bottom: screenWidth * (isTablet ? 0.03 : 0.02),
                ),
                child: SizedBox(
                  width: screenWidth * (isTablet ? 0.12 : 0.15),
                  height: screenWidth * (isTablet ? 0.12 : 0.15),
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: (){
                      Navigator.pushNamed(context, 'profile/update', arguments: user);
                    },
                    child: Icon(
                      Icons.edit, 
                      color: Colors.white,
                      size: screenWidth * (isTablet ? 0.05 : 0.06),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}