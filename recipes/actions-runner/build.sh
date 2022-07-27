#!/bin/bash

set -eoux pipefail

git switch -c merge-branch
git ls-files -o
cd ./src
sed -i 's|^.*Exec Command="git update-index.*$||g' ./dir.proj
dotnet msbuild -t:Build -p:PackageRuntime="linux-x64" -p:BUILDCONFIG="Release" -p:RunnerVersion="2.294.0" ./dir.proj
cd ..
cp -R ./src/Misc/layoutroot/* ./_layout/
rm -f ./_layout/*.cmd
cp -R ./src/Misc/layoutbin/* ./_layout/bin/

cp -R ./_layout $PREFIX/actions-runner
