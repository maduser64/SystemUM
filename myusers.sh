#!/bin/bash
#/////////////////////////////////////////////////////////
# Página: mundohackers.es
# Correo: mrr8b83@gmail.com
#
# Copyright (c) 2017 mundohackers.es
#/////////////////////////////////////////////////////////

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

usage(){

  echo " "
  echo -e "$blueColour Uso -> $redColour[-h | --help] [-u username | --user username] [-n username] [-l number| --last number] [-t | --time]$endColour $endColour "
  echo -e "$redColour        [ TIME ]$endColour "
  echo " "

}

usuario_parametro(){

  echo " "
  echo -e "$yellowColour Analizando correspondencia de usuario...$endColour"
  sleep 2
  echo " "

  #Si el usuario pertenece al grupo 333, entonces
  if [ "$(getent passwd | grep $usuario | cut -d ':' -f 4)" = "333" ]; then
    echo -e "El usuario $blueColour$usuario$endColour es un$redColour Alumno$endColour"
    echo " "
    sleep 1
  elif [ "$(getent passwd | grep $usuario | cut -d ':' -f 4)" = "310" ]; then
    echo -e "El usuario $blueColour$usuario$endColour es un$redColour Profesor$endColour"
    echo " "
    sleep 1
  fi
  echo "($usuario)" > usuarioPar
  echo -e "$greenColour$(getent passwd | grep $usuario | cut -d ':' -f 5)$endColour" >> usuarioP
  paste -d " " usuarioPar usuarioP >> usuario_final
  cat usuario_final

  rm usuarioP usuarioPar

  echo " "
  sleep 2
  echo -e "$yellowColour Listando procesos del usuario $usuario$endColour"
  echo " "
  sleep 2
  echo -e "$redColour$usuario$endColour $purpleColour->$endColour $blueColour$(ps -fea | cut -d ' ' -f 1 | grep $usuario | wc -l) procesos abiertos$endColour" >> procesosU

  cat procesosU
  sleep 2
  cat procesosU | cut -d ' ' -f 2-5 >> procesosU_
  rm procesosU
  mv procesosU_ procesosU
  paste -d " " usuario_final procesosU >> info_user
  echo " "
  echo -e "$greenColour~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat info_user
  echo -e "$greenColour~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "
  sleep 2
  echo -e "$yellowColour Analizando tipo de usuario...$endColour"
  echo " "
  sleep 2
  if [ "$(getent passwd | grep $usuario | cut -d ':' -f 3)" -ge "1000" ]; then
    echo -e "$greenColour$usuario$endColour $purpleColour[$endColour$redColour Usuario Convencional$endColour $purpleColour]$endColour" >> tipo_usuarioP
  fi
  if [ "$(getent passwd | grep $usuario | cut -d ':' -f 3)" -eq "0" ]; then
    echo -e "$greenColour$usuario$endColour $purpleColour[$endColour$redColour root$endColour $purpleColour]$endColour" >> tipo_usuarioP
  fi
  if [ "$(getent passwd | grep $usuario | cut -d ':' -f 3)" -ge "1" ] && [ "$(getent passwd | grep $usuario | cut -d ':' -f 3)" -le "99" ]; then
    echo -e "$greenColour$usuario$endColour $purpleColour[$endColour$redColour Usuario Predefinido con Fines Administrativos$endColour $purpleColour]$endColour" >> tipo_usuarioP
  fi
  if [ "$(getent passwd | grep $usuario | cut -d ':' -f 3)" -ge "100" ] && [ "$(getent passwd | grep $usuario | cut -d ':' -f 3)" -le "900" ]; then
    echo -e "$greenColour$usuario$endColour $purpleColour[$endColour$redColour Usuario Adminsitrador$endColour $purpleColour]$endColour" >> tipo_usuarioP
  fi
  cat tipo_usuarioP
  echo " "
  sleep 2
  cat tipo_usuarioP | cut -d ' ' -f 2-8 >> tipo_usuarioPSF
  paste -d " " info_user tipo_usuarioPSF >> final_info_userP
  echo -e "$greenColour~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat final_info_userP
  echo -e "$greenColour~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"

  rm info_user procesosU ti* usuario_final

  echo " "
  sleep 2

  if [ "$(getent passwd | grep $usuario | cut -d ':' -f 7)" = "/bin/bash" ]; then
    echo -e "$purpleColour$usuario$endColour $yellowColour||$endColour$greenColour Shell de arranque válida$endColour" >> comprobacionP
  elif [ "$(getent passwd | grep $usuario | cut -d ':' -f 7)" = "/bin/false" ]; then
    echo -e "$purpleColour$usuario$endColour $yellowColour||$endColour$greenColour Es un usuario interno$endColour" >> comprobacionP
  fi

  cat comprobacionP
  echo " "
  sleep 2
  cat comprobacionP | cut -d ' ' -f 2-6 >> comprobacionPST
  paste -d " " final_info_userP comprobacionPST >> fichero_finalP
  echo -e "$greenColour~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat fichero_finalP
  echo -e "$greenColour~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  sleep 2
  echo " "
  rm comprobacionP comprobacionPST final_info_userP

  echo -e "$yellowColour Se van a mostrar los procesos del usuario$endColour $blueColour$usuario$endColour$yellowColour || $(getent passwd | grep $usuario | cut -d ':' -f 5)$endColour"
  sleep 4
  echo " "
  ps -fea | grep $usuario > procesosUser
  sed '/root/d' procesosUser > procesos_User
  cat procesosUser | cut -d ':' -f 4-7 > nombre_procesos
  cat nombre_procesos  | cut -d ' ' -f 2-7 > nombre_procesos_final
  rm nombre_procesos procesosUser
  mv nombre_procesos_final nombre_procesos
  sed '/grep/d' nombre_procesos > nombre_procesosS
  rm nombre_procesos
  mv nombre_procesosS nombre_procesos
  cat nombre_procesos
  echo " "
  echo -e "$yellowColour $(cat nombre_procesos | wc -l) procesos ejecutándose$endColour"
  echo " "
  rm nombre_procesos procesos_User
  sleep 2
  exit

}

