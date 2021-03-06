#!/bin/zsh

asdf__prepare() {
  if ! has_command asdf; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    pushd ~/.asdf || exit
    git checkout "$(git describe --abbrev=0 --tags)"
    popd || exit
  fi
}

asdf__setup() {
  ensure_plugin_add() {
    if ! asdf plugin list | grep -q "$1"; then
      run_command "asdf plugin add $1"
    fi
  }

  ensure_plugin_add elixir
  ensure_plugin_add elm
  ensure_plugin_add erlang
  ensure_plugin_add nodejs
  ensure_plugin_add postgres
  ensure_plugin_add python
}

asdf__augment() {
  cat <<'DELIMIT' >>~/.zshrc
##########
# asdf setup
##########
. $HOME/.asdf/asdf.sh
# for zsh completions, append asdf completion function locations to fpath
fpath=(${ASDF_DIR}/completions $fpath)

DELIMIT
}

asdf__bootstrap() {}
