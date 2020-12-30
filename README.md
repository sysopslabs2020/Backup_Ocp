# Openshift Cluster 3.11 Backup Project scripts
## NO WARRANTY for any damages and loss of data.
## The "backup_ocp.sh" script performs a complete backup of all components and objects of all projects in a Openshift 3.11 cluster with the exception of the Storage component.
## The "backup_ocp_one_project.sh" script performs a complete backup of all components and objects but only a single project in a Openshift 3.11 cluster with the exception of the Storage component. the syntaxis ./backup_ocp_one_project.sh project-name
## The "check_post_backup_ocp.sh" script check if the backup process completed successfully

## The backup scripts was created starting from the official Openshift 3.11 Documentation https://docs.openshift.com/aro/3/admin_guide/assembly_backing-up-restoring-project-application.html
