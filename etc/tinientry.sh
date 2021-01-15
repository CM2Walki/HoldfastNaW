#!/bin/bash
sed -i -e 's#{{ADDITIONAL_ARGS}}#'"${ADDITIONAL_ARGS}"'#g' "${HOMEDIR}/entry.sh"
bash "${HOMEDIR}/entry.sh"
