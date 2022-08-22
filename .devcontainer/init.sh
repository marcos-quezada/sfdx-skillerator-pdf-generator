sfdx force:auth:sfdxurl:store -d -f kl.txt -a devhub
sfdx force:org:create -f config/project-scratch-def.json -a sandbox -s
sfdx force:source:push
