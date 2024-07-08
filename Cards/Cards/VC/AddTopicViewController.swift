//
//  AddTopicViewController.swift
//  Cards
//
//  Created by Viacheslav on 08.07.2024.
//

import UIKit

class AddTopicViewController: UIViewController {
    
    let dataManager = CoreDataManager.shared
    weak var delegate: AddTopicViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
        setupLabelAndTextField()
    }
    
    func setupBackButton() {
        // Возвращение на главную страницу
        let goBack = UIAction {
            _ in
            self.dismiss(animated: true)
        }
        
        // Добавляю кнопку назад на главную страницу, если пользователь
        // передумал добавлять тему карточек
        let backButton: UIButton = {
            let button = UIButton(primaryAction: goBack)
            button.setTitle("Back", for: .normal)
            button.tintColor = .systemPink
            button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            
            return button
        }()
        
        view.addSubview(backButton)
        
        // Расположение кнопки слева наверху
        // Добавляем констрейнты относительно safeArea
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15), // Верхний отступ
            backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15), // Левый отступ
            backButton.heightAnchor.constraint(equalToConstant: 30), // Высота кнопки
            backButton.widthAnchor.constraint(equalToConstant: 50) // Ширина кнопки
        ])
    }
    
    func setupLabelAndTextField() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New category"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .left
        view.addSubview(label)
        
        // Создание и настройка UITextField
        let backgroundViewForTextField = UIView()
        backgroundViewForTextField.backgroundColor = .systemPink
        backgroundViewForTextField.layer.cornerRadius = 10
        
        // Создание и настройка PaddedTextField
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type here"
        textField.borderStyle = .none
        textField.tintColor = .systemPink
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 10.0
        textField.font = UIFont.systemFont(ofSize: 23)
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        let underline = UIView()
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .clear // Начальное состояние прозрачное
                
                
        view.addSubview(textField)
        view.addSubview(underline)
        
        
        let saveCategoryButton = UIAction  {
            _ in
            
            if self.isValidString(textField.text) {
                // Введённый текст не является nil и не пустой
                
                // тут сохранить топик в базу данных
                self.dataManager.createAndSaveFCTopic(textField.text!)
                self.delegate?.didAddTopic()
                
                self.dismiss(animated: true) // либо передадим как completion
                // после сохранения
            } else {
                // Введённый текст либо nil, либо пустой
                print("Text is either nil or empty")
                
                let placeholderColor = UIColor.red
                textField.attributedPlaceholder = NSAttributedString(
                    string: textField.placeholder ?? "",
                    attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
                        )
                textField.text = String()
                textField.placeholder = "Name can't be empty"
                return
            }
        }
        let button = UIButton(type: .system, primaryAction: saveCategoryButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.tintColor = .systemPink
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        // Настройка констрейнтов
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            underline.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            underline.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 2),
                        
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func isValidString(_ str: String?) -> Bool {
        guard let str = str, !str.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if let underline = view.subviews.last(where: { $0 is UIView && $0.backgroundColor == .clear }) {
            underline.backgroundColor = .systemPink // Изменение цвета линии при фокусе
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if let underline = view.subviews.last(where: { $0 is UIView && $0.backgroundColor == .systemPink }) {
            underline.backgroundColor = .clear // Возврат линии в прозрачное состояние
        }
    }
}

