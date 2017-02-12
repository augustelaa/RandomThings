#!/bin/bash

diretorio=/home/sujeira/
nomeCampo=novapasta
nomeBase=anexos

echo "Iniciando script... $(date +"%d/%m/%Y %H:%M:%S $HOSTNAME")" >> out.txt
for ano in {2010..2017}
do
	for mes in {1..12}
	do
		for dia in {1..31}
		do
			dia2=$(($dia+1));
			mes2=$(($mes));
			ano2=$(($ano));
			if [ "$dia2" -gt "31" ]; then
				dia2=1;
				mes2=$(($mes+1));
				if [ "$mes2" -gt "12" ]; then
					mes2=1;
					ano2=$(($ano+1));
				fi;
			fi;
			echo "$ano-$mes-$dia";
			novoCaminho="$diretorio$ano/$mes/"
			test -d "$novoCaminho" || mkdir -p "$novoCaminho"
			find $diretorio -name "*" -type f -newermt "$ano-$mes-$dia" ! -newermt "$ano2-$mes2-$dia2" -exec echo "UPDATE '$nomeBase' SET '$nomeCampo'='$novoCaminho'" >> out.txt \; -exec sh -c 'echo " WHERE cod_anexo=\""$(basename {})"\";" >> out.txt' \; -exec mv -t $novoCaminho {} +
		done
	done
done
echo "Finalizando script... $(date +"%d/%m/%Y %H:%M:%S $HOSTNAME")" >> out.txt
