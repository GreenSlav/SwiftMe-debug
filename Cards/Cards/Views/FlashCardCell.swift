import UIKit

class FlashCardCell: UICollectionViewCell {
    
    private let flashCardView: FlashCardView
    
    override init(frame: CGRect) {
        flashCardView = FlashCardView(frame: .zero)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        flashCardView = FlashCardView(frame: .zero)
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(flashCardView)
        flashCardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Захардкодил значения, нужно исправить
        NSLayoutConstraint.activate([
            flashCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            flashCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            flashCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            flashCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    // Когда ячейка появляется на экране, настраиваем ее
    func configure(with flashCard: FlashCard) {
        flashCardView.frontLabel.text = flashCard.question
        flashCardView.backLabel.text = flashCard.answer
    }
}

