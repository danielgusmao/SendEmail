#!/bin/bash

######################################
# Script Criado por: Daniel Gusmão   #
# Email: dangusmao@hotmail.com       #
# Site: www.danielgusmao.com.br      #
######################################

FILE=$1
EMAIL=$2
REMETENTE="email@remetente.com.br"
ASSUNTO="Segue arquivo ( ${FILE%%.*}.pdf ) Anexo"
CORPO="E-mail enviado automaticamente."
SMTP="smtp.seuprovedor.com.br:587"
USUARIO="Seu_Usuário"
SENHA="Sua_Senha"

enscript ${FILE} -o ${FILE}.ps | ps2pdf ${FILE}.ps ${FILE%%.*}.pdf

if [ ! -z ${EMAIL} ] ; then
        sendEmail -f ${REMETENTE} -t ${EMAIL} -u "${ASSUNTO}" -m "${CORPO}" -a ${FILE%%.*}.pdf -s ${SMTP} -xu ${USUARIO} -xp ${SENHA}

rm *.ps
