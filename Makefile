.PHONE: nuke

dev: server bootstrap local-project

server:
	waypoint server run -accept-tos 2>&1 > waypoint.log &

bootstrap:
	waypoint server bootstrap -server-addr=127.0.0.1:9701 -server-tls-skip-verify > waypoint.token

local-project:
	waypoint project apply test

git-project:
	waypoint project apply \
	-data-source=git \
	-poll \
	-from-waypoint-hcl=waypoint.hcl \
	-git-auth-type=ssh \
	-git-private-key-path=${HOME}/.ssh/id_rsa \
	-git-private-key-password=${SSH_PASSWORD} \
	-git-url=git@github.com:eveld/waypoint-test.git \
	test

trigger:
	waypoint trigger create \
      -project=test \
      -app=test \
      -name=trigger-test-build \
      -op=build

build:
	waypoint build -push=false --plain

consul:
	consul agent -dev

nuke:
	@-pkill -9 -f waypoint
	@-rm -rf .terraform
	@-rm -rf .waypoint waypoint.token waypoint.log waypoint-restore.db.lock data.db || true