recent_connection(){

  echo " "
  echo -e "$yellowColour Listando los $number accesos más recientes al sistema...$endColour"
  echo " "
  sleep 3
  last -ain $number
  sleep 4
  last -ain $number >> last_users
  cat last_users | cut -d ' ' -f 3-24 >> last_users_cut
  cat last_users | cut -d ' ' -f 1 >> alu_users
  sed '/wtmp/d' alu_users >> alu_users2
  rm alu_users
  mv alu_users2 alu_users
  while read line
    do
      getent passwd | grep $line | cut -d ':' -f 5 >> alu_nombres
  done < alu_users
  rm alu_users
  paste -d " " alu_nombres last_users_cut >> infouser
  clear
  echo " "
  echo -e "$yellowColour Se van a listar los nombres de usuario correspondientes...$endColour"
  echo " "
  sleep 3
  cat infouser
  rm la* infouser alu_nombres
  echo " "
  sleep 1
  echo -e "$yellowColour Recuperando lista anterior semejante...$endColour"
  echo " "
  sleep 2
  last -ain $number >> last_users
  cat last_users
  rm last_users
  echo " "
  exit

}

time_user(){

  #Usuarios que tienen procesos ejecutándose actualmente
  ps -ef | cut -d ' ' -f 1 | sort -u >> usuarios_activos

  #Eliminación de contenido no deseado
  sed '/68/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/root/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/apache/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/gdm/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/mysql/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/postfix/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpc/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpcuser/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/tomcat/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/UID/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/xfs/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/dbus/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/colord/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/kernoops/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/message+/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rtkit/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/statd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/syslog/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/whoopsie/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/oracle/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/smmsp/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/sshd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  #----------------------------------------------------------

  echo " "
  echo -e "$yellowColour Se han detectado los siguientes usuarios conectados al sistema con procesos abiertos..."
  sleep 4
  echo " "
  echo -e "$blueColour$(cat usuarios_activos)$endColour"
  echo " "
  echo -e "$greenColour$(cat usuarios_activos | wc -l) usuarios con procesos abiertos$endColour"
  echo " "
  sleep 2
  echo -e "$yellowColour Se van a mostrar las horas de entrada de los usuarios conectados al sistema...$endColour"
  echo " "
  sleep 3
  while read line
    do
      echo "El usuario $line entró al sistema a las $(last $line | head -n 1 | cut -d 'N' -f 2)" >> timeuser
  done < usuarios_activos
  cat timeuser | cut -d ' ' -f 1-8 >> message
  cat timeuser | cut -d ' ' -f 11 >> hour
  paste -d " " message hour >> finalTime
  cat finalTime
  echo " "
  rm finalTime hour message timeuser usuarios_activos
  date | cut -d ' ' -f 4 >> hora_actual
  cat hora_actual | cut -d ':' -f 1-2 >> hora_final
  rm hora_actual
  mv hora_final hora_actual
  echo -e "Actualmente son las: $yellowColour$(cat hora_actual)$endColour"
  echo " "
  rm hora_actual
  exit

}

