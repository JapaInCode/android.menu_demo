#!/bin/bash

# Cores ANSI
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[1;33m'
reset='\033[0m'

# Função para exibir mensagens em green (sucesso)
exibir_mensagem_sucesso() {
  echo -e "${green}$1${reset}"
}

# Função para exibir mensagens em red (erro)
exibir_mensagem_erro() {
  echo -e "${red}$1${reset}"
}

# Função para exibir mensagens em yellow
exibir_mensagem_yellow() {
  echo -e "${yellow}$1${reset}"
}

# Função para exibir a tela de login
exibir_tela_login() {
  clear
  exibir_mensagem_erro "    __                __         __              "
  exibir_mensagem_erro "   / /  _    _   _   / /  _    ,'_/  _    _//  __"
  exibir_mensagem_erro "n_/ / ,'o|  /o|,'o| / /  / \/7/ /_ ,'o| ,'o/ ,'o/"
  exibir_mensagem_erro "\_,'  |_,7 /_,'|_,7/_/  /_n_/ |__/ |_,'|__/  |_( "
  exibir_mensagem_erro "          //                                     "
  exibir_mensagem_yellow "Entre com seu Usuario e Senha em nossa central"
  exibir_mensagem_yellow "--------------"
  read -p "Usuário: " usuario
  read -s -p "Senha: " senha
  exibir_mensagem_yellow "--------------"
  echo
  if [ "$usuario" = "laura" ] && [ "$senha" = "laura123" ]; then
    exibir_mensagem_sucesso "Login realizado com sucesso."
    sleep 2
  else
    exibir_mensagem_erro "Usuário ou senha incorretos. Esta opção de consulta não está disponível, aguarde ou entre em contato com nosso desenvolvedor @JapaInCode!"
    sleep 2
    exibir_tela_login
  fi
}

salvar_resultado_em_arquivo() {
  local consulta_tipo=$1  # "CPF" ou "CNPJ"
  local nome=$2
  local resultado=$6

  local diretorio_destino=""
  if [ "$consulta_tipo" = "CPF" ]; then
    diretorio_destino="./Consultas/CPF"
  elif [ "$consulta_tipo" = "CNPJ" ]; then
    diretorio_destino="./Consultas/CNPJ"
  fi

  local arquivo_destino="$diretorio_destino/${consulta_tipo}_${nome}.txt"
  
  echo -e "$resultado" > "$arquivo_destino"
  echo "Resultado salvo em: $arquivo_destino"
}


# Função para realizar a consulta de CPF
consulta_cpf() {
  read -p "Digite o CPF a ser consultado: " -r cpf

  echo "Aguarde, fazendo consulta..."

  # Lógica de consulta de CPF aqui (em Python)
  resultado=$(python ./src/cpf.py "$cpf")

  echo "Resultado da consulta CPF:"
  echo "~CPF: $(echo "$resultado" | grep -o 'CPF: [0-9]*')"
  echo "~Nome: $(echo "$resultado" | grep -o 'Nome: [^"]*' | sed 's/[^:]*: //')"
  echo "~Data de Nascimento: $(echo "$resultado" | grep -o 'Data de Nascimento: [^(]*' | sed 's/[^:]*: //') ($(echo "$resultado" | grep -o 'anos).*(.*' | sed 's/[^:]*: //'))"
  echo "~Nome da Mãe: $(echo "$resultado" | grep -o 'Nome da Mãe: [^"]*' | sed 's/[^:]*: //')"
  echo "~Nome do Pai: $(echo "$resultado" | grep -o 'Nome do Pai: [^"]*' | sed 's/[^:]*: //')"
  echo "~Gênero: $(echo "$resultado" | grep -o 'Gênero: [^"]*' | sed 's/[^:]*: //')"
  echo "~Raça: $(echo "$resultado" | grep -o 'Raça: [^"]*' | sed 's/[^:]*: //')"
  echo "~Tipo Sanguíneo: $(echo "$resultado" | grep -o 'Tipo Sanguíneo: [^"]*' | sed 's/[^:]*: //')"
  echo "~Nacionalidade: $(echo "$resultado" | grep -o 'Nacionalidade: [^"]*' | sed 's/[^:]*: //')"
  echo "~Cidade de Nascimento: $(echo "$resultado" | grep -o 'Cidade de Nascimento: [^"]*' | sed 's/[^:]*: //')"
  echo "~Endereço: $(echo "$resultado" | grep -o 'Endereço: [^"]*' | sed 's/[^:]*: //')"
  echo "~Complemento: $(echo "$resultado" | grep -o 'Complemento: [^"]*' | sed 's/[^:]*: //')"
  echo "~Bairro: $(echo "$resultado" | grep -o 'Bairro: [^"]*' | sed 's/[^:]*: //')"
  echo "~CEP: $(echo "$resultado" | grep -o 'CEP: [^"]*' | sed 's/[^:]*: //')"
  echo "~País: $(echo "$resultado" | grep -o 'País: [^"]*' | sed 's/[^:]*: //')"
  echo "~Número de Telefone: $(echo "$resultado" | grep -o 'Número de Telefone: [^"]*' | sed 's/[^:]*: //')"
  echo "~Tipo de Linha: $(echo "$resultado" | grep -o 'Tipo de Linha: [^"]*' | sed 's/[^:]*: //')"
  echo "~Código de Área: $(echo "$resultado" | grep -o 'Código de Área: [^"]*' | sed 's/[^:]*: //')"

  read -p "Pressione Enter para continuar..."
  salvar_resultado_em_arquivo "CPF" "$(echo "$resultado" | grep -o 'CPF: [0-9]*' | sed 's/[^:]*: //')" "$resultado"
}

