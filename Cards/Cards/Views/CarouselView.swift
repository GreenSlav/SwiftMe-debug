import UIKit

class CarouselView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Удалил из родитилей UICollectionViewDelegate, может понадобиться в будущем

    // Может быть nil, но при обращении она автоматически forced-unwrap
    private var collectionView: UICollectionView!
    // Коллекция наших карточек, которая будет лениво загружаться
    private var flashCards: [FlashCard] = []
    
    init(frame: CGRect, flashCards: [FlashCard]) {
        self.flashCards = flashCards
        super.init(frame: frame)
        setupCollectionView()
    }
    
    // Инициализатор, который требует объявить родитель
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // Расстояние между ячейками(Карточками)
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        // Передавая в качестве аргумента функции FlashCardCell.self мы передаем
        // тип класса
        // Это как в C#: typeof(FlashCardCell)
        collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: "FlashCardCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // Возвращает количество карточек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    // Возвращает ячейку карточки, ее оболочку. Перед возвращаением можно настроить
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlashCardCell", for: indexPath) as! FlashCardCell
        // Когда карточка появляется на экране, получаем индекс карточки в массиве
        // flashCards[], чтоб настроить вид ячейки
        let flashCard = flashCards[indexPath.item]
        // Настраиваем вид ячейки, передавая ей UIView нашей карточки
        cell.configure(with: flashCard)
        return cell
    }
    
    // Определяем габариты ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.7)
    }
    
   
    // Захардкодил сдвиг, исправить
    // Хотя как будто бы -60 - идеальное значение
    func animateScrollView() {
        let offsetFactor: Float = 150 / 1125
        let widthOfScreen = UIScreen.main.bounds.width
        let leftOffset = CGFloat(Float(widthOfScreen) * offsetFactor * -1)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.collectionView.contentInset = UIEdgeInsets(top: 0, left: -60, bottom: 0, right: 0)
        }, completion: { _ in
            UIView.animate(withDuration: 1, delay: 1, animations: {
                // !!! Не хочет обновляться !!!
                // Точнее оно обновиться, но без анимации
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }, completion: nil)
        })
    }
        
    
    // Вызовется, когда кто-то напишет self.view.addSubView(CarouselView)
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if flashCards.count > 1 {
            animateScrollView()
        }
    }
}

