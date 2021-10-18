//
//  CakeListViewController.swift
//  CakeItApp
//
//  Created by David McCallum on 20/01/2021.
//

import UIKit

class CakeListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var i = 0
    var cakes: [Cake] = []
    var cakeToSend : Cake?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "🎂CakeItApp🍰"
        
        
        
        if let url = URL(string: "https://gist.githubusercontent.com/hart88/79a65d27f52cbb74db7df1d200c4212b/raw/ebf57198c7490e42581508f4f40da88b16d784ba/cakeList")
        {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request)
            { data, response, error in
                if let decodedResponse = try? JSONDecoder().decode([Cake].self, from: data!) {
                    self.cakes = decodedResponse
                    
                    DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
                    return
                }
            }.resume()
            
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue") {
            if let vc = segue.destination as? CakeDetailViewController
            {
                vc.cake = self.cakeToSend
            }
        }
    }
}

extension CakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        self.cakeToSend = self.cakes[i]
        performSegue(withIdentifier: "segue", sender: tableView)
    }
    
}

extension CakeListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CakeTableViewCell
        let cake = cakes[indexPath.row]
        cell.titleLabel.text = cake.title
        cell.descLabel.text = cake.desc
        
        
        if let imageURL = URL(string: cake.image)
        {
            
            cell.cakeImageView.loadImage(at: imageURL)
            
//            guard let imageData = try? Data(contentsOf: imageURL) else { return cell }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                cell.cakeImageView.image = image
//            }
        }
        return cell
    }
}

