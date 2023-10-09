import requests
import sys

def consulta_cnpj(cnpj):
    url = f"https://www.receitaws.com.br/v1/cnpj/{cnpj}"

    try:
        response = requests.get(url)
        data = response.json()

        if 'atividade_principal' in data and len(data['atividade_principal']) > 0:
            result = []
            result.append(f"~CNPJ: {data['cnpj']}")
            result.append(f"~Nome: {data['nome']}")
            result.append(f"~Telefone: {data['telefone']}")
            result.append(f"~Email: {data['email']}")
            result.append(f"~Data de Situação: {data['data_situacao']}")
            result.append(f"~Tipo: {data['tipo']}")
            result.append(f"~Atividade Principal: {data['atividade_principal'][0]['text']}")
            result.append(f"~Porte: {data['porte']}")
            result.append(f"~Abertura: {data['abertura']}")
            result.append(f"~Natureza Jurídica: {data['natureza_juridica']}")
            result.append(f"~Situação: {data['situacao']}")
            result.append(f"~Bairro: {data['bairro']}")
            result.append(f"~Logradouro: {data['logradouro']}")
            result.append(f"~Número: {data['numero']}")
            result.append(f"~CEP: {data['cep']}")
            result.append(f"~Município: {data['municipio']}")
            result.append(f"~UF: {data['uf']}")
            return "\n".join(result)
        else:
            return "Não foi possível obter informações para o CNPJ fornecido."
    except Exception as e:
        return f"Ocorreu um erro ao consultar o CNPJ: {str(e)}"

if __name__ == "__main__":
    cnpj = sys.argv[1]
    resultado = consulta_cnpj(cnpj)
    print(resultado)