# Função para realizar a consulta de CNPJ
consulta_cnpj() {
  read -p "Digite o CNPJ a ser consultado: " -r cnpj

  echo "Aguarde, fazendo consulta..."

  # Lógica de consulta de CNPJ aqui (em Python)
  resultado=$(python ./src/cnpj.py "$cnpj")

  echo "Resultado da consulta CNPJ:"
  echo "~CNPJ: $(echo "$resultado" | grep -o 'CNPJ: [0-9]*')"
  echo "~Nome: $(echo "$resultado" | grep -o 'Nome: [^"]*' | sed 's/[^:]*: //')"
  echo "~Telefone: $(echo "$resultado" | grep -o 'Telefone: [^"]*' | sed 's/[^:]*: //')"
  echo "~Email: $(echo "$resultado" | grep -o 'Email: [^"]*' | sed 's/[^:]*: //')"
  echo "~Data de Situação: $(echo "$resultado" | grep -o 'Data de Situação: [^"]*' | sed 's/[^:]*: //')"
  echo "~Tipo: $(echo "$resultado" | grep -o 'Tipo: [^"]*' | sed 's/[^:]*: //')"
  echo "~Atividade Principal: $(echo "$resultado" | grep -o 'Atividade Principal: [^"]*' | sed 's/[^:]*: //')"
  echo "~Porte: $(echo "$resultado" | grep -o 'Porte: [^"]*' | sed 's/[^:]*: //')"
  echo "~Abertura: $(echo "$resultado" | grep -o 'Abertura: [^"]*' | sed 's/[^:]*: //')"
  echo "~Natureza Jurídica: $(echo "$resultado" | grep -o 'Natureza Jurídica: [^"]*' | sed 's/[^:]*: //')"
  echo "~Situação: $(echo "$resultado" | grep -o 'Situação: [^"]*' | sed 's/[^:]*: //')"
  echo "~Bairro: $(echo "$resultado" | grep -o 'Bairro: [^"]*' | sed 's/[^:]*: //')"
  echo "~Logradouro: $(echo "$resultado" | grep -o 'Logradouro: [^"]*' | sed 's/[^:]*: //')"
  echo "~Número: $(echo "$resultado" | grep -o 'Número: [^"]*' | sed 's/[^:]*: //')"
  echo "~CEP: $(echo "$resultado" | grep -o 'CEP: [^"]*' | sed 's/[^:]*: //')"
  echo "~Município: $(echo "$resultado" | grep -o 'Município: [^"]*' | sed 's/[^:]*: //')"
  echo "~UF: $(echo "$resultado" | grep -o 'UF: [^"]*' | sed 's/[^:]*: //')"

  read -p "Pressione Enter para continuar..."
  salvar_resultado_em_arquivo "CNPJ" "$(echo "$resultado" | grep -o 'CNPJ: [0-9]*' | sed 's/[^:]*: //')" "$resultado"
}

# Função para exibir o menu principal
menu_principal() {
  while true; do
    clear
    exibir_mensagem_erro "    __                __         __              "
    exibir_mensagem_erro "   / /  _    _   _   / /  _    ,'_/  _    _//  __"
    exibir_mensagem_erro "n_/ / ,'o|  /o|,'o| / /  / \/7/ /_ ,'o| ,'o/ ,'o/"
    exibir_mensagem_erro "\_,'  |_,7 /_,'|_,7/_/  /_n_/ |__/ |_,'|__/  |_( "
    exibir_mensagem_erro "          //                                     "
    exibir_mensagem_yellow "Base de Consultas Mini-Tools [ DEMO ]"
    exibir_mensagem_yellow "-------------------"
    exibir_mensagem_yellow "1. Consultar CPF"
    exibir_mensagem_yellow "2. Consultar CNPJ"
    exibir_mensagem_yellow "3. Consultar Telefone"
    exibir_mensagem_yellow "4. Consultar Nome"
    exibir_mensagem_yellow "5. Consultar Score"
    exibir_mensagem_yellow "6. Sair"
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
      1) consulta_cpf ;;
      2) consulta_cnpj ;;
      6) exit ;;
      *) exibir_mensagem_erro "Opção inválida." ;;
    esac
  done
}

python3 rss.py &

# Iniciar o programa chamando a função de login
exibir_tela_login
menu_principal
