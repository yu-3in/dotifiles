########################################
# zinit
ZINIT_DIR="$HOME/.local/share/zinit"
if [ ! -e $ZINIT_DIR ]; then
  NO_EDIT=false \
    NO_TUTORIAL=false \
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

[ -e $ZINIT_DIR ] && source $ZINIT_DIR/zinit.git/zinit.zsh

########################################
# powerline-go
POWERLINE_GO_LINUX_URL="https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-linux-amd64"
POWERLINE_GO_MAC_URL="https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-darwin-amd64"
POWERLINE_GO_DIR="$HOME/.powerline-go"
POWERLINE_GO_BIN="powerline-go"
if [ ! -e $POWERLINE_GO_DIR ]; then
  echo installing powerline go
  mkdir $POWERLINE_GO_DIR

  case ${OSTYPE} in
  linux*)
    wget -O $POWERLINE_GO_DIR/$POWERLINE_GO_BIN $POWERLINE_GO_LINUX_URL
    ;;
  darwin*)
    wget -O $POWERLINE_GO_DIR/$POWERLINE_GO_BIN $POWERLINE_GO_MAC_URL
    ;;
  esac

  chmod 700 $POWERLINE_GO_DIR/$POWERLINE_GO_BIN
fi
