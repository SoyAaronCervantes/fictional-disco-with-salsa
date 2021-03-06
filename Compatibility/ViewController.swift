//
//  ViewController.swift
//  Compatibility
//
//  Created by Jan Zelaznog on 05/03/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
  
  let placeholder = ["Nombre","Apellido Paterno","Apellido Materno","Correo","Telefono","Estado","Ciudad"]
  var keyboardEnabled = false

  @IBOutlet var textFieldArray: [UITextField]!

  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBAction func submitButton(_ sender: UIButton) {
    // validate user info
    
    // Get AppDelegate
    let appDelagete = UIApplication.shared.delegate as! AppDelegate
    
    // Get NSManagedObjectContext
    let context = appDelagete.persistentContainer.viewContext
    
    // Create person instance
    let person = NSEntityDescription.insertNewObject( forEntityName: "Person", into: context ) as! Person
    
    person.name = textFieldArray[0].text
    person.last_name = textFieldArray[1].text
    person.middle_name = textFieldArray[2].text
    person.email = textFieldArray[3].text
    person.phone = textFieldArray[4].text
    person.state = textFieldArray[5].text
    person.city = textFieldArray[6].text
    
    if appDelagete.saveContext() {
     
      let alert = UIAlertController(title: "Personas", message: "El registro se guardó correctamente", preferredStyle:.alert)

      let boton = UIAlertAction(title: "OK", style:.default) { (localAlert) in
        
        for txt in self.textFieldArray { txt.text = "" }

      }

      alert.addAction(boton)

      present(alert, animated: true, completion:nil)
      
    }

  }


  @IBAction func tapEnLaVista() {
      view.endEditing(true)
  }
    //////////
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoAparece), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoDesaparece), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func tecladoAparece (notificacion: Notification) {
      print ("el teclado subió")

      if keyboardEnabled {
        return
      }

      keyboardEnabled = true

      // Check if keyboard size exist on userInfo
      if let keyboardSize = ( notificacion.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue )?.cgRectValue {
        scrollView.contentSize.height += keyboardSize.height
      }

    }
    
    @objc func tecladoDesaparece (notificacion: Notification) {
        print ("el teclado se fue")
      
      if !keyboardEnabled {
        return
      }
      
      keyboardEnabled = false

      // Check if keyboard size exist on userInfo
      if let keyboardSize = ( notificacion.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue )?.cgRectValue {
        scrollView.contentSize.height -= keyboardSize.height
      }

    }
    /////////////
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          
      for index in 0...6 {
          textFieldArray[index].placeholder = placeholder[index]
      }

      // Assign delegate to each textField
      for textField in textFieldArray {
        textField.delegate = self
      }

      
    }

  func textFieldShouldReturn( _ textField: UITextField ) -> Bool {
    
    // If text field is the first element
    guard
      let index = textFieldArray.firstIndex(of: textField)
    else {
      return true
    }
    
    // If index isn't the last one
    if index < ( textFieldArray.count - 1 ) {
      let nextTextField = textFieldArray[ index + 1 ]
      nextTextField.becomeFirstResponder()
      return false
    }
    
    return true

  }

}

