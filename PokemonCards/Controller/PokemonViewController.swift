//
//  PokemonViewController.swift
//  PokemonCards
//
//  Created by Arkadijs Makarenko on 21/04/2023.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var pokey: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokémon List"
        getPokemonData()
    }
    
    func getPokemonData(){
        let jsonUrl = "https://api.pokemontcg.io/v1/cards"
        
        guard let url = URL(string: jsonUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            if error != nil {
                print((error?.localizedDescription)!)
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Pokemon.self, from: data)
                dump(jsonData)
                self.pokey = jsonData.cards
                
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                }
                
            }catch{
                print("error:::::" , error)
            }
            
            
        }.resume()
        
    }
    
    
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokeyTableViewCell else {
            return UITableViewCell()
        }
        let poke = pokey[indexPath.row]
        cell.setupUI(withDataFrom: poke)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
#warning("use a segue to pass  var pokey: [Card] to a DetailVC")
    
}

