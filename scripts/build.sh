docker build -f ../Dockerfile -t bumaruf/github-actions-runner:latest -t bumaruf/github-actions-runner:2.275.1 ../.
docker build -f ../Dockerfile.node -t bumaruf/github-actions-runner:node -t bumaruf/github-actions-runner:node-2.275.1 ../.

docker push bumaruf/github-actions-runner:latest
docker push bumaruf/github-actions-runner:2.275.1

docker push bumaruf/github-actions-runner:node
docker push bumaruf/github-actions-runner:node-2.275.1
