//
//  ViewController.swift
//  Atividade09
//
//  Created by COTEMIG on 10/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblAltura: UILabel!
    @IBOutlet weak var lblPeso: UILabel!
    @IBOutlet weak var lblResultado: UILabel!
    @IBOutlet weak var lblIMC: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var altura: Float = 0.0
    private var peso: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segmentedControl.setTitle("Masculino", forSegmentAt: 0)
        self.segmentedControl.setTitle("Feminino", forSegmentAt: 1)
        self.segmentedControl.selectedSegmentIndex = -1
        
        self.lblIMC.text = ""
        self.lblResultado.text = ""
        self.altura = 165
        self.peso = 65

    }


    @IBAction func aoAlterarAltura(_ sender: Any) {
        if let valor = (sender as? UISlider)?.value {
            self.altura = valor
            self.lblAltura.text = "\(formatarValor(valor: valor))cm"
            self.calcularIMC()
        }
            
    }
    @IBAction func aoAlterarPeso(_ sender: Any) {
        if let valor = (sender as? UISlider)?.value {
            self.peso = valor
            self.lblPeso.text = "\(formatarValor(valor: valor))kg"
            self.calcularIMC()
        }
    }
    
    private func calcularIMC() {
        let imc = self.peso / pow((self.altura / 100), 2)
        self.lblIMC.text = "\(formatarValor(valor: imc))"
        
        if self.segmentedControl.selectedSegmentIndex > -1 {
            switch self.segmentedControl.selectedSegmentIndex{
            case 0:
                exibirResultadoMasculino(imc)
            default:
                exibirResultadoFeminino(imc: imc)
            }
            
        } else {
            self.lblResultado.text = "Defina peso, altura e biotipo."
        }
    }


    private func formatarValor(valor: Float) -> String {
        let formatador = NumberFormatter()
        formatador.numberStyle = .decimal
        formatador.maximumFractionDigits = 1
        return formatador.string(from: NSNumber(value: valor))!
    }

    private func exibirResultadoMasculino(_ imc: Float){
        switch imc {
        case 0..<18.0:
            self.lblResultado.text = "Abaixo do peso."
        case 18.0..<24.9:
            self.lblResultado.text = "Peso normal."
        case 24.9..<29.9:
            self.lblResultado.text = "Pré-obesidade."
        case 29.9..<34.9:
            self.lblResultado.text = "Obesidade nível 1."
        case 34.9..<39.9:
            self.lblResultado.text = "Obesidade nível 2."
        default:
            self.lblResultado.text = "Obesidade nível 3."
        }
    }

    private func exibirResultadoFeminino(imc: Float){
        switch imc {
        case 0..<17.8:
            self.lblResultado.text = "Abaixo do peso."
        case 17.8..<24.6:
            self.lblResultado.text = "Peso normal."
        case 24.6..<28.8:
            self.lblResultado.text = "Pré-obesidade."
        case 28.8..<34.6:
            self.lblResultado.text = "Obesidade nível 1."
        case 34.6..<39.7:
            self.lblResultado.text = "Obesidade nível 2."
        default:
            self.lblResultado.text = "Obesidade nível 3."
        }
    }
    
    @IBAction func aoAlterarBiotipo(_ sender: Any) {
        self.calcularIMC()
    }
}
