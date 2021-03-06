//
//  MyTextField.swift
//  Compatibility
//
//  Created by Aarón Cervantes Álvarez on 06/03/21.
//

import Foundation
import UIKit

class MyTextField: UITextField {
  override func draw(_ rect: CGRect) {
    super.draw( rect )
    self.textColor = UIColor.white
    self.borderStyle = UITextField.BorderStyle.none
    self.layer.backgroundColor = UIColor(red: 0.25, green: 0.45, blue: 0.75, alpha: 0.9 ).cgColor
    self.layer.cornerRadius = 5.0
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1.5
    self.font = UIFont.init(name:"TimesNewRomanPS-BoldMT", size:18.0)
    self.attributedPlaceholder = NSAttributedString(
      string: self.placeholder ?? "placeholder",
      attributes: [
        NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.7)
      ]
    )
    self.tintColor = UIColor.white
  }
  
  // Text position
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return positionText( forBounds: bounds )
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return positionText( forBounds: bounds )
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return positionText( forBounds: bounds )
  }
  
  // This works as a padding
  private func positionText( forBounds bounds: CGRect ) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16 ) )
  }

}
