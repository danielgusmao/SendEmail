# SendEmailPDF

Este Script server para converter arquivo em PDF e enviar por e-mail pelo terminal.

Programas usados: Enscript, ps2pdf e sendEmail.

Requisitos:

Desabilitar o SELinux:

https://wiki.hackstore.com.br

# vim /etc/sysconfig/selinux

Mude isso: SELINUX=enforcing
Para isso: SELINUX=disabled
Atualizar o sistema:

# yum -y update
Instalar o Enscript e o ps2pdf:

# yum install enscript ghostscript
Instalar o sendEmail: http://caspian.dotconf.net/menu/Software/SendEmail/

# yum -y install wget
# wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v1.56.tar.gz
# tar -zxvf sendEmail-v1.56.tar.gz
# cp -a sendEmail-v1.56/sendEmail /usr/local/bin
# chmod +x /usr/local/bin/sendEmail
# yum install perl.x86_64 perl-Net-SSLeay perl-IO-Socket-SSL
O pacote perl.x86_64 é importante porque se trata do interpretador Perl.
Já os pacotes perl-Net-SSLeay e perl-IO-Socket-SSL dão suporte a TLS (Transport Layer Security).

Referência: http://mytracelog.blogspot.com.br/2011/11/enviando-email-pelo-terminal-com.html

Para um melhor aproveitamento o script deve ser copiado na pasta /usr/local/bin e dada permissões de execução:

# chmod +x /usr/local/bin/geraPDF
No terminal utilize desta forma:

$ geraPDF arquivo_desejado.txt email_para@ser_enviado.com.br
Agora o Script.terminal

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

Copie e salve como geraPDF dentro da pasta /usr/local/bin
E dê permissão de execução

# chmod +x /usr/local/bin/geraPDF
www.danielgusmao.com.br