no_user_filter(){

  #Usuarios que tienen procesos ejecutándose actualmente
  ps -ef | cut -d ' ' -f 1 | sort -u >> usuarios_activos

  #Eliminación de contenido no deseado
  sed '/68/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/root/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/apache/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/gdm/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/mysql/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/postfix/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpc/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpcuser/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/tomcat/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/UID/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/xfs/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/dbus/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/colord/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/kernoops/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/sshd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/message+/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rtkit/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/statd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/syslog/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/whoopsie/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/oracle/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/smmsp/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  #----------------------------------------------------------

  echo " "
  echo -e "$yellowColour Se han detectado los siguientes usuarios conectados al sistema con procesos abiertos..."
  sleep 4
  echo " "
  echo -e "$blueColour$(cat usuarios_activos)$endColour"
  echo " "
  echo -e "$greenColour$(cat usuarios_activos | wc -l) usuarios con procesos abiertos$endColour"
  echo " "
  sleep 2
  echo -e "$purpleColour*************************************************$endColour"
  echo -e "$yellowColour Se suprimirá el usuario $noUser de la lista...$endColour"
  echo " "

  sleep 2
  sed "/$noUser/d" usuarios_activos >> usuarios_activos_filter
  rm usuarios_activos
  mv usuarios_activos_filter usuarios_activos
  echo -e "$blueColour$(cat usuarios_activos)$endColour"
  echo " "
  sleep 2
  echo -e "$yellowColour Analizando usuarios alu...$endColour"
  echo " "
  sleep 2
  while read line
    do
      getent passwd | grep $line | cut -d ':' -f 5 >> usuarios_entero # Almacenamiento de nombre y apellidos de usuarios en fichero
  done < usuarios_activos

  cat usuarios_entero | cut -d ',' -f 2 >> nombre_usuarios
  cat usuarios_entero | cut -d ',' -f 1 >> apellido_usuarios

  paste -d " " nombre_usuarios apellido_usuarios >> info_panel
  paste -d " " info_panel usuarios_activos >> final_info
  cat final_info | sort >> info_ordenada #Último fichero con información total del usuario

  rm info_panel nombre_usuarios apellido_usuarios usuarios_entero

  echo -e "$greenColour ******************************************$endColour"
  cat info_ordenada
  echo -e "$greenColour ******************************************$endColour"
  echo " "
  sleep 2
  echo -e "$yellowColour Procesos de usuario...$endColour"
  echo " "
  sleep 2
  while read line
    do
      echo -e "$redColour$line$endColour $purpleColour->$endColour $blueColour$(ps -fea | cut -d ' ' -f 1 | grep $line | wc -l) procesos abiertos$endColour" >> num_procesos
  done < usuarios_activos

  cat num_procesos
  echo " "
  echo -e "$yellowColour Analizando correspondencia de usuario...$endColour"
  echo " "
  sleep 2
  cat num_procesos | cut -d ' ' -f 2-5 >> procesos_usuariosSF
  paste -d " " final_info procesos_usuariosSF >> procesos_usuario
  cat procesos_usuario | sort >> procesos_ordenados

  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat procesos_ordenados
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "
  sleep 2

  rm final_info procesos_usuariosSF info_ordenada num_procesos

  echo -e "$yellowColour Análisis de tipo de usuario...$endColour"
  echo " "
  sleep 2

  while read line
    do
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -ge "1000" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour Usuario Convencional$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -eq "0" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour root$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -ge "1" ] && [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -le "99" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour Usuario Predefinido con Fines Administrativos$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -ge "100" ] && [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -le "900" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour Usuario Adminsitrador$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
  done < usuarios_activos

  cat tipo_usuario
  echo " "
  sleep 2

  cat tipo_usuario | cut -d ' ' -f 2-8 >> tipo_usuarioSF
  paste -d " " procesos_ordenados tipo_usuarioSF >> procesos_tipo_usuario
  cat procesos_tipo_usuario | sort >> procesosTU_ordenados

  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat procesosTU_ordenados
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "
  sleep 2

  rm procesos_ordenados procesos_tipo_usuario procesos_usuario tipo_usuario tipo_usuarioSF

  echo -e "$yellowColour Comprobando si el usuario tiene una shell de arranque válida..."
  sleep 2
  echo " "
  while read line
    do
      if [ "$(getent passwd | grep $line | cut -d ':' -f 7)" = "/bin/bash" ]; then
        echo -e "$purpleColour$line$endColour $yellowColour||$endColour$greenColour Shell de arranque válida$endColour" >> comprobacion
      elif [ "$(getent passwd | grep $line | cut -d ':' -f 7)" = "/bin/false" ]; then
        echo -e "$purpleColour$line$endColour $yellowColour||$endColour$greenColour Es un usuario interno$endColour" >> comprobacion
      fi

  done < usuarios_activos

  cat comprobacion
  sleep 2

  cat comprobacion | cut -d ' ' -f 2-6 >> comprobacionST
  paste -d " " procesosTU_ordenados comprobacionST >> fichero_final
  cat fichero_final | sort >> final_ordenado

  echo " "
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat final_ordenado
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "

  rm comprobacion comprobacionST fichero_final procesosTU_ordenados

  sleep 2
  echo -e "$yellowColour Se van a listar los procesos de cada usuario$endColour"
  echo " "
  sleep 2
  while read line
    do
      sleep 1
      echo -e "$greenColour -------------------------------$endColour"
      sleep 1
      echo -e "$purpleColour ***********************************************$endColour"
      echo -e "$blueColour Usuario$endColour $redColour$line$endColour $greenColour||$endColour $(getent passwd | grep $line | cut -d ':' -f 5)"
      echo -e "$purpleColour ***********************************************$endColour"
      sleep 2
      echo " "
      ps -fea | grep $line > procesosUser
      sed '/root/d' procesosUser > procesos_User
      cat procesosUser | cut -d ':' -f 4-7 > nombre_procesos
      cat nombre_procesos  | cut -d ' ' -f 2-7 > nombre_procesos_final
      rm nombre_procesos procesosUser
      mv nombre_procesos_final nombre_procesos
      sed '/grep/d' nombre_procesos > nombre_procesosS
      rm nombre_procesos
      mv nombre_procesosS nombre_procesos
      cat nombre_procesos
      echo " "
      echo -e "$yellowColour $(cat nombre_procesos | wc -l) procesos ejecutándose$endColour"
      echo " "
      rm nombre_procesos
      sleep 2
  done < usuarios_activos

  rm usuarios_activos
  rm procesos_User
  exit

}

