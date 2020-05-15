import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/entitys/chatmsg.dart';
import 'package:graduation/utils/screen.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  String to_userId;
  String userId;
  String headImg;

  ChatPage({this.userId, this.to_userId, this.headImg});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IOWebSocketChannel channel;
  TextEditingController _controller = TextEditingController();
  List<Chatmsg> _listmsg = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //创建websocket连接
    channel = IOWebSocketChannel.connect(
        'ws://192.168.42.71:5000/ws/' + widget.userId);
    _receivedMessage();
  }

  void _sendMessage() {
    Chatmsg msg = Chatmsg(
        to_user: widget.to_userId,
        msg: _controller.value.text.toString(),
        headImg: widget.headImg);
    setState(() {
      _listmsg.add(msg);
    });
    channel.sink.add(jsonEncode(msg.toJosn()));
  }

  void _receivedMessage() {
    channel.stream.listen((message) {
      if (message != null) {
        var msg = Chatmsg.fromJson(jsonDecode(message));
        setState(() {
          _listmsg.add(msg);
        });
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: duSetHeight(80),
              child: Text(
                "聊天中...",
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _listmsg.length==0?Container():ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: _listmsg[index].to_user == widget.userId
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: FSuper(
                        maxWidth: 220,
                        text: _listmsg[index].msg,
                        textAlign: TextAlign.left,
                        padding: EdgeInsets.only(
                            left: 12, right: 12, top: 15, bottom: 15),
                        backgroundColor: _listmsg[index].to_user == widget.userId?Colors.white: Color(0xffa5ed7e),
                        corner: Corner.all(6),
                        child1: Transform.rotate(
                          angle: pi / 4,
                          child: FSuper(
                            width: 10,
                            height: 10,
                            backgroundColor: _listmsg[index].to_user == widget.userId?Colors.white: Color(0xffa5ed7e),
                            corner: Corner.all(1.5),
                          ),
                        ),
                        child1Alignment:_listmsg[index].to_user == widget.userId?Alignment.topLeft: Alignment.topRight,
                        child1Margin: _listmsg[index].to_user==widget.userId?EdgeInsets.only(left: -4, top: 20):EdgeInsets.only(right: -4, top: 20),
                        shadowColor: Colors.grey,
                        shadowBlur: 5,
                      ),
                    );
                  },
                  itemCount: _listmsg.length,
                  itemExtent: 50.0),
            )),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            FSuper(
              maxHeight: duSetHeight(200),
              height: duSetHeight(150),
              width: MediaQuery.of(context).size.width,
              child1: FSuper(
                maxHeight: duSetHeight(180),
                height: duSetHeight(130),
                width: MediaQuery.of(context).size.width / 5 * 4,
                child1: TextField(
                  controller: _controller,
                  maxLines: 5,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              child1Alignment: Alignment.centerLeft,
              child2: FSuper(
                maxHeight: duSetHeight(180),
                height: duSetHeight(130),
                width: MediaQuery.of(context).size.width / 5,
                child1: Icon(Icons.send),
              ),
              child2Alignment: Alignment.centerRight,
              onChild2Click: () {
                _sendMessage();
              },
            )
          ],
        ),
      )),
    );
  }
}
