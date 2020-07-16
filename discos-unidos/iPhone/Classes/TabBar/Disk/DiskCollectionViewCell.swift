//
//  DiskCollectionViewCell.swift
//  discos-unidos
//
//  Created by mvilla on 7/12/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit

class DiskCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDisco: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    
    var objDisco: DiscoBE!{
        didSet{
            self.actualizarData()
        }
    }
    
    func actualizarData(){
        
        print(self.objDisco.nombreArtista)
        self.lblNombre.text = self.objDisco.nombreArtista
        let url = self.objDisco.portada
        self.imgDisco.downloadImagenInUrl(url, withPlaceHolderImage: nil) { (urlDescarga, imagenDescargada) in
            if self.objDisco.portada == urlDescarga {
                self.imgDisco.image = imagenDescargada
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
           
       super.draw(rect)
       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowOffset = CGSize(width: 0, height: 0)
       self.layer.shadowRadius = 5
       self.layer.shadowOpacity = 0.5
       self.layer.masksToBounds = false
       self.contentView.layer.cornerRadius = 10
    }
}
