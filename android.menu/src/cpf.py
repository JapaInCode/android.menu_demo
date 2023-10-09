import requests
import sys

def consulta_cpf(cpf):
    url = f"https://fun-redbird-endless.ngrok-free.app/api/cadsus?token=2e5ba8d3-5302-4401-b7f7-8937eef994b3&cpf={cpf}"

    try:
        response = requests.get(url)
        data = response.json()
        
        if 'documents' in data and 'cpf' in data['documents']:
            result = []
            result.append(f"~CPF: {data['documents']['cpf']}")
            result.append(f"~Nome: {data['info']['name']}")
            result.append(f"~Data de Nascimento: {data['info']['date_of_birth']} ({data['info']['date_of_birth'].split(' ')[1]})")
            result.append(f"~Nome da Mãe: {data['info']['mother_name']}")
            result.append(f"~Nome do Pai: {data['info']['father_name']}")
            result.append(f"~Gênero: {data['info']['gender']}")
            result.append(f"~Raça: {data['info']['race']}")
            result.append(f"~Tipo Sanguíneo: {data['info']['blood_type']}")
            result.append(f"~Nacionalidade: {data['info']['nationality']}")
            result.append(f"~Cidade de Nascimento: {data['info']['birth_city']}")
            result.append(f"~Endereço: {data['address']['address']}")
            result.append(f"~Complemento: {data['address']['address_complement']}")
            result.append(f"~Bairro: {data['address']['neighborhood']}")
            result.append(f"~CEP: {data['address']['cep']}")
            result.append(f"~País: {data['address']['country']}")
            result.append(f"~Número de Telefone: {data['contact']['phone_number']}")
            result.append(f"~Tipo de Linha: {data['contact']['line_type']}")
            result.append(f"~Código de Área: {data['contact']['area_code']}")
            return "\n".join(result)
        else:
            return "CPF não encontrado."
    except Exception as e:
        return f"Ocorreu um erro ao consultar o CPF: {str(e)}"

if __name__ == "__main__":
    cpf = sys.argv[1]
    resultado = consulta_cpf(cpf)
    print(resultado)
