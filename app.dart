import 'package:flutter/material.dart';
import 'package:upload_image/Category.dart';
import 'package:upload_image/service.dart';
class HomeScreen extends StatefulWidget {
	final String title;
	HomeScreen({Key key,this.title}):super(key:key);
	@override
	_HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

	String backup;
	String name1="Sunil Shedge";
	String email1="swarajya888@gmail.com";
	String pic1="https://images.pexels.com/photos/1020315/pexels-photo-1020315.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
	String backup1;
	String name2="Surya shinde";
	String email2="surya888@gmail.com";
	String backup2;
	String pic2="https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80";

	var editcategoryName=TextEditingController();
	var editcategoryDescription=TextEditingController();

	var category=Category();
	var categoryService=CategoryService();
	List<Category> categoryList=List<Category>();
	var _category;

	@override
	void initState() {
		super.initState();
			setState(() {
				getAllCategories();
			});
	}
	final GlobalKey<ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();
	getAllCategories() async
	{
			categoryList=List<Category>();
				var categories=await categoryService.getCategory();
			setState((){
			categories.forEach((category){
				var model=Category();
				model.name=category['name'];
				model.id=category['id'];
				model.description=category['description'];
				categoryList.add(model);
				/*categoryList.add(Card(
					child:ListTile(
						leading: Icon(Icons.edit),
						title: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text(category['name']),
								IconButton(icon: Icon(Icons.delete_outline), onPressed: (){}),
							],
						),

					)
				)
				);*/
		});
			});
	}


