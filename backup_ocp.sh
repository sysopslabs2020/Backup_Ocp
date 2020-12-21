#!/bin/bash
#Author: Luca Santirocchi
#Version: 1.0

#export http_proxy=""
#export ftp_proxy=""
#export https_proxy=""
Backuplog=/Backup_OCS/backup/backup_$(hostname)_ocs_$(date -I).log

echo "---------------Inizio Script di Backup----$(date +%H:%M-%Y/%m/%d)------------">>${Backuplog}

echo "-----------Eseguo Login------------------------">>${Backuplog}
OSname=`hostname`

###if [ $OSname = "covpmlosb1.domain.it" ];
if [ $OSname = "covpmlosb1" ];
then
oc login https://console.opencs.domain.it:8443 -u admin -p XXXXXXX
elif [ $OSname = "ernvlbastion1.domain.it" ];
then
oc login https://console.cluster01.prod.opencs.domain.it:8443/ -u admin -p XXXXXXX
elif [ $OSname = "cpmzbastion1.domain.it" ];
then
oc login https://console.clusterzac-collaudo.opencs.domain.it:8443/console -u admin -p XXXXXXX
elif [ $OSname = "epmzbastion1.domain.it" ];
then
oc login https://console.clusterzac1.opencs.domain.it:8443/console -u admin -p XXXXXXX
else
echo "host non valido, lo script può girare solo su questi server bastion: covpmlosb1 ernvlbastion1 cpmzbastion1 epmzbastion1"
exit
fi

echo "---------Login Effettuata---------------------">>${Backuplog}

check=/Backup_OCS/backup/check_NFS_$(hostname).log
if
[[ -d /Backup_OCS ]];
then
echo "Dir NFS Montata">>${check}
echo "Inizio Run Backup Openshift">>${check}
else
echo "Dir NFS non Montata">>${check}
echo "Esco e verifica se la share NFS Backup_OCS è montata">>${chek}
exit
fi

#Backuplog=/Backup_OCS/backup/$(hostname)/backup_$(hostname)_ocs_$(date -I).log

DATE=`date -I`
DIR=/Backup_OCS/backup/$(hostname)
DIR=$DIR/$DATE

echo "---------------Inizio Procedura Backup---------------">>${Backuplog}
echo "">>${Backuplog}
echo "---------------Creata Cartella $DIR------------------">>${Backuplog}
echo "">>${Backuplog}
mkdir -p $DIR/projects
echo "">>${Backuplog}
echo "---------------Creata Cartella $DIR/projects---------">>${Backuplog}
echo "">>${Backuplog}
cd $DIR/projects
echo "">>${Backuplog}
echo "">>${Backuplog}
echo "">>${Backuplog}
echo "-------------Inizio Selezione Progetti---------------">>${Backuplog}
echo "">>${Backuplog}

for project in `oc get projects --no-headers |grep Active |awk '{print $1}'`
do
echo "">>${Backuplog}
echo "--------------Creata Cartella $project-------------- ">>${Backuplog}
echo "">>${Backuplog}

  mkdir $project
  cd $project
  kubectl config use-context $project
  oc get -o yaml --export all -n $project >$project-full.yaml

echo "-----------Eseguo Export del progetto $project in un UNICO file yaml ---------------- ">>${Backuplog}
echo "">>${Backuplog}

  for object in rolebindings configmap serviceaccounts secrets imagestreamtags cm egressnetworkpolicies rolebindingrestrictions limitranges resourcequotas pvc templates cronjobs statefulsets hpa deployments replicasets poddisruptionbudget endpoints
  do
echo "">>${Backuplog}
echo "-------------Creata Cartella $object---$project------------- ">>${Backuplog}
echo "">>${Backuplog}

    mkdir $object
    cd $object
    for service in `oc get $object -n $project --no-headers |awk '{print $1}'`
    do

echo "">>${Backuplog}
echo "-----------Eseguo Export di tutti gli oggetti dei progetti $object---$project---------------- ">>${Backuplog}
echo "">>${Backuplog}
      oc get -n $project -o yaml --export $object >$object.yml
echo "">>${Backuplog}
    done
    cd ..
  done
    cd ..
done
echo "">>${Backuplog}

echo "--------------Fine Script di Backup-----$(date +%H:%M-%Y/%m/%d)--------------">>${Backuplog}
