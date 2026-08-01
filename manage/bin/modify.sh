#!/bin/bash

nammod=${1}

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

if test ${nammod} = 'cnf001'
then
  pthapp="${pthsrc}"/srvsvn
  pthcnf="${pthsrc}"/export/cnf/xoxxox
  pthopt="${pthsrc}"/export_option-${nammod}
  cnfopt="${pthopt}"/cnf/xoxxox/docker_srvsvn_custom.yml
  pthmod="${pthopt}"/cnf/xoxxox/modify

  subnet='192.168.100.0/24'
  nettgt='xoxxox_netsrv'

  docker network inspect ${nettgt} > /dev/null 2>&1 || docker network create --subnet ${subnet} ${nettgt}

  cpytgt "${cnfopt}" "${pthcnf}"

  cpytgt "${pthmod}/named.conf"         "${pthapp}/etc_bind"
  cpytgt "${pthmod}/named.conf.local"   "${pthapp}/etc_bind"
  cpytgt "${pthmod}/named.conf.options" "${pthapp}/etc_bind"
  cpytgt "${pthmod}/db.dom001"          "${pthapp}/etc_bind"
fi
