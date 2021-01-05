#!/data/data/com.termux/files/usr/bin/bash
clear

install=0

# based on: https://stackoverflow.com/questions/9639103/is-there-a-goto-statement-in-bash
goto() {
    local label=$1
    cmd=$(sed -En "/^[[:space:]]*#[[:space:]]*$label:[[:space:]]*#/{:a;n;p;ba};" "$0")
    eval "$cmd"
    exit
}

try_continue_end() {
    local ended=$1

    read -p "continue? " -r yorn
    case $yorn in
    [yY] | [yY][Ee][sS]) ;;

    [nN] | [nN][oO])
        goto "$ended"
        ;;
    esac
}

try_continue() {
    if [ $install -ne 0 ]; then
        try_continue_end "end"
    fi
}

backup() {
    mv "$1" "$HOME/.bak/$2"
}

# mirror: #
mirrorInstall() {
    echo "[1] Mirrors setting..."
    termux-setup-storage

    sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' "$PREFIX/etc/apt/sources.list"

    sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' "$PREFIX/etc/apt/sources.list.d/game.list"

    sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' "$PREFIX/etc/apt/sources.list.d/science.list"

    pkg update

    pkg install -y curl wget proot openssh
}

# git: #
gitInstall() {
    echo "[2] Git setting..."
    pkg install -y git
    curl -fsLo "$HOME/.gitconfig https://cdn.jsdelivr.net/gh/cangSDARM/vimrc@master/.gitconfig"
    mkdir "$HOME/git_storage"

    ssh-keygen
    if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
        cat id_rsa.pub >authorized_keys
        sed 's/PasswordAuthentication\ yes/PasswordAuthentication\ no/gI' "$PREFIX/etc/ssh/sshd_config"
        try_continue
        ssh -T git@github.com
        pkill sshd
        sshd
    else
        echo "keygen failed"
        exit 1
    fi
}

# termux: #
termuxInstall() {
    echo "[3] Termux setting..."

    git clone https://github.com/Cabbagec/termux-ohmyzsh.git "$HOME/termux-ohmyzsh" --depth 1

    if [ -d "$HOME/.termux" ]; then
        backup "$HOME/.termux" ".termux"
    fi
    cp -R "$HOME/termux-ohmyzsh/.termux" "$HOME/.termux"

    if [ -f "$HOME/.termux/termux.properties" ]; then
        backup "$HOME/.termux/termux.properties" "termux.properties"
    fi
    curl -fsLo "$HOME/.termux/termux.properties" https://cdn.jsdelivr.net/gh/cangSDARM/vimrc@master/termux/properties

    if [ -f "$HOME/.termux/colors.properties" ]; then
        backup "$HOME/.termux/colors.properties" "colors.properties"
    fi
    curl -fsLo "$HOME/.termux/colors.properties" https://cdn.jsdelivr.net/gh/cangSDARM/vimrc@master/termux/colors

    if [ -f "$PREFIX/etc/motd" ]; then
        backup "$PREFIX/etc/motd" "motd"
    fi
    curl -fsLo "$PREFIX/etc/motd" --create-dirs https://cdn.jsdelivr.net/gh/cangSDARM/vimrc@master/termux/prelude
}

# oh-my-zsh: #
ohMyZsh() {
    echo "[4] Oh-my-zsh setting..."

    pkg install -y zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1

    if [ -f "$HOME/.zshrc" ]; then
        backup "$HOME/.zshrc" ".zshrc"
    fi
    curl -fsLo "$HOME/.zshrc" https://cdn.jsdelivr.net/gh/cangSDARM/vimrc@master/termux/.zshrc

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1

    {
        echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        echo "alias chcolor='$HOME/.termux/colors.sh'"
        echo "alias chfont='$HOME/.termux/fonts.sh'"
    } >>"$HOME/.zshrc"
}

# python: #
pyInstall() {
    echo "[5] Python setting..."
    pkg install python python2 -y
    python2 -m pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
    python -m pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
    # shellcheck disable=SC2046
    echo "python3: " $(python -V) $(pip -V)
    # shellcheck disable=SC2046
    echo "python2: " $(python2 -V) $(pip2 -V)
}

# vim: #
vimInstall() {
    echo "[6] Vim setting..."
    pkg install vim-python -y
    if [ -f "$HOME/.vimrc" ]; then
        backup "$HOME/.vimrc" ".vimrc"
    fi
    curl -fsLo "$HOME/.vimrc" https://cdn.jsdelivr.net/gh/cangSDARM/vimrc@master/termux/.vimrc
    # shellcheck source=/dev/null
    source "$HOME/.vimrc"
}

# other: #
otherInstall() {
    echo "[7] Other tools"
    pkg install hydra nmap exiftool
    git clone git@github.com:s0md3v/XSStrike.git "$HOME/XSStrike"
    pip install whatportis
}

# develops: #
devInstall() {
    echo "[8] Develops"
    pkg install nginx
    pkg install nodejs-lts
}

# soft-link: #
softLink() {
    echo "[9] Soft links"
    ln -s /data/data/com.termux/files/home/storage/shared "$HOME/storage"

    if [ -d "$HOME/storage" ]; then
        try_continue
    else
        echo "soft-link failed"
        exit 1
    fi
}

# change-theme: #
changeTheme() {
    chsh -s zsh
    echo "choose your color scheme now~"
    "$HOME/.termux/colors.sh"
    echo "Choose your font now~"
    "$HOME/.termux/fonts.sh"
}

installAll() {
    mirrorInstall
    gitInstall
    termuxInstall
    ohMyZsh
    pyInstall
    vimInstall
    otherInstall
    devInstall
    softLink
    changeTheme
}

prelude() {
    echo "Install termux configuations"
    echo "[1]  mirror"
    echo "[2]  git"
    echo "[3]  termux"
    echo "[4]  oh-my-zsh"
    echo "[5]  python"
    echo "[6]  vim"
    echo "[7]  other"
    echo "[8]  develops"
    echo "[9]  soft-link"
    echo "[10] change-theme"
    echo "[defalut] install"
    read -p "choise your want execute:" -r executeWant

    wanted=${1:-install}
    case $executeWant in
    mirror | Mirror | 1)
        mirrorInstall
        ;;
    git | Git | 2)
        gitInstall
        ;;
    termux | Termux | 3)
        termuxInstall
        ;;
    oh-my-zsh | zsh | 4)
        ohMyZsh
        ;;
    python | py | Python | 5)
        pyInstall
        ;;
    vim | Vim | 6)
        vimInstall
        ;;
    other | Other | 7)
        otherInstall
        ;;
    develops | Develops | 8)
        devInstall
        ;;
    soft-link | Soft-link | 9)
        softLink
        ;;
    change-theme | Change-theme | 10)
        changeTheme
        ;;
    install | Install)
        installAll
        ;;
    *)
        echo "error choise."
        exit 1
        ;;
    esac

    goto "$wanted"
}

prelude "$@"

# end: #
echo "Done, You can enjoy termux now!"
echo "And you may want this app in AppStore: Termux:API,"
echo "and run $(pkg install termux-api)"

exit
