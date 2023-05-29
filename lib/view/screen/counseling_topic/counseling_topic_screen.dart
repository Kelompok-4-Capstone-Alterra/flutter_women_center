import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_view_model.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounselingTopicScreen extends StatefulWidget {
  static const String routeName = '/counseling_topic_screen';

  const CounselingTopicScreen({super.key});

  @override
  State<CounselingTopicScreen> createState() => _CounselingTopicScreenState();
}

class _CounselingTopicScreenState extends State<CounselingTopicScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<CounselingTopicViewModel>(context, listen: false);
      provider.getTopics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counseling',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose one of these topics:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Consumer<CounselingTopicViewModel>(
                  builder: (context, provider, _) {
                    switch (provider.myState) {
                      case MyState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      case MyState.loaded:
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: provider.topics.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                provider.setSelectedTopic(
                                    provider.topics[index]['id']);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: (provider.selectedTopic ==
                                        provider.topics[index]['id'])
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: MyColor.primaryMain,
                                      )
                                    : BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(
                                            provider.topics[index]['image']),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        provider.topics[index]['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: (provider.selectedTopic ==
                                                  provider.topics[index]['id'])
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      case MyState.failed:
                        return const Center(
                          child: Text('Failed to load data'),
                        );

                      default:
                        return const Center(
                          child: Text('No data found'),
                        );
                    }
                  },
                ),
              ),
              Consumer<CounselingTopicViewModel>(
                builder: (context, provider, _) {
                  if (provider.selectedTopic == 0) {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: MyColor.neutralLow,
                      ),
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CounselorListScreen.routeName,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyColor.primaryMain,
                        ),
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              // // // button

              //         onTap: () {
              //           Navigator.pushNamed(
              //             context,
              //             CounselorListScreen.routeName,
              //           );
              //         },
              //         child: Container(
              //           width: double.infinity,
              //           height: MediaQuery.of(context).size.height * 0.06,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: MyColor.primaryMain,
              //           ),
              //           child: const Center(
              //             child: Text(
              //               'Continue',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
