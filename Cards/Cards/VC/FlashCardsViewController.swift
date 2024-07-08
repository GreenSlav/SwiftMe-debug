import UIKit

class FlashCardsViewController: UIViewController {
    var flashCards: [FlashCard]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .systemPink
        
        //        Для теста отсутствия карточек
        //        flashCards = []
        //
        //        Для тестирования только одной карточки
        //        let flashCards = [FlashCard(question: "Lorem ipsum", answer: "dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")]
        //
        //        let flashCards = [
        //            FlashCard(question: "What is the capital of France?", answer: "Paris"),
        //            FlashCard(question: "Lorem ipsum", answer: "dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."),
        //            FlashCard(question: "Bill", answer: "44"),
        //            FlashCard(question: "John", answer: "56"),
        //            FlashCard(question: "Nina", answer: "25"),
        //            FlashCard(question: "Nina", answer: "25"),
        //            FlashCard(question: "Nina", answer: "25"),
        //            FlashCard(question: "Nina", answer: "25"),
        //        ]
        
        if let cards = flashCards, !cards.isEmpty {
            // Массив не nil и не пустой
            
            let carouselView = CarouselView(frame: view.bounds, flashCards: flashCards!)
            view.addSubview(carouselView)
            
            carouselView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                carouselView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                carouselView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                carouselView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                carouselView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            // Массив nil или пустой
            let widthOfScreen = UIScreen.main.bounds.width
            
            let fontSizeFactor: Float = 75 / 1125
            let widthIconFactor: Float = 180 / 1125
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(systemName: "xmark")
            imageView.tintColor = .gray
            view.addSubview(imageView)
            
            // Создание и настройка надписи
            let emptyCollectionLabel = UILabel()
            emptyCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyCollectionLabel.text = "No flashcards available"
            emptyCollectionLabel.textColor = .gray
            emptyCollectionLabel.textAlignment = .center
            emptyCollectionLabel.font = UIFont.systemFont(ofSize: widthOfScreen * CGFloat(fontSizeFactor))
            
            view.addSubview(emptyCollectionLabel)
            
            // Констрейнты для центрирования иконки
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
                imageView.widthAnchor.constraint(equalToConstant: widthOfScreen * CGFloat(widthIconFactor)),
                imageView.heightAnchor.constraint(equalToConstant: widthOfScreen * CGFloat(widthIconFactor))
            ])
            
            //Констрейнты для центрирования надписи под иконкой
            NSLayoutConstraint.activate([
                emptyCollectionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                emptyCollectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
}
