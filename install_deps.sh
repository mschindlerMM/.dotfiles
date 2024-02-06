# NVM
test -e  ~/.nvm/nvm.sh && source ~/.nvm/nvm.sh

if ! command -v nvm >/dev/null; then
    echo "===> NVM is missing. Installing..."
    PROFILE=/dev/null bash -c "curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash >/dev/null"
    source ~/.nvm/nvm.sh
fi

if [ "$(nvm current)" == "none" ]; then
  echo "===> no version installed. installing version 18..."
  nvm install 18
  nvm alias default 18
fi

# Brew
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install brew (thefuck, vcprompt)
if ! command -v brew >/dev/null; then
  echo "===> Missing brew. Installing..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Python
  sudo yum groupinstall 'Development Tools'
  brew install gcc
fi

# thefuck
if ! command -v thefuck >/dev/null; then
  echo "===> Missing thefuck"
  brew install thefuck
fi

# vcprompt
if ! command -v vcprompt >/dev/null; then
  echo "===> installing vcprompt..."
  brew install vcprompt
fi

# asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi

if ! command -v asdf >/dev/null; then
  echo "===> installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  . "$HOME/.asdf/asdf.sh"
fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if ! command -v rvm >/dev/null; then
  echo "===> installing rvm..."
  gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  \curl -sSL https://get.rvm.io | bash -s stable --ruby

  source "$HOME/.rvm/scripts/rvm"
fi