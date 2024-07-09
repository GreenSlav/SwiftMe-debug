

import UIKit

class CardsViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var label: UILabel!
    
    var topic: FlashCardTopic?
    
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var startButn: UIButton!
    var cardsDict : [String:String] = ["phohe":"телефон", "name":"имя", "friend":"друзья"]
    var cardsList: [String] = ["phohe", "name", "friend"]
    
    lazy var dataManager = CoreDataManager.shared
    var dataSourceWords :[FlashCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .systemPink
        dataSourceWords = Array(dataManager.obtainCardsByTopic(self.topic))
        cardsTableView.reloadData()

        dataSourceWords = Array(dataManager.obtainCardsByTopic(topic!))
            cardsTableView.reloadData()

        //self.setUpUI()
        
        self.cardsTableView.delegate = self
        self.cardsTableView.dataSource = self
    }
    
    @IBAction func plusButn(_ sender: Any) {
        showAlertWithTwoTextFields()
    }
    func showAlertWithTwoTextFields() {
        let alertController = UIAlertController(title: "Добавление карточки", message: nil, preferredStyle: .alert)
        
        // Добавление текстового поля для ввода слова
        alertController.addTextField { (wordTextField) in
            wordTextField.placeholder = "Слово"
            wordTextField.font = UIFont.systemFont(ofSize: 18)
            wordTextField.delegate = self
        }
        
        alertController.addTextField { (valueTextField) in
            valueTextField.placeholder = "Значение"
            valueTextField.font = UIFont.systemFont(ofSize: 18)
            valueTextField.delegate = self
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Готово", style: .default) { (_) in
            if let wordInput = alertController.textFields?[0].text, let valueInput = alertController.textFields?[1].text {

                let flashCard = FlashCard(context: self.dataManager.viewContext)
                flashCard.answer = valueInput
                flashCard.question = wordInput
                self.dataSourceWords.append(flashCard)
                self.dataManager.saveAndCreateFlashCard(self.topic, question: wordInput, answer: valueInput)
                
                self.cardsTableView.reloadData()
                print(self.dataSourceWords)
            }
        }
        cancelAction.setValue(UIColor.systemPink, forKey: "titleTextColor")
        okAction.setValue(UIColor.systemPink, forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        // Отображение всплывающего окна
        present(alertController, animated: true, completion: nil)
    }
    
    // Реализация метода делегата для обработки нажатия клавиши "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentCards" {
            if let flashCardsVC = segue.destination as? FlashCardsViewController {
                flashCardsVC.flashCards = dataSourceWords
            }
        }
    }
}
extension CardsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            dataManager.deleteFlashCard(topic!, dataSourceWords[indexPath.row])
            dataSourceWords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "iden")
        cell.textLabel?.text = indexPath.row.description
        if dataSourceWords.count > 0{
            let model = dataSourceWords[indexPath.row]
            var configuration = cell.defaultContentConfiguration()
            configuration.text = model.question
            configuration.secondaryText = model.answer
            configuration.textProperties.font = UIFont.boldSystemFont(ofSize: 24)
            configuration.textProperties.color = .systemPink
            configuration.secondaryTextProperties.font = UIFont.boldSystemFont(ofSize: 20)
            configuration.secondaryTextProperties.color = .systemPink
            
            var bacgroundConfiguration = cell.defaultBackgroundConfiguration()
            bacgroundConfiguration.backgroundColor = .black
            
            
            cell.contentConfiguration = configuration
        }
        
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        //        dataSourceWords = Array(dataManager.obtainCardsByTopic(topic!))
        //        cardsTableView.reloadData()
            // сюда добавим подключение всех топиков
            // Здесь будем загружать данные из core data в dataSource
        
        }
    
    
}

