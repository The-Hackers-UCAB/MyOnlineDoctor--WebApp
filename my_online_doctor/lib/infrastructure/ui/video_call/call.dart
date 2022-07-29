import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import './settings.dart';
import 'package:http/http.dart' as http;

class CallPage extends StatefulWidget {

  static const routeName = '/call';

  final String? channelName;
  final ClientRole? role;
  const CallPage({Key? key, this.channelName, this.role}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _inforStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;


  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

   getRtcToken(String channel) async {
    final url = 'https://agora-token-generator-online.herokuapp.com/rtc/'+channel+'/publisher/uid/0';

    try {
      //arreglar esto
      final response = await http.get(Uri.parse(url));
      final token = jsonDecode(response.body);
      return token['rtcToken'];
    }catch (e){
      print('error');
      print(e);
      return '';
    }
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _inforStrings.add(
          'APP_ID IS MISSING',
        );
        _inforStrings.add(
          'AGORA ENGINE IS NOT STARTING',
        );
      });
      return;
    }

    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);

    final tkn = await getRtcToken(widget.channelName!);
    await _engine.joinChannel(tkn, widget.channelName!, null, 0);
  }
    void _addAgoraEventHandlers() {
      _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
        setState(() {
          final info = 'Error $code';
          _inforStrings.add(info);
        });
      },
          joinChannelSuccess: (channel, uid, elapsed) {
            setState(() {
              final info = 'Join Channel: $channel, uid: $uid';
              _inforStrings.add(info);
            });
          },
          leaveChannel: (stats) {
            setState(() {
              _inforStrings.add('Leave Channel');
              _users.clear();
            });
          },
          userJoined: (uid, elapsed) {
            setState(() {
              final info = 'User Joined: $uid';
              _inforStrings.add(info);
              _users.add(uid);
            });
          },
          userOffline: (uid, elapsed) {
            setState(() {
              final info = 'User Offline: $uid';
              _inforStrings.add(info);
              _users.remove(uid);
            });
          },
          firstRemoteVideoFrame: (uid, width, height, elapsed) {
            setState(() {
              final info = 'First Remote Video: $uid ${width}x $height';
              _inforStrings.add(info);
            });
          }
      ));
    }

    Widget _viewRows() {
      final List<StatefulWidget> list = [];
      if (widget.role == ClientRole.Broadcaster) {
        list.add(const rtc_local_view.SurfaceView());
      }
      for (var uid in _users) {
        list.add(rtc_remote_view.SurfaceView(
          uid: uid,
          channelId: widget.channelName!,
        ));
      }
      final views = list;
      return Column(
        children: List.generate(
            views.length, (index) => Expanded(child: views[index])),
      );
    }

    Widget _toolbar() {
    if(widget.role == ClientRole.Audience) return const SizedBox();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
              onPressed: (){
                setState((){
                  muted = !muted;
                });
                _engine.muteLocalAudioStream(muted);
              },
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ?Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
              onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35.0,
                ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
              onPressed: () {
                _engine.switchCamera();
              },
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
    }

    Widget _panel(){
    return Visibility(
      visible: viewPanel,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: ListView.builder(
              reverse: true,
              itemCount: _inforStrings.length,
              itemBuilder: (BuildContext context, int index) {
                if(_inforStrings.isEmpty) {
                  return const Text('null');
                }
                return Padding(padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                          _inforStrings[index],
                            style: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),

                    )
                  ],
                ),
                );
              },
            ),
          ),
        ),

      ),
    );
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Video llamada'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (){
                  setState((){
                    viewPanel = !viewPanel;
                  });
                },
                icon: const Icon(Icons.info_outline),)
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              _viewRows(),
              _panel(),
              _toolbar()
            ],
          ),
        ),
      );
    }
  }
