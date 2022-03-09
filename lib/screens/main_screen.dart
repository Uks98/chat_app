import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../config/palette.dart';
import 'chat_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance; //사용자 등록이나 로그인 가능하게 만드는 함수 생성 가능케함

  String userName = "";
  String userEmail = "";
  String userPassWord = "";

  bool isSignupScreen = true;
  bool showSpinner = false;
  //모든 텍스트 필드에 밸리데이션 기능 추가하는 GlobalKey
  final _formKey = GlobalKey<FormState>();

  // 사용자가 텍스트 폼 필드에 입력한 정보의 유효성을 확인하기 위한 함수
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save(); // 폼 전체 state 저장하게 됨
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //     image: AssetImage('image/fall.jpg'), fit: BoxFit.fill),
                        ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 90, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: 'Welcome',
                                  style: const TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                  children: [
                                TextSpan(
                                    text: isSignupScreen
                                        ? ' to Uks Chat!'
                                        : ' back',
                                    style: const TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ])),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            isSignupScreen
                                ? 'sighup to continue'
                                : 'sign In continue',
                            style: const TextStyle(
                                letterSpacing: 1.0, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )),
              //배경
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: 180,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    padding: const EdgeInsets.all(20.0),
                    height: isSignupScreen ? 280 : 250,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15.0,
                              spreadRadius: 5),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSignupScreen = false;
                        });
                      },
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: !isSignupScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1),
                                    ),
                                    if (!isSignupScreen)
                                      Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          width: 55,
                                          height: 2,
                                          color: Colors.orange)
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = true;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSignupScreen
                                                ? Palette.activeColor
                                                : Palette.textColor1),
                                      ),
                                      if (isSignupScreen)
                                        Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          width: 55,
                                          height: 2,
                                          color: Colors.orange,
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            if (isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 3) {
                                              return "Please enter at last 4 characters";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userName = value!;
                                          },
                                          onChanged: (value) {
                                            userName = value;
                                          },
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.account_circle,
                                                color: Palette.iconColor,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Palette.textColor1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(35.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Palette.textColor1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(35.0))),
                                              hintText: 'user name',
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Palette.textColor1),
                                              contentPadding: EdgeInsets.all(10)),
                                          key: const ValueKey(5),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          key: const ValueKey(1),
                                          //유효성 검사
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !value.contains("@")) {
                                              return "Please enter at last 4 characters";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userEmail = value!;
                                          },
                                          onChanged: (value) {
                                            userEmail = value;
                                          },
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Palette.iconColor,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Palette.textColor1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      const Radius.circular(
                                                          35.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Palette.textColor1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      const Radius.circular(
                                                          35.0))),
                                              hintText: 'User Email',
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Palette.textColor1),
                                              contentPadding:
                                                  const EdgeInsets.all(10)),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          key: const ValueKey(2),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 4) {
                                              return "비밀번호를 확인해주세요.";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userPassWord = value!;
                                          },
                                          onChanged: (value) {
                                            userPassWord = value;
                                          },
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.password,
                                                color: Palette.iconColor,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Palette.textColor1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(35.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Palette.textColor1,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(35.0))),
                                              hintText: 'password',
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Palette.textColor1),
                                              contentPadding: EdgeInsets.all(10)),
                                        )
                                      ],
                                    )),
                              ),
                            if (!isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        key: const ValueKey(3),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return "Password must ve at least 8 characters long.";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userEmail = value!;
                                        },
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Palette.textColor1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Palette.textColor1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    const Radius.circular(35.0))),
                                            hintText: 'User Email',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        key: const ValueKey(4),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return "Please enter at last 4 characters";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userPassWord = value!;
                                        },
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.password_outlined,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Palette.textColor1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    const Radius.circular(35.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Palette.textColor1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    const Radius.circular(35.0))),
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Palette.textColor1),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  )),
              //텍스트 폼 필드
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? 430 : 390,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: isSignupScreen ? Colors.white : Colors.brown[100],
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: () async {
                        if (isSignupScreen) {
                          setState(() {
                            showSpinner = true;
                          });
                          _tryValidation();
                          try {
                            final newUser = await _authentication
                                .createUserWithEmailAndPassword(
                              email: userEmail,
                              password: userPassWord,
                            );

                            await FirebaseFirestore.instance
                                .collection("user")
                                .doc(newUser.user!.uid)
                                .set({
                              "userName": userName,
                              "email": userEmail,
                            }); //파이어베이스에 user 라는 컬렉션에 name,email argument 생성

                            if (newUser.user != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen()));
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (error) {
                            print(error);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("이메일이나 패스워드를 확인해주세요."),
                              backgroundColor: Colors.blue,
                            ));
                          }
                        }
                        if (!isSignupScreen) {
                          setState(() {
                            showSpinner = true;
                          });
                          _tryValidation();
                          try {
                            final newUser =
                                await _authentication.signInWithEmailAndPassword(
                              email: userEmail,
                              password: userPassWord,
                            );
                            if (newUser.user != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen()));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (error) {
                            print(error);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("이메일이나 패스워드를 확인해주세요."),
                              backgroundColor: Colors.blue,
                            ));
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Colors.red, Colors.amber],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 4))
                            ]),
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ),
              ),
              //전송버튼
              AnimatedPositioned(
                  top: isSignupScreen
                      ? MediaQuery.of(context).size.height - 125
                      : MediaQuery.of(context).size.height - 165,
                  right: 0,
                  left: 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child: Column(
                    children: [
                      Text(isSignupScreen ? 'or Signup With' : 'or SignIn With'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Google'),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            maximumSize: const Size(155, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Palette.googleColor),
                      )
                    ],
                  )),
              //구글 로그인 버튼
            ],
          ),
        ),
      ),
    );
  }
}
