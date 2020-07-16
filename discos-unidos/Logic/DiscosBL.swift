//
//  DiscosBL.swift
//  discos-unidos
//
//  Created by mvilla on 7/10/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation

class DiscoBL {
    
    typealias DiscoSuccess = (_ disk: DiscoBE) -> Void
    typealias DiscoError = (_ errorMessage: String) -> Void
    
    class func create(nombreArtista: String?, genero: String?, nombreDisco: String?, anioLanzamiento: String?, descripcion: String?, listaCanciones: String?, portada: String?, success: DiscoSuccess, error: DiscoError) {
        
        guard let safeNomArtista = nombreArtista, safeNomArtista.count != 0 else {
            error("Ingrese un nombre correcto")
            return
        }
        
        guard let safeGenero = genero, safeGenero.count != 0 else {
            error("Ingrese un genero correcto")
            return
        }
        
        guard let safeNomDisco = nombreDisco, safeNomDisco.count != 0 else {
            error("Ingrese un nombre de disco correcto")
            return
        }
        
        guard let safeAnioLanzamiento = anioLanzamiento, safeAnioLanzamiento.count != 0 else {
            error("Ingrese un año de lanzamiento correcto")
            return
        }
        
        guard let safeDescripcion = descripcion, safeDescripcion.count != 0 else {
            error("Ingrese una descripción correcto")
            return
        }
        
        guard let safeListaCanciones = listaCanciones, safeListaCanciones.count != 0 else {
           error("Ingrese una lista de canciones correcta")
           return
        }
        
        guard let safePortada = portada, safePortada.count != 0 else {
          error("Ingrese una portada correcto")
          return
        }
        
        
        
        let objDisco = DiscoWS.registrarDiscos(nombreArtista: safeNomArtista,
                                                genero: safeGenero,
                                                nombreDisco: safeNomDisco,
                                                anioLanzamiento: safeAnioLanzamiento,
                                                descripcion: safeDescripcion,
                                                listaCanciones: safeListaCanciones,
                                                portada: safePortada)
        
        //appDelegateClass.saveContext()
        success(objDisco)
    }
    
    class func obtenerDiscos(_ resultado: @escaping Discos) {
        
        print("obtener discos...")
        DiscoWS.obtenerDiscos { (arrayDiscos) in
                
            let arrayOrdenado = arrayDiscos.sorted(by: {
                return $0.nombreArtista < $1.nombreArtista
            })
            
            print(arrayOrdenado)
            resultado(arrayOrdenado)
        }
    }
    
    
}
