# Procrastinator Buster
#### Video Demo: https://youtu.be/g1VBlDd93Hk
#### Description:

In my final project, Procrastinator Buster, I would like to create an to do list app for procrastinator.

 - iOS system and Swift

The very first challenge I faced was iOS system and the coding language of it, Swift.
After spending two weeks, finally knew the basic of storyboard and how the Swift UI system works.
In the lecture of cs50, we have learned about coding through programming language.
However, storyboard and SwiftUI is more a objective-c way to create an app and write the code.
It's all about the objects how to react with each others and react with the user's input.

 - to-do list and Core data

In order to save the data that the user typed in permanently, I use the core data function in Swift which can save and fetch information.
Even if we return to homepage or close the simulator, the task will still save in the app.

Frankly, I already finish a early version of the to do list but the data couldn't last if we close the simulator.
I decided to search for another solution to fix the problem and that's the function of core data.
Core data is a function which already implement in Swift.
First, you have to define the structure of an object in core data, just like how we do in python where we have to define a new datatype.

- functions

As for the app, there are four functions in it.
First of all, to do list must have the function to add some tasks and save it in your phone.
I used the navigation controller to create a navigation button for adding tasks at the top of the right corner.
Furthermore, after tapping the "+" button, there should be a alarm pop up to ask the user to type in the task's name.

Second, the cotent of the task should be changeable. Therefore, I created a actionsheet with editing function.
Specifically speaking, the actionsheet have three functions, edit, set alarm, delete and a basic way to return to homepage, cancel.

Third, when you completed your tasks, there should be a function delete to it.
Also, the task which saved in core data should be deleted at the same moment.

Last, I created a "set alarm" function. It will send notification to the user.
Once you click the task priority of the task, the screen will pop up a request of allowing notifications of current app.
Because the notification of our app doesn't have to customize in some certain ways, I used local notification rather than push notification to do so.

Normally, a person with procrastination needs something as reminder.
I chose to use UNtimeintervalNotification to implement the notifiaction trigger
, which is more directly to show when the user created the task and how long since then.

Procrastinator Buster depends on the which task priority the user chose and make change of the "set alarm" function.
"Important" will be a hard mode and the notification will pop up every 10 seconds.
"Normal" will send notification in every 24 hours.









