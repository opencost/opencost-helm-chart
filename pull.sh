set -ex

# Pull the latest kubecost chart and normalise it as a base for opencost while we are branching off kubecost.
#
# Use this script with caution. Make sure to review and remove unnecessary manifests.
#
# Run from repository root directory
#
#     VERSION=v1.98.0 bash pull.sh
#     git add charts --patch
#
# Manifests that we remove from kubecost:
#
# - Network cost
# - SAML / OIDC
# - Advanced report
#
cat <<'EOD' | docker run -i --rm -e VERSION -v $PWD:$PWD -w $PWD quay.io/helmpack/chart-testing:v3.7.1 bash
set -ex

git config --global --add safe.directory '*'

VERSION="${VERSION:-v1.98.0}"

rm -rf charts/opencost

wget -qO- https://github.com/kubecost/cost-analyzer-helm-chart/archive/refs/tags/$VERSION.zip | unzip -

mkdir -p charts/opencost

mv */cost-analyzer/* charts/opencost

rm -rf charts/opencost/charts cost-analyzer-helm-chart*

for file in charts/opencost/templates/kubecost*; do mv "$file" "${file/kubecost/opencost}"; done

# Workaround doc (point at kubecost for the time being)
find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/docs.opencost.com/docs.kubecost.com/g'

# Workaround ecr (point at kubecost for the time being)
find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's#gcr.io/opencost1#gcr.io/kubecost1#g'

find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/opencost.com/opencost.io/g'

for file in charts/opencost/templates/cost-analyzer*; do mv "$file" "${file/cost-analyzer/costmodel}"; done

find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/kubecost/opencost/g'

find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/Kubecost/Opencost/g'

find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/cost-analyzer/costmodel/g'

find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/costAnalyzer/costModel/g'

find charts/opencost \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/cost analyser/cost model/g'

git checkout charts/opencost/Chart.yaml charts/opencost/README.md

rm -f charts/opencost/templates/NOTES.txt

rm -f charts/opencost/templates/*network-costs*

rm -f charts/opencost/templates/*advanced-reports*

EOD
