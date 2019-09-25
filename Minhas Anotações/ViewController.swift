//
//  ViewController.swift
//  Minhas Anotações
//
//  Created by Treinamento on 9/18/19.
//  Copyright © 2019 JCAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var campoAnotacao: UITextView!
    
    let bancoDados = UserDefaults.standard
    
    let chave: String = "anotacao"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let anotacaoAnterior = bancoDados.string(forKey: chave) {
            campoAnotacao.text = anotacaoAnterior
        } else {
            campoAnotacao.text = "Escreva suas anotações."
        }
    }
    
    //Esconde a barra de status.
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Esconde o teclado.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Função cria um alerta na tela conforme os inputs.
    func criarAlerta(tituloPrincipal: String, menssagemPrincipal: String) {
        let alerta = UIAlertController(title: tituloPrincipal, message: menssagemPrincipal, preferredStyle: .alert)
        let alertaAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alerta.addAction(alertaAction)
        
        present(alerta, animated: true)
    }

    @IBAction func botaoSalvar(_ sender: Any) {
        if campoAnotacao.text.isEmpty { // se o campo extiver vázio executa:
            
            criarAlerta(tituloPrincipal: "Nāo foi possível salvar.", menssagemPrincipal: "O campo de texto nao possui dados válidos.")
            
        } else { // se o campo conter dados executa:
            if let texto = campoAnotacao.text {
                bancoDados.set(texto, forKey: chave)
                criarAlerta(tituloPrincipal: "Anotação Salva!", menssagemPrincipal: "")
            } else {
                criarAlerta(tituloPrincipal: "Nāo foi possível salvar.", menssagemPrincipal: "O campo de texto nao possui dados válidos.")
            }
        }
    }
    
    //Botão responsável por realizar o exclusão dos dos dados do user defaults e
    //deletar o texto do campo de texto.
    @IBAction func botaoDelete(_ sender: Any) {
        if campoAnotacao.text.isEmpty { // se o campo extiver vázio executa:
            criarAlerta(tituloPrincipal: "Nāo foi possível deletar.", menssagemPrincipal: "O campo de texto nao possui dados válidos.")
        } else { // se o campo conter dados executa:
            bancoDados.removeObject(forKey: chave)
            criarAlerta(tituloPrincipal: "Anotação Deletada!", menssagemPrincipal: "")
            campoAnotacao.text = ""
        }
    }
}

