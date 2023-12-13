import 'package:flutter/material.dart';
import 'package:planetcombo/common/widgets.dart';
import 'package:planetcombo/screens/dashboard.dart';
import 'package:planetcombo/controllers/localization_controller.dart';
import 'package:get/get.dart';
import 'package:planetcombo/screens/messages/add_message.dart';
import 'package:planetcombo/screens/messages/reply_message.dart';
import 'package:planetcombo/screens/messages/view_history.dart';
import 'package:planetcombo/controllers/applicationbase_controller.dart';
import 'package:planetcombo/controllers/message_controller.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {

  final ApplicationBaseController applicationBaseController =
  Get.put(ApplicationBaseController.getInstance(), permanent: true);


  final MessageController messageController =
  Get.put(MessageController.getInstance(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.chevron_left_rounded),),
        title: LocalizationController.getInstance().getTranslatedValue("All Messages"),
        colors: const [Color(0xFFf2b20a), Color(0xFFf34509)], centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
                  (Route<dynamic> route) => false,
            );
          }, icon: const Icon(Icons.home_outlined))
        ],
      ),
      body: applicationBaseController.messagesHistory.isEmpty ? Center(
        child: SizedBox( width : 280, child: commonText(textAlign: TextAlign.center, color: Colors.grey , text: 'To add message please click on add message button')),
      ) :
      Obx(() => ListView.builder(
        itemCount: applicationBaseController.messagesHistory.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black26,
                        width: 0.5
                    )
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonBoldText(text: 'Horoscope Name : ${applicationBaseController.messagesHistory[index].horoname}'),
                SizedBox(height: 5),
                commonText(text: 'Waiting for agent to reply', color: Colors.black54, fontSize: 13),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width:100, child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("Reply"), buttonHeight: 30, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ReplyMessages(messageInfo : applicationBaseController.messagesHistory[index])));
                    })),
                    SizedBox(width:100, child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("Delete"), buttonHeight: 30, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset){
                      yesOrNoDialog(
                        context: context,
                        dialogMessage: 'Do you want to delete this Message ?',
                        cancelText: 'No',
                        okText: 'Yes',
                        okAction: () async{
                          Navigator.pop(context);
                          var response = await messageController.deleteMessage(context, applicationBaseController.messagesHistory[index].msgmessageid!.replaceAll(' ', ''), applicationBaseController.messagesHistory[index].msghid!.replaceAll(' ', ''), applicationBaseController.messagesHistory[index].msguserid);
                        },
                      );
                    })),
                    SizedBox(width:135, child: GradientButton(title: LocalizationController.getInstance().getTranslatedValue("View History"), buttonHeight: 30, textColor: Colors.white, buttonColors: const [Color(0xFFf2b20a), Color(0xFFf34509)], onPressed: (Offset buttonOffset){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>  ViewHistory(messageHistory : applicationBaseController.messagesHistory[index])));
                    })),
                  ],
                ),
              ],
            ),
          );
        },
      )),
      floatingActionButton: GradientFloatingActionButton(
        onPressed: () {
          // Add your message code here
          print('Message');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AddMessages()));
        },
        gradient: const LinearGradient(
          colors: [Color(0xFFf2b20a), Color(0xFFf34509)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child:
        Column(
          children: [
            SizedBox(height: 14),
            commonBoldText(text: 'Add', color: Colors.white, fontSize: 12),
            commonText(text: 'Message', color: Colors.white70, fontSize: 9)
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


class GradientFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Gradient gradient;

  GradientFloatingActionButton({
    required this.onPressed,
    required this.child,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        child: child,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}