	@override
	void dispose() {
		super.dispose();
		setState(() {
			getAllCategories();
		});
	}
	showSnackBar(message) async{
		var snackBar=SnackBar(content: message);
		scaffoldkey.currentState.showSnackBar(snackBar);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			key: scaffoldkey,
			appBar: AppBar(
				title:Text(widget.title),
			),
			drawer: Drawer(
				child: ListView(
					scrollDirection: Axis.vertical,
									children:<Widget>[
										UserAccountsDrawerHeader(
						accountName: Text(name1),
						accountEmail: Text(email1),
						decoration: BoxDecoration(
							image: DecorationImage(image:
							NetworkImage("https://images.pexels.com/photos/1020315/pexels-photo-1020315.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
							fit:BoxFit.cover),
						),
						currentAccountPicture: GestureDetector(
							child: CircleAvatar(backgroundImage: NetworkImage(pic1)),
							onTap: (){

								 setState(() {
									 refresh();
								 });

							},
						),
						otherAccountsPictures: <Widget>[
							GestureDetector(
							child: CircleAvatar(backgroundImage: NetworkImage(pic2)),
							onTap: (){

									setState(() {
										refresh();
									});

							},
							),


						],
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.home),
							title:Text("Home"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){},
						),
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.info_outline),
							title:Text("About"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){},
						),
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.call),
							title:Text("Contact"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){},
						),
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.image),
							title:Text("Portfolio"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){},
						),
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.wallpaper),
							title:Text("WallPaper"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){},
						),
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.share),
							title:Text("Share"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){},
						),
					),
					Card(
							child: ListTile(
							leading:Icon(Icons.remove_circle_outline),
							title:Text("close"),
							trailing: Icon(Icons.arrow_right),
							onTap: (){
								setState(() {
									Navigator.of(context).pop();
								});
							},
						),
					),
				],
				),
			),
			body:/*ListView(
				scrollDirection: Axis.vertical,
						children:List.generate(categoryList.length, (index){
							return Column(
								children: <Widget>[
									Card(
					child:ListTile(
						leading: Icon(Icons.edit),
						title: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text(categoryList[index].name),
								IconButton(icon: Icon(Icons.delete_outline), onPressed: (){}),
							],
						),

					)
				)

								],
							);
						}),
			),*/
			ListView.builder(
				scrollDirection: Axis.vertical,
				itemCount: categoryList.length,
				itemBuilder: (context,index){
					return Card(
					child:ListTile(
						leading: IconButton(icon:Icon(Icons.edit),onPressed: (){
							updateCategory(index);
							},
            ),
            title: Text(categoryList[index].name),
            trailing: IconButton(icon: Icon(Icons.delete_outline), onPressed: () async {
            
             var result=await _deleteCategoryDialog(context,categoryList[index].id);
             print(result);
            }),
				 ),
          );
				}),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle),
          backgroundColor: Colors.pink,
          onPressed: (){
            dialog();
          }),
    );
	}
	void refresh(){
	  setState(() {
	    backup=email1;
	    email1=email2;
	    email2=backup;


	    backup1=name1;
	    name1=name2;
	    name2=backup1;

	    backup2=pic1;
	    pic1=pic2;
	    pic2=backup2;


	  });
	}

	void dialog() {
	  setState(() {
	    showDialog(context: context,
        barrierDismissible: true,
        child: AlertDialog(
          actions: <Widget>[
            FlatButton(onPressed: () async{

              print(editcategoryName.text);
              print(editcategoryDescription.text);
              /* category.id=_category[0]['id'];*/
              category.name=editcategoryName.text;
              category.description=editcategoryDescription.text;
              var result=await categoryService.saveCategory(category);
              print(result);
              if(result>0){
                Navigator.pop(context);
                getAllCategories();
                showSnackBar(Text("Successfully Edited"+"\t"+category.name));
              }
              /*Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen(title: widget.title)));
*/
              },
              child: Text('Save'),
            ),


            FlatButton(onPressed: (){
              setState(() {
                Navigator.of(context).pop();
              });
              },
              child: Text('Close'),
            ),
          ],
          title: Text("Category Form"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height:10.0),
                TextField(
                  controller: editcategoryName,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: editcategoryDescription,
                  decoration: InputDecoration(
                    labelText: "Category Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),),
      );
	  });
	}

	editCategory(BuildContext context,categoryId) async {
	  _category=await categoryService.getCategoryById(categoryId);
	  setState(() {
	    editcategoryName.text=_category[0]['name'] ?? "no Name";
	    editcategoryDescription.text=_category[0]['description']??"No Description";
	  });
	}



	void updateCategory(int index) {
    editCategory(context, categoryList[index].id);
	  setState(() {
	    showDialog(context: context,
          barrierDismissible: true,
          builder: (context){
	      return AlertDialog(
          actions: <Widget>[
            FlatButton(onPressed: () async{

              print(editcategoryName.text);
              print(editcategoryDescription.text);
              category.id=_category[0]['id'];
              category.name=editcategoryName.text;
              category.description=editcategoryDescription.text;
              var result=await categoryService.updateCategory(category);
              print(result);
              if(result>0){
                Navigator.pop(context);
                getAllCategories();
                showSnackBar(Text("Successfully Edited"+"\t"+category.name));
              }
             /* Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen(title: widget.title)));
*/
              },

              child: Text('Update'),
            ),

            FlatButton(onPressed: (){
              setState(() {
                Navigator.pop(context);
              });
              }, child: Text("Cancel")),
          ],
																																																															title: Text("Category Form"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height:10.0),
                TextField(
                  controller: editcategoryName,
                  decoration: InputDecoration(
                    labelText: "Edit Category Form",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: editcategoryDescription,
                  decoration: InputDecoration(
                    labelText: "Category Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

        );
	    });
	  }
	  );
	}

	_deleteCategoryDialog(BuildContext context, categoryId) async{
	  return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Are You Sure you want to delete"),
            actions: <Widget>[
              FlatButton(onPressed: (){
                Navigator.pop(context);
                }, child: Text("Cancel"),color: Colors.green,),
              FlatButton(onPressed: () async {

                var res=await CategoryService().deleteCategory(categoryId);
                print(res);
                if(res==1)
                {
                  Navigator.pop(context);
                  getAllCategories();
                }
                }, child: Text("Delete"),color: Colors.red,)
            ],
          );
          },
      );

	}
}