//
//  DiscoBE.swift
//  discos-unidos
//
//  Created by mvilla on 7/9/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation

class DiscoBE {
    
    var id              = ""
    var nombreArtista   = ""
    var genero          = ""
    var nombreDisco     = ""
    var anioLanzamiento = ""
    var descripcion     = ""
    var listaCanciones  = ""
    var portada         = ""

    class func parse(_ json: CSMJSON) -> DiscoBE {
        
        let objBE = DiscoBE()
        
        objBE.id               = json.dictionary["id"]?.stringValue ?? ""
        objBE.nombreArtista    = json.dictionary["artista"]?.stringValue ?? ""
        objBE.genero           = json.dictionary["genero"]?.stringValue ?? ""
        objBE.nombreDisco      = json.dictionary["nombre"]?.stringValue ?? ""
        objBE.anioLanzamiento  = json.dictionary["anioLanzamiento"]?.stringValue ?? ""
        objBE.descripcion      = json.dictionary["descripcion"]?.stringValue ?? ""
        objBE.listaCanciones   = json.dictionary["listCanciones"]?.stringValue ?? ""
        objBE.portada          = json.dictionary["portada"]?.stringValue ?? ""
        
        return objBE
    }
}

