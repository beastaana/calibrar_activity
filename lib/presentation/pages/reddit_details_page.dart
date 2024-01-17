import 'package:calibrar_activity/logic/bloc/reddit/reddit_form_bloc.dart';
import 'package:calibrar_activity/logic/constants/constants.dart';
import 'package:calibrar_activity/logic/model/reddit_model.dart';
import 'package:calibrar_activity/presentation/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedditDetailsPage extends StatefulWidget {
  const RedditDetailsPage({Key? key}) : super(key: key);

  @override
  State<RedditDetailsPage> createState() => _RedditDetailsPageState();
}

class _RedditDetailsPageState extends State<RedditDetailsPage> {
  final TextEditingController _newTitle = TextEditingController();
  final TextEditingController _newDescription = TextEditingController();
  bool toggleSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            context.read<RedditFormBloc>().add(const FetchRedditPosts());
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<RedditFormBloc, RedditFormState>(
          builder: (context, state) {
            if (state is DisplaySpecificRedditPost) {
              RedditModel currentPost = state.data;

              return Column(
                children: [
                  CustomText(text: 'title'.toUpperCase()),
                  const SizedBox(height: 10),
                  TextFormField(
                      initialValue: currentPost.title, enabled: false),
                  const SizedBox(height: 10),
                  CustomText(text: 'description'.toUpperCase()),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: currentPost.subtitle,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  CustomText(text: 'date made'.toUpperCase()),
                  const SizedBox(height: 10),
                  CustomText(
                      text: state.data.date),
                  const SizedBox(height: 10),
                  CustomText(text: 'important / not important'.toUpperCase()),
                  const SizedBox(height: 10),
                  CustomText(
                      text: (state.data.subtitle)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext cx) {
                              return StatefulBuilder(
                                builder: ((context, setState) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Update Todo',
                                      style: TextStyle(
                                          fontSize: 25,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('Title')),
                                        Flexible(
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              isDense: true,
                                            ),
                                            maxLines: 1,
                                            controller: _newTitle,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('Description')),
                                        Flexible(
                                          child: TextFormField(
                                            controller: _newDescription,
                                            decoration: const InputDecoration(
                                              isDense: true,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                                'Important / Not Important'),
                                            Switch(
                                              value: toggleSwitch,
                                              onChanged: (newVal) {
                                                setState(() {
                                                  toggleSwitch = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: Constants.customButtonStyle,
                                        onPressed: () {
                                          Navigator.pop(cx);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        style: Constants.customButtonStyle,
                                        onPressed: () async {
                                          final currentTime = DateTime.now();
                                          context.read<RedditFormBloc>().add(
                                                UpdateRedditPost(
                                                  redditModel: RedditModel(
                                                    id: currentPost.id,
                                                    title: _newTitle.text,
                                                    subtitle: _newDescription.text,
                                                    date: currentTime.toString(),
                                                    isDeleted: false,
                                                  ),
                                                ),
                                              );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor:
                                                Constants.primaryColor,
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('Todo details updated'),
                                          ));
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                          context
                                              .read<RedditFormBloc>()
                                              .add(const FetchRedditPosts());
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            });
                      },
                      child: const Text('Update'))
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}