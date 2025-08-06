# Stop the current container
docker-compose -f docker-compose.test.yml down

# Start fresh container 
docker-compose -f docker-compose.test.yml up -d dotfiles-test

# Enter and test
docker exec -it dotfiles-test bash

./scripts/install-dev-tools.sh