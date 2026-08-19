#!/bin/bash

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

pthapp="${pthsrc}"/srvsvn
cmdini='/exp/runini.sh'

test -d "${pthapp}" || mkdir "${pthapp}"
cd "${pthapp}" && test -d etc_bind       || mkdir etc_bind
cd "${pthapp}" && test -d var_log_bind   || mkdir var_log_bind && chmod 777 var_log_bind
cd "${pthapp}" && test -d var_cache_bind || mkdir var_cache_bind && chmod 777 var_cache_bind

addimg ${imgtgt} "${cnfimg}" "${pthdoc}"

docker compose -f "${cnfcmp}" run -d --name ${cnttgt} ${cnttgt} sleep infinity && \
docker exec ${cnttgt} ${cmdini} && \
docker commit ${cnttgt} ${imgtgt} && \
docker rm -f "${cnttgt}"