time_CPU(){

  #Usuarios que tienen procesos ejecutándose actualmente
  ps -ef | cut -d ' ' -f 1 | sort -u >> usuarios_activos

  #Eliminación de contenido no deseado
  sed '/68/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/root/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/apache/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/gdm/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/mysql/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/postfix/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpc/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpcuser/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/tomcat/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/UID/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/xfs/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/dbus/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/colord/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/kernoops/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/sshd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/message+/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rtkit/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/statd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/syslog/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/whoopsie/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/oracle/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/smmsp/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  #----------------------------------------------------------

  echo " "
  echo -e "$yellowColour Se han detectado los siguientes usuarios conectados al sistema con procesos abiertos..."
  sleep 4
  echo " "
  echo -e "$blueColour$(cat usuarios_activos)$endColour"
  echo " "
  echo -e "$greenColour$(cat usuarios_activos | wc -l) usuarios con procesos abiertos$endColour"
  echo " "
  sleep 2

  while read line
    do
      echo "------------------------------------------------------------------------"
      echo "Tiempo de CPU consumido por cada uno de los procesos de $line" > cpu_lista
      cat cpu_lista
      sleep 2
      echo " "
      ps -eo pcpu,pid,user,args,time | sort -r -k1 | less | cut -d ' ' -f 3-30 | grep $line  > cpu_lista2
      cat cpu_lista2
      sleep 2
      echo " "
  done < usuarios_activos

  echo " "

  rm cpu* usuarios_activos

  #ps -eo pcpu,pid,user,args,time | sort -r -k1 | less | grep alu5248

  exit
}

#Comienzo de lectura del programa
while [ "$1" != "" ]; do

  case $1 in
    -h | --help )
      usage
      exit
    ;;

    -u | --user )
      shift
      usuario=$1
      usuario_parametro
    ;;

    -l | --last )
      shift
      number=$1
      recent_connection
    ;;

    -t | --time )
      time_user
    ;;

    TIME )
      time_CPU
    ;;

    -n | --nofilter )
    shift
      noUser=$1
      no_user_filter
    ;;

    * )
      echo " "
      echo -e "$redColour Opcion incorrecta$endColour"
      usage
      exit
    ;;

  esac
