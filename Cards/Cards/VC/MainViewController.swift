//
//  ViewController.swift
//  Cards
//
//  Created by Viacheslav on 08.07.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var topic: FlashCardTopic?
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
//        table.separatorStyle = .singleLine
//        table.separatorColor = UIColor.blue
//        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        
//        table.layer.borderWidth = 1.0
//        table.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
//        table.layer.cornerRadius = 10
        
        table.register(TopicsTableCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    let dataManager = CoreDataManager.shared
    var dataSource: [FlashCardTopic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    
    //override func view
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // сюда добавим подключение всех топиков
        // Здесь будем загружать данные из core data в dataSource
        dataSource = dataManager.obtainSavedTopics()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentAddTopicVC" {
            if let addTopicVC = segue.destination as? AddTopicViewController {
                addTopicVC.delegate = self
            }
        }
        
        if segue.identifier == "showFlashCardsViewController" {
            if let destinationVC = segue.destination as? FlashCardsViewController,
               let topic = sender as? FlashCardTopic {
                destinationVC.topic = topic
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, AddTopicViewControllerDelegate {
    func didAddTopic() {
        print("Topic added")
        dataSource = dataManager.obtainSavedTopics()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopicsTableCell
        
        let topic: FlashCardTopic = dataSource[indexPath.row]
        
        cell.flashCardTopic = topic
        cell.textLabel?.text = topic.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // На время такой способ удаления
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        
//        let topicToDelete = dataSource[indexPath.row]
//        
//        if indexPath.row < dataSource.count {
//            dataManager.deleteTopic(topicToDelete)
//            dataSource.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
    
    // Свайп для удаления (для iOS 13 и выше)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Удаляем тему из массива
            let cell = tableView.cellForRow(at: indexPath) as! TopicsTableCell
            self.dataManager.deleteTopic(cell.flashCardTopic!)
            self.dataSource.remove(at: indexPath.row)
            
            // Удаляем ячейку из таблицы
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Снятие выделения с ячейки
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row < dataSource.count {
            // Получаем выбранную тему
            let selectedTopic = dataSource[indexPath.row]
            
            // Переход к FlashCardViewController
            performSegue(withIdentifier: "showFlashCardsViewController", sender: selectedTopic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
