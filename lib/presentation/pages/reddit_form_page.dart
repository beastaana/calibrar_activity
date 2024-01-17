import 'package:calibrar_activity/logic/bloc/reddit/reddit_form_bloc.dart';
import 'package:calibrar_activity/presentation/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedditFormPage extends StatefulWidget {
  const RedditFormPage({Key? key}) : super(key: key);

  @override
  State<RedditFormPage> createState() => _RedditFormPageState();
}

class _RedditFormPageState extends State<RedditFormPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const CustomText(text: 'title'),
              TextFormField(controller: _title),
              const CustomText(text: 'description'),
              TextFormField(controller: _description),
              BlocBuilder<RedditFormBloc, RedditFormState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        if (_title.text.isNotEmpty &&
                            _description.text.isNotEmpty) {
                          DateTime now = DateTime.now();
                          DateTime currentDate = DateTime(now.year, now.month, now.day);    
                          context.read<RedditFormBloc>().add(
                            AddRedditPost(
                              id: 22,
                              title: _title.text,
                              subtitle: _description.text, 
                              date: currentDate.toString(), 
                              isDeleted: false,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("Your post is added successfully"),
                              )
                          );
                          context.read<RedditFormBloc>().add(const FetchRedditPosts());
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Title and description fields must not be blank"
                                    .toUpperCase()),
                          ));
                        }
                      },
                      child: const Text('Add Post'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}