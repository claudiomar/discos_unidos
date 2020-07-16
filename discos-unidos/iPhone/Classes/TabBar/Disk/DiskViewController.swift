//
//  DiskViewController.swift
//  discos-unidos
//
//  Created by mvilla on 7/12/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit

class DiskViewController: UIViewController {

  @IBOutlet weak var clvList: UICollectionView!

    var arrayDiscos = [DiscoBE]()

    @IBAction func closeSession(_ sender: Any) {
          //...UserSessionBL.closeSession()
          print("close session")
          CSMKeyChain.sharedInstance.deleteKeychain()
          self.navigationController?.popToRootViewController(animated: true)
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          if let session = UserSessionBL.getUserSession() {
              print("User: \(session.session_user ?? "Sin usuario")")
              print("Role: \(session.session_role ?? "Role")")
          }
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          print("viewWillAppear!!")
          
          DiscoBL.obtenerDiscos { (arrayDiscos) in
              self.arrayDiscos = arrayDiscos

              DispatchQueue.main.async {
                  self.clvList.reloadData()
              }
          }
      }

}

extension DiskViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayDiscos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "DiskCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DiskCollectionViewCell
        cell.objDisco = self.arrayDiscos[indexPath.row]
        return cell
    }
}

extension DiskViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numeroColumnas: CGFloat = 2
        let anchoCollection = collectionView.frame.width
        let paddingDerecha: CGFloat = 20
        let paddingIzquierda: CGFloat = 20
        let separacionCelda: CGFloat = 20
        let tamanoDisponible = anchoCollection - paddingDerecha - paddingIzquierda - separacionCelda*(numeroColumnas - 1)
        let anchoCelda = tamanoDisponible / numeroColumnas
        let altoCelda = anchoCelda * 1.5
        
        let tamano = CGSize(width: anchoCelda, height: altoCelda)
        return tamano
    }
}