done


#Logo menú principal
#--------------------------------------------------------
clear
echo -e "$greenColour************************************************$endColour"
sleep 1
echo -e "$blueColour╭━━━╮╱╱╱╱╱╭╮╱╱╱╱╱╭╮╱╱╱╭╮╱╱╱╭╮╱╭╮$endColour"
sleep 0.05
echo -e "$blueColour┃╭━╮┃╱╱╱╱╭╯╰╮╱╱╱╱┃┃╱╱╱┃┃╱╱╱┃┃╱┃┃$endColour"
sleep 0.05
echo -e "$blueColour┃┃╱╰╋━━┳━╋╮╭╋━┳━━┫┃╱╭━╯┣━━╮┃┃╱┃┣━━┳╮╭┳━━┳━┳┳━━┳━━╮$endColour"
sleep 0.05
echo -e "$blueColour┃┃╱╭┫╭╮┃╭╮┫┃┃╭┫╭╮┃┃╱┃╭╮┃┃━┫┃┃╱┃┃━━┫┃┃┃╭╮┃╭╋┫╭╮┃━━┫$endColour"
sleep 0.05
echo -e "$blueColour┃╰━╯┃╰╯┃┃┃┃╰┫┃┃╰╯┃╰╮┃╰╯┃┃━┫┃╰━╯┣━━┃╰╯┃╭╮┃┃┃┃╰╯┣━━┃$endColour"
sleep 0.05
echo -e "$blueColour╰━━━┻━━┻╯╰┻━┻╯╰━━┻━╯╰━━┻━━╯╰━━━┻━━┻━━┻╯╰┻╯╰┻━━┻━━╯$endColour"
sleep 0.05
echo -e "$grayColour Hecho por: mundohackers.es$endColour"
sleep 0.05
echo -e "$grayColour                   Tu web de Hacking$endColour"
sleep 1
echo -e "$greenColour************************************************$endColour"
sleep 2

#--------------------------------------------------------

