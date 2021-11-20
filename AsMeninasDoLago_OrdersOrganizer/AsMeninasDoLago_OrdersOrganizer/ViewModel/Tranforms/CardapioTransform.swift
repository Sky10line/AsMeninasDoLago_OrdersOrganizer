//
//  CardapioTransform.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 19/11/21.
//

import Foundation

struct CardapioTransform {
	var entity: [CategoryJSON]
	
	init(json: Cardapio) {
		let bebidas = BebidasTransform(json: json.bebidas).entity
		let caldos = CaldosTransform(json: json.caldos).entity
		let escondidinhos = EscondidinhosTransform(json: json.escondidinhos).entity
		let lanches = LanchesTransform(json: json.lanches).entity
		let porcoes = PorcoesTransform(json: json.porcoes).entity
		let salgados = SalgadosTransform(json: json.salgados).entity
		let tapiocas = TapiocasTransform(json: json.tapiocas).entity
		
		entity = [bebidas, caldos, escondidinhos, lanches, porcoes, salgados, tapiocas]
	}
}


