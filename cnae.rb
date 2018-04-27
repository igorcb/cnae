require 'net/http'
require 'json'

module Cnae
  
  def self.banks
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/igorcb/cnae/master/cnae.json').body
  end

  def self.populate
    cnae.each do |cnae|
      cnae = Atividade.create_with(cnae: cnae["Código CNAE 2.1"], 
      														 descricao_cnae: cnae["Descrição do Código CNAE 2.0"]
      														 item_lista: cnae["Item da Lista"]
      														 descricao_item_lista: cnae["Descrição do Item da Lista (LC Nº 116/2003)"]
      														 ).find_or_create_by(nome: cnae["Código CNAE 2.1"])
    end
  end
end

Cnae.populate