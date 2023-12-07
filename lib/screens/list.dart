import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';


class List extends StatefulWidget {
    List({Key? key}) : super(key: key);


  @override
  State<List> createState() => _listState();
}

class _listState extends State<List> {
  final todosList = ToDo.todoList();
  
  final _todoController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: Column(
              children: [
                

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlack,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search your list items',
                      hintStyle: TextStyle(color: tdGrey)
                      ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 50),
                        child: Text(
                          'All toDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      for( ToDo todo in todosList )
                   
                      ToDoItem(todo: todo,
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _deleteToDoItem,
                      
                      ),




                    ],
                  ),
                )

              ],

            ),
          ),
          Align(alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(bottom: 20,right: 20, left: 20,),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)

            ),
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(
                hintText: 'Add a new todo item',
                border: InputBorder.none
              ),
            ),
            
            ),),
            Container(margin: EdgeInsets.only(bottom: 20,right: 20
            ),
child: ElevatedButton(child: Text(('+'),style: TextStyle(fontSize: 40,),),
onPressed: () {
  _addToDoItem(_todoController.text);

  
},
style: ElevatedButton.styleFrom(
  primary: tdBlue,
  minimumSize: Size(60, 60),
  elevation: 10,
) ,
),

            ),
          ],),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;});
  }

  void _deleteToDoItem(String id) {
  todosList.removeWhere((item) => item.id == id);
  } 

   void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }



 AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,color: tdBlack,size: 30,),
          

        ],
      ),
    );
  }
}