if [ "$1" = "" ]; then

  #Usuarios que tienen procesos ejecutándose actualmente
  ps -ef | cut -d ' ' -f 1 | sort -u >> usuarios_activos

  #Eliminación de contenido no deseado
  sed '/68/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/root/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/apache/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/gdm/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/mysql/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/postfix/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpc/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rpcuser/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/tomcat/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/UID/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/avahi/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/xfs/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/dbus/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/colord/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/kernoops/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/sshd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/message+/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/rtkit/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/statd/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/syslog/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/whoopsie/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/oracle/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  sed '/smmsp/d' usuarios_activos >> usuarios_activos2
  rm usuarios_activos
  mv usuarios_activos2 usuarios_activos

  #----------------------------------------------------------

  echo " "
  echo -e "$yellowColour Se han detectado los siguientes usuarios conectados al sistema con procesos abiertos..."
  sleep 4
  echo " "
  echo -e "$blueColour$(cat usuarios_activos)$endColour"
  echo " "
  echo -e "$greenColour$(cat usuarios_activos | wc -l) usuarios con procesos abiertos$endColour"
  echo " "
  sleep 2
  echo -e "$yellowColour Analizando usuarios alu...$endColour"
  echo " "
  sleep 2
  while read line
    do
      getent passwd | grep $line | cut -d ':' -f 5 >> usuarios_entero # Almacenamiento de nombre y apellidos de usuarios en fichero
  done < usuarios_activos

  cat usuarios_entero | cut -d ',' -f 2 >> nombre_usuarios
  cat usuarios_entero | cut -d ',' -f 1 >> apellido_usuarios

  paste -d " " nombre_usuarios apellido_usuarios >> info_panel
  paste -d " " info_panel usuarios_activos >> final_info
  cat final_info | sort >> info_ordenada #Último fichero con información total del usuario

  rm info_panel nombre_usuarios apellido_usuarios usuarios_entero

  echo -e "$greenColour ******************************************$endColour"
  cat info_ordenada
  echo -e "$greenColour ******************************************$endColour"
  echo " "
  sleep 2
  echo -e "$yellowColour Procesos de usuario...$endColour"
  echo " "
  sleep 2
  while read line
    do
      echo -e "$redColour$line$endColour $purpleColour->$endColour $blueColour$(ps -fea | cut -d ' ' -f 1 | grep $line | wc -l) procesos abiertos$endColour" >> num_procesos
  done < usuarios_activos

  cat num_procesos
  echo " "
  echo -e "$yellowColour Analizando correspondencia de usuario...$endColour"
  echo " "
  sleep 2
  cat num_procesos | cut -d ' ' -f 2-5 >> procesos_usuariosSF
  paste -d " " final_info procesos_usuariosSF >> procesos_usuario
  cat procesos_usuario | sort >> procesos_ordenados

  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat procesos_ordenados
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "
  sleep 2

  rm final_info procesos_usuariosSF info_ordenada num_procesos

  echo -e "$yellowColour Análisis de tipo de usuario...$endColour"
  echo " "
  sleep 2

  while read line
    do
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -ge "1000" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour Usuario Convencional$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -eq "0" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour root$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -ge "1" ] && [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -le "99" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour Usuario Predefinido con Fines Administrativos$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
      if [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -ge "100" ] && [ "$(getent passwd | grep $line | cut -d ':' -f 3)" -le "900" ]; then
        echo -e "$greenColour$line$endColour $purpleColour[$endColour$redColour Usuario Adminsitrador$endColour $purpleColour]$endColour" >> tipo_usuario
      fi
  done < usuarios_activos

  cat tipo_usuario
  echo " "
  sleep 2

  cat tipo_usuario | cut -d ' ' -f 2-8 >> tipo_usuarioSF
  paste -d " " procesos_ordenados tipo_usuarioSF >> procesos_tipo_usuario
  cat procesos_tipo_usuario | sort >> procesosTU_ordenados

  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat procesosTU_ordenados
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "
  sleep 2

  rm procesos_ordenados procesos_tipo_usuario procesos_usuario tipo_usuario tipo_usuarioSF

  echo -e "$yellowColour Comprobando si el usuario tiene una shell de arranque válida..."
  sleep 2
  echo " "
  while read line
    do
      if [ "$(getent passwd | grep $line | cut -d ':' -f 7)" = "/bin/bash" ]; then
        echo -e "$purpleColour$line$endColour $yellowColour||$endColour$greenColour Shell de arranque válida$endColour" >> comprobacion
      elif [ "$(getent passwd | grep $line | cut -d ':' -f 7)" = "/bin/false" ]; then
        echo -e "$purpleColour$line$endColour $yellowColour||$endColour$greenColour Es un usuario interno$endColour" >> comprobacion
      fi

  done < usuarios_activos

  cat comprobacion
  sleep 2

  cat comprobacion | cut -d ' ' -f 2-6 >> comprobacionST
  paste -d " " procesosTU_ordenados comprobacionST >> fichero_final
  cat fichero_final | sort >> final_ordenado

  echo " "
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  cat final_ordenado
  echo -e "$greenColour ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$endColour"
  echo " "

  rm comprobacion comprobacionST fichero_final procesosTU_ordenados

  sleep 2
  echo -e "$yellowColour Se van a listar los procesos de cada usuario$endColour"
  echo " "
  sleep 2
  while read line
    do
      sleep 1
      echo -e "$greenColour -------------------------------$endColour"
      sleep 1
      echo -e "$purpleColour ***********************************************$endColour"
      echo -e "$blueColour Usuario$endColour $redColour$line$endColour $greenColour||$endColour $(getent passwd | grep $line | cut -d ':' -f 5)"
      echo -e "$purpleColour ***********************************************$endColour"
      sleep 2
      echo " "
      ps -fea | grep $line > procesosUser
      sed '/root/d' procesosUser > procesos_User
      cat procesosUser | cut -d ':' -f 4-7 > nombre_procesos
      cat nombre_procesos  | cut -d ' ' -f 2-7 > nombre_procesos_final
      rm nombre_procesos procesosUser
      mv nombre_procesos_final nombre_procesos
      sed '/grep/d' nombre_procesos > nombre_procesosS
      rm nombre_procesos
      mv nombre_procesosS nombre_procesos
      cat nombre_procesos
      echo " "
      echo -e "$yellowColour $(cat nombre_procesos | wc -l) procesos ejecutándose$endColour"
      echo " "
      rm nombre_procesos
      sleep 2
  done < usuarios_activos

  rm usuarios_activos
  rm procesos_User

fi
