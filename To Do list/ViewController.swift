//
//  ViewController.swift
//  To Do list
//
//  Created by SEAN on 2021/12/15349.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [ToDoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "To Do list"
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New Item",
                                      message: "Enter New Item",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self]_ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self?.createItem(name: text)
        }))
        
        present(alert, animated: true)
    }
    
    //count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    
    //select task and edit
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        // cancel
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // edit
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item", message: "Edit New Item", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self]_ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                self?.updateItem(item: item, newName: newName)
            }))
            self.present(alert, animated: true)
           
        }))
        // set alarm
        sheet.addAction(UIAlertAction(title: "Set Alarm", style: .default, handler: { _ in
            
            //set alarm
            let alarm = UIAlertController(title: "Task Priority", message: nil, preferredStyle: .actionSheet)
            
            alarm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alarm.addAction(UIAlertAction(title: "Important", style: .default, handler: { _ in
                // ask for permission
                let center = UNUserNotificationCenter.current()

                center.requestAuthorization(options: [.alert, .sound, .badge]) {
                    (granted, error) in
                    
                    if granted {
                        print("Allowed")
                    }
                    else {
                        print("Not Allowed")
                    }
                }

                // create notification content
                let content = UNMutableNotificationContent()
                
                content.title = "Procrastiner Buster!"
                content.body = "GO ON! YOU SAID IT WAS IMPORTANT!"
                content.sound = UNNotificationSound.default

                //trigger the notification

                let trigger = UNTimeIntervalNotificationTrigger (timeInterval: 20, repeats: false)

                //create the request
                let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)

                //register a requset
                center.add(request, withCompletionHandler: nil)
                content.badge = 1
            }))
            
            alarm.addAction(UIAlertAction(title: "Normal", style: .default, handler: { _ in
                // ask for permission
                let center = UNUserNotificationCenter.current()

                center.requestAuthorization(options: [.alert, .sound, .badge]) {
                    (granted, error) in
                    
                    if granted {
                        print("Allowed")
                    }
                    else {
                        print("Not Allowed")
                    }
                }

                // create notification content
                let content = UNMutableNotificationContent()
                
                content.title = "Do Your Own Work!"
                content.body = "You still have things to do!"
                content.sound = UNNotificationSound.default

                //trigger the notification

                let trigger = UNTimeIntervalNotificationTrigger (timeInterval: 60 * 60 * 24, repeats: true)

                //create the request
                let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)

                //register a requset
                center.add(request, withCompletionHandler: nil)
                content.badge = 1
            }))
            self.present(alarm, animated: true)
        }))
       
        
        // delete
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self]_ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    
    
    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        catch {
            //error
        }
        
    }
    
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        }
        
        catch {
            
        }
    }
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        
        catch {
            
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
            getAllItems()
        }
        
        catch {
            
        }
    }
}



