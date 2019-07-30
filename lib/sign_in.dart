import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);

//  assert(!user.isAnonymous);
//  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
//  assert(user.uid == currentUser.uid);

//  assert(user.email != null);
//  assert(user.displayName != null);
//  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  return 'signInWithGoogle succeeded: $user';
}


void signOutGoogle() async{

  await googleSignIn.signOut();

  print("User Sign Out");
}

Future<FacebookLoginResult> _handleFBSignIn() async {
  FacebookLogin facebookLogin = FacebookLogin();
  FacebookLoginResult facebookLoginResult =
  await facebookLogin.logInWithReadPermissions(['email']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.cancelledByUser:
      print("Cancelled");
      break;
    case FacebookLoginStatus.error:
      print("error");
      break;
    case FacebookLoginStatus.loggedIn:
      print("Logged In");
      break;
  }
  return facebookLoginResult;
}

Future<String> signInWithFacebook1() async {
//  Scaffold.of(context).showSnackBar(new SnackBar(
//    content: new Text('Sign in button clicked'),
//  ));
  FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
  final accessToken = facebookLoginResult.accessToken.token;
  if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
    final facebookAuthCred =
    FacebookAuthProvider.getCredential(accessToken: accessToken);
    final user = await _auth.signInWithCredential(facebookAuthCred);


    name = "tomek";
    email = "mail";
    imageUrl = "image";

    return 'signInWithFacebook succeeded: $user';

//  final FacebookLoginResult result =
//  await facebookSignIn.logInWithReadPermissions(['email']);
//
//  FirebaseUser user =
//  await _auth.signInWithFacebook(accessToken: result.accessToken.token);
//  //Token: ${accessToken.token}
//
//  ProviderDetails userInfo = new ProviderDetails(
//      user.providerId, user.uid, user.displayName, user.photoUrl, user.email);
//
//  List<ProviderDetails> providerData = new List<ProviderDetails>();
//  providerData.add(userInfo);
//
//  UserInfoDetails userInfoDetails = new UserInfoDetails(
//      user.providerId,
//      user.uid,
//      user.displayName,
//      user.photoUrl,
//      user.email,
//      user.isAnonymous,
//      user.isEmailVerified,
//      providerData);
//
//  Navigator.push(
//    context,
//    new MaterialPageRoute(
//      builder: (context) => new DetailedScreen(detailsUser: userInfoDetails),
//    ),
//  );

//  return user;
  }
}



