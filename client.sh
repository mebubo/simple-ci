curl -v -X POST -H "Content-Type: application/json" -H "X-GitHub-Event: pull_request" --data '{ "pull_request" : { "number" : 1 } }' http://localhost:8080
