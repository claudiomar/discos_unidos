//
//  DiscoWS.swift
//  discos-unidos
//
//  Created by mvilla on 7/10/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation
import Firebase

class DiscoWS {
    
    class func registrarDiscos(nombreArtista: String, genero: String, nombreDisco: String, anioLanzamiento: String, descripcion: String, listaCanciones: String, portada: String) -> DiscoBE  {
    
        print("registrar discos firebase!!")

        let db = Firestore.firestore()
        let objDisco = DiscoBE()

        var ref: DocumentReference? = nil
        ref = db.collection("discos").addDocument(data: [
            "nombreArtista":nombreArtista,
            "genero":genero,
            "nombreDisco":nombreDisco,
            "anioLanzamiento":anioLanzamiento,
            "descripcion":descripcion,
            "listaCanciones":listaCanciones,
            "portada":portada
        ]){ err in
            if let err = err{
                print("error adding document: \(err)" )
            }else{
                print("document added with ID: \(ref!.documentID)")

            }
        }

        return objDisco
    }
        

    class func obtenerDiscos(_ resultado: @escaping Discos) {


        let db  = Firestore.firestore()
        var arrayDiscosApp = [DiscoBE]()

        db.collection("discos").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {

                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        print(data)
                        if let nombreArtista = data["nombreArtista"] as? String, let portada = data["portada"] as? String{
                            let newDiscosBE = DiscoBE()
                            //newDiscosBE.id = id
                            newDiscosBE.nombreArtista = nombreArtista
                            newDiscosBE.portada = portada
                            arrayDiscosApp.append(newDiscosBE)
                        }
                    }
                    //...resultado(arrayDiscosApp)
                }
                resultado(arrayDiscosApp)
            }
        }
    }
}
