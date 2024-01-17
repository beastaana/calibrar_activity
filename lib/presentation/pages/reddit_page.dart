import 'package:calibrar_activity/logic/model/reddit_model.dart';
import 'package:calibrar_activity/presentation/pages/reddit_form_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class RedditPage extends StatefulWidget {
  const RedditPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RedditPageState createState() => _RedditPageState();
}

class _RedditPageState extends State<RedditPage> {
  // ignore: prefer_typing_uninitialized_variables
  var jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
      future: getRedditList(),
      builder: (context, data) {

        if (data.hasError) {
          return Center(child: Text("${data.error}"));

        } else if (data.hasData) {
          var items = data.data as List<RedditModel>;
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  items[index].title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Text(items[index].subtitle.toString()),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RedditFormPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
 
  Future<List<RedditModel>> getRedditList() async {
    List<RedditModel> list = [
      const RedditModel(
        id: 0, 
        title: 'YSK Homeopathy and Home Remedy are not the same thing',
        subtitle: 'Why YSK: too many people use these words interchangeably, probably because they both start with home but they do not mean the same thing at all.\nHomeopathy is a practice based on the nonsense belief that diluting an ingredient that produces the same symptoms as the illness until it is undetectable somehow makes it *more* powerful. https://skepdic.com/homeo.html\nHome remedies, on the other hand, are sometimes effective. https://www.webmd.com/balance/ss/slideshow-home-remedies\nSome of them are bullshit, putting an onion in your sock will not do anything for a cold but hot liquids and honey can help alleviate some of the symptoms.\nConsult with your doctor before you try any home remedies, because some of them help, some are nonsense, and some are actually powerful enough to make you sicker or interfere with some medications.\nDont try homeopathy at all, its a waste of time and money.', 
        date: '01/05/2023', 
        isDeleted: false),
      const RedditModel(
        id: 1, 
        title: 'Came across a great opportunity for graduated, underrepresented groups to learn STEM through Google!',
        subtitle: 'I was researching for some programs like this and came across a program specifically for underrepresented students. The link for the program details are as follows\n\nLink for program page:\n\nhttps://techwise.talentsprint.com/\n\nLink for Application page: https://techwise.talentsprint.com/techwise-app.html\n\nUnderrepresented groups with a 4 year college degree can application for this 100% scholarship course. Google provides scholarship to every participant and the course is designed by CMU. Ive already applied and cant wait for the selection process to commence!',
        date: '03/27/2023', 
        isDeleted: false),
      const RedditModel(
        id: 2, 
        title: 'Learn how to sound like a sniffing puppy', 
        subtitle: 'Okay, Ive taught so many ppl this IRL, lets see if it translates here.\n\nClose your mouth. Take a half breath through your nose, as in huff but dont breathe in. Take a half breath out, as in keep the air from that huff in in your nose.\n\nMouth closed, almost breath in, almost breath out, through your nose.\n\nOnce you can do this, do it very fast. If you got the motion off keeping your breath in your nose, youll sound like a dog sniffing. Youll pretty much immediately get how to make it sound like a puppy lighter, faster and if youve heard a dog sniff youll know the frequency of sniffs to use to sound very realistic.\n\nSuper cute and great for use on partners', 
        date: '01/09/2023', 
        isDeleted: false),
      const RedditModel(
        id: 3, 
        title: 'CMV: anyone whos serious about sustainability should change to a plant-based diet"', 
        subtitle: 'Studies have shown the best way for us to reduce deforestation, land use, fresh water use, eutrophication, and biodiversity loss is to change from omnivore diets to plant-based diets. This is because animal agriculture is the leading driver of all of these factors, and switching to a plant-based diet can reduce them by as much as 75% (example source 1, 2, 3). Per the FAO, animal agriculture also emits more greenhouse gases than the entire transportation sector.\n\nWe need to protect what is left of our biodiversity and change the way we interact with the environment. The World Wildlife Fund (WWF) states weve lost an estimated 69% of wild animals in the past 50 years, with losses as high as 94% in places like Latin America. Weve already changed the world so much that 96% of mammalian biomass is now humans and our livestock.', 
        date: '08/05/2023', 
        isDeleted: false),
    ];
    return list;
  }
}