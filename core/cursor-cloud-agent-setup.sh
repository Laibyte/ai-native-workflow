# Install Node.js (via nvm) and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm" && \. "$NVM_DIR/nvm.sh"
nvm install --lts
# Install Python 3.11+ and pip
sudo apt-get update && sudo apt-get install -y python3.11 python3-pip
# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -
export PATH="$HOME/.local/bin:$PATH"
# Install project dependencies
npm ci
poetry install