//
//  network.swift
//  desafio_ios_nexaas
//
//  Created by Denis Janoto on 06/07/20.
//  Copyright © 2020 Denis Janoto. All rights reserved.
//

import Foundation


class network{
    
    private static let session = URLSession.shared
    
    //MARK: - GET METHOD
    
    class func loadData(page:Int,onComplete:@escaping (apiDecoder?)->Void){
        
        let apiUrl = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=\(page)"
        
        guard let url = URL(string: apiUrl)else{
            onComplete(nil)
            return}
        
        //Recebe os dados do servidor
        let dataTask = session.dataTask(with: url) { (data:Data?, response:URLResponse?, error) in
            if error == nil{
                guard let response = response as? HTTPURLResponse else{
                    print("repose error")
                    onComplete(nil)
                    return}
                //se resposta for ok
                if response.statusCode == 200{
                    //Armazenar os dados do servidor na variavel data
                    guard let data = data else{return}
                    
                    //Tranformar json em array
                    do{
                        let dados = try JSONDecoder().decode(apiDecoder?.self, from: data)
                        onComplete(dados)
                    }catch{
                        print("ERRO3",error)
                        onComplete(nil)
                    }
                }else{
                    print("Algum status inválido no servidor!!")
                    onComplete(nil)
                }
            }else{
                print("ERRO1")
                onComplete(nil)
            }
        }
        dataTask.resume()
    }
}
