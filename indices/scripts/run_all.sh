#!/bin/bash
#run all index scripts, to create lists based on the current state of the repo

cd "${0%/*}/.."
#these are simple indexes based on directories, they need to run first
./scripts/czech-asr.sh
./scripts/elitr-testsuite.sh
./scripts/exotic-languages.sh
./scripts/iwslt-antrecorp.sh
./scripts/iwslt-consecutive.sh
./scripts/iwslt-devset.sh
./scripts/iwslt-khanacademy.sh
./scripts/iwslt-wgvat.sh
./scripts/langtools-workshop.sh
./scripts/linguistic-mondays.sh
./scripts/taus.sh

#these are indexes grouped by language, domain, data-types, etc. They extract from simple indexes
./scripts/asr-any-language-any-domain.sh
./scripts/asr-czech-any-domain.sh
./scripts/asr-english-any-domain.sh
./scripts/asr-english-auditing.sh
