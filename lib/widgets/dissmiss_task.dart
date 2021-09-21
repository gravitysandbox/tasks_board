// import 'package:flutter/material.dart';

// class DissmissTask extends StatelessWidget {
//   const DissmissTask({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: Key(tasks[index].title!),
//       background: Container(
//         padding: const EdgeInsets.only(left: 20.0),
//         alignment: Alignment.centerLeft,
//         child: const Icon(Icons.delete),
//         color: Colors.red,
//       ),
//       onDismissed: (direction) async => deleteTask(index),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(2.0),
//           height: 30.0,
//           width: 30.0,
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor,
//             shape: BoxShape.circle,
//           ),
//           child: tasks[index].isComplete != null &&
//                   tasks[index].isComplete! == true
//               ? const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                 )
//               : Container(),
//         ),
//         title: Text(
//           tasks[index].title!,
//           style: const TextStyle(
//             fontSize: 20.0,
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         subtitle: Text(
//           tasks[index].subtitle!,
//           style: const TextStyle(
//             fontSize: 18.0,
//             color: Colors.white,
//           ),
//         ),
//         onTap: () => completeTask(index),
//         onLongPress: () => _startEditingTask(context, tasks[index]),
//       ),
//     );
//   }
// }
