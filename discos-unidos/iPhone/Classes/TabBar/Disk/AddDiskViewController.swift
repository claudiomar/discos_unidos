//
//  AddDiskViewController.swift
//  discos-unidos
//
//  Created by mvilla on 7/12/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit

class AddDiskViewController: UIViewController {

    @IBOutlet weak var txtArtista: UITextField!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtNombreDisco: UITextField!
    @IBOutlet weak var txtAnioLanzamiento: UITextField!
    @IBOutlet weak var txtListaCanciones: UITextField!
    @IBOutlet weak var txtPortada: UITextField!
    @IBOutlet weak var txvDescripcion: UITextView!
    
    // scrollView
    @IBOutlet weak var cnsBottomScroll  : NSLayoutConstraint!
    
    @IBAction func clickBtnSaveDisk(_ sender:Any){
        
        let nombreArtista = self.txtArtista.text
        let genero = self.txtGenero.text
        let nombreDisco = self.txtNombreDisco.text
        let anioLanzamiento = self.txtAnioLanzamiento.text
        let descripcion = self.txvDescripcion.text
        let listaCanciones = self.txtListaCanciones.text
        let portada = self.txtPortada.text
        
        
        DiscoBL.create(nombreArtista: nombreArtista,
                       genero: genero,
                       nombreDisco: nombreDisco,
                       anioLanzamiento: anioLanzamiento,
                       descripcion: descripcion,
                       listaCanciones: listaCanciones,
                       portada: portada,
                       success: { (objDisco) in self.navigationController?.popViewController(animated: true)
                        
        }) { (errorMessage) in
             self.showAlert(withTitle: "Error", withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
         }
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let keyboardSize = keyboardFrame.size
        
        UIView.animate(withDuration: 0.3) {
            self.cnsBottomScroll.constant = keyboardSize.height
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        UIView.animate(withDuration: 0.3) {
            self.cnsBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

            
        self.txvDescripcion.layer.cornerRadius = 8
        self.txvDescripcion.layer.borderWidth = 1
        self.txvDescripcion.layer.borderColor = UIColor.systemGray3.cgColor
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
 

}
