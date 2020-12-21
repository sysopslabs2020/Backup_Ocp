# Backup script Openshift Cluster 3.11 Projects
##The "backup_ocp.sh" script performs a complete backup of all components and objects of all projects in a Openshift 3.11 cluster with the exception of the Storage component.
##The "backup_ocp_one_project.sh" script performs a complete backup of all components and objects but only a single project in a Openshift 3.11 cluster with the exception of the Storage component. the syntaxis ./backup_ocp_one_project.sh project-name
##The "check_post_backup_ocp.sh" script check if the backup process completed successfully
