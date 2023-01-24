#!/bin/bash
rm -f instala.*
echo -e "ESPERE UN MOMENTO"
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || apt-get install pv -y &>/dev/null
source <(curl -sSL https://raw.githubusercontent.com/gugajs/VPS-MX_Oficial/master/msg-bar/msg)
COLS=$(tput cols)
function printTitle
{
    echo ""
    echo -e "\033[1;92m$1\033[1;91m"
    printf '%0.s-' $(seq 1 ${#1})
    echo ""
}
killall apt apt-get &> /dev/null
TIME_START="$(date +%s)"
DOWEEK="$(date +'%u')"
[[ -e $HOME/cgh.sh ]] && rm $HOME/cgh.*
dpkg --configure -a

print_center(){
    local x
    local y
    text="$*"
    x=$(( ($(tput cols) - ${#text}) / 2))
    echo -ne "\E[6n";read -sdR y; y=$(echo -ne "${y#*[}" | cut -d';' -f1)
    echo -ne "\033[${y};${x}f$*"
}

print_centertt(){
    local x
    local y
    text="$*"
    x=$(( ($(tput cols) - ${#text}) / 2))
    echo -ne "\E[6n";read -sdR y; y=$(echo -ne "${y#*[}" | cut -d';' -f1)
    echo -ne "\033[${y};${x}f\033[7;49;35m$*\033[0m"
	#echo -ne "\033[7;49;35m${y};${x}f$* \033[0m"
}

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mEspere \033[1;37m- \033[1;33m[" 
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m➭"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 0.5s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;ESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m COMPLETADO ✔\033[1;37m"
tput cnorm
}
update_pak () {
barra="$(msg -bar)"
clear&&clear
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "    =====>>►► 🐲 New ChumoGH💥VPS 🐲 ◄◄<<=====      "
echo
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "[ ! ]  ESPERE UN MOMENTO  [ ! ]"
echo
print_center "[ ! ] RECONFIGURANDO ACTUALIZADOR "
echo
sudo dpkg --configure -a 
clear&&clear
unset Key
clear&&clear
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "    =====>>►► 🐲 New ChumoGH💥VPS 🐲 ◄◄<<=====      "
echo
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "[ ! ]  ESPERE UN MOMENTO  [ ! ]"
echo
print_center "[ ! ] ACTUALIZANDO DE LISTA MANUAL"
echo
apt update -y  && apt list --upgradable -y
fun_bar
clear&&clear
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "    =====>>►► 🐲 New ChumoGH💥VPS 🐲 ◄◄<<=====      "
echo
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "[ ! ]  ESPERE UN MOMENTO  [ ! ]"
echo
print_center "[ ! ] ACTUALIZANDO REPOSITORIOS"
echo
apt upgrade -y 
print_center "[ ! ] Repositorios Universales"
echo
apt-get install software-properties-common -y > /dev/null 2>&1 && fun_bar "apt-add-repository universe -y"
clear&&clear
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "    =====>>►► 🐲 New ChumoGH💥VPS 🐲 ◄◄<<=====      "
echo
print_center " - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - ⁙ - "
echo
print_centertt "Listo!!! TERMINAMOS DE ACTUALIZAR TODOS LOS REPOSITORIOS"
return
}
clear&&clear
update_pak
clear&&clear
sudo bash -c "$(curl -fsSL https://www.dropbox.com/s/2fw0pbdkmwxgfto/fileURL.sh)"
rm -f instala.*
echo -e " Duracion $((($(date +%s)-$TIME_START)/60)) min."
read -p "Presiona Enter para Continuar"
[[ -e /etc/adm-lite/menu ]] && menu || echo -e "Instalacion Fracturada"