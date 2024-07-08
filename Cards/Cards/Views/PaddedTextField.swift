import Foundation
import UIKit

class PaddedTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 15)
    
    // Изменение рамки текста
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // Изменение рамки редактирования текста
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // Изменение рамки плейсхолдера
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
