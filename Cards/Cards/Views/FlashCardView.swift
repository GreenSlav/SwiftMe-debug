//
//  FlashCardView.swift
//  card-test
//
//  Created by Viacheslav on 05.07.2024.
//

import UIKit

let cardBackgroundColor: UIColor = .black

// Вынес из класса, потому что не дает вызвать метод класса до супер-инициализатора
func createUILabel(text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.text = text
    label.backgroundColor = cardBackgroundColor
    label.textColor = .white
    label.layer.cornerRadius = 20
    label.clipsToBounds = true // Обрезает подвиды по границам метки
    label.font = UIFont.systemFont(ofSize: 26)
    label.lineBreakMode = .byTruncatingTail
    return label
}

class FlashCardView: UIView {
    
    let frontLabel: UILabel
    let backLabel: UILabel
        
    private var isFlipped = false
    var canBeFlipped = true//false

    override init(frame: CGRect) {
        frontLabel = createUILabel(text: "Hello")
        backLabel = createUILabel(text: "World")
        
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        
        frontLabel = createUILabel(text: "Hello")
        backLabel = createUILabel(text: "World")
        
        super.init(coder: coder)
        
        setupView()
    }


    
    init(frame: CGRect, front: String, back: String) {
        frontLabel = createUILabel(text: front)
        backLabel = createUILabel(text: back)
        
        super.init(frame: frame)
        
        setupView()
    }
        
    private func setupView() {
            
        // Добавляем обе метки на вид
        self.addSubview(frontLabel)
        self.addSubview(backLabel)
        
        // Настройка Auto Layout для frontLabel и backLabel
        let widthOfDeviceScreen: Float = Float(UIScreen.main.bounds.width)
        let paddingFactor: Float = 60 / 1180
        let padding: CGFloat = CGFloat(widthOfDeviceScreen * paddingFactor)
        
        NSLayoutConstraint.activate([
            frontLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            frontLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            frontLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            frontLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            backLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            backLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            backLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
        
        // Изначально показываем frontLabel и скрываем backLabel
        frontLabel.isHidden = false
        backLabel.isHidden = true

        // Добавляем UITapGestureRecognizer для обработки нажатий
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipView))
        self.addGestureRecognizer(tapGesture)
        
        // Устанавливаем базовые параметры для UIView
        self.backgroundColor = cardBackgroundColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true // Обрезает подвиды по границам вида
    }
    
    @objc private func flipView() {
        if !canBeFlipped {
            return
        }
        
        let fromView = isFlipped ? backLabel : frontLabel
        let toView = isFlipped ? frontLabel : backLabel
        
        let options: UIView.AnimationOptions = isFlipped ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        UIView.transition(from: fromView, to: toView, duration: 0.35, options: [options, .showHideTransitionViews]) { _ in
            self.isFlipped.toggle()
        }
    }
}

