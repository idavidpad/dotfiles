if status is-interactive
    fish_add_path "$HOME/.cargo/bin"
    set -x EDITOR nvim
    alias lss eza
    alias ll "eza -l"
    alias la "eza -la"
    alias lg lazygit
    #    starship init fish | source
end

# Useful functions {{{

function eb
    nvim ~/freedom/obsidian/inbox/thinking.md
end
function ed
    nvim ~/.vim/custom-dictionary.utf-8.add
end
function ef
    nvim ~/.config/fish/config.fish
end
function ew
    nvim (which $argv[1])
end
function cw
    cat (which $argv[1])
end
function gw
    gist (which $argv[1])
end
function eff
    nvim ~/.config/fish/plugins/functions
end
function eg
    nvim ~/.gitconfig
end
function eh
    nvim ~/.hgrc
end
function ei
    hg -R ~/src/inventory/ pull -u; and nvim ~/src/inventory/inventory.markdown; and hg -R ~/src/inventory/ ci -m 'Update inventory'; and hg -R ~/src/inventory/ push
end
function em
    nvim ~/.mutt/muttrc
end
function es
    nvim ~/.stumpwmrc
end
function ev
    nvim ~/.vimrc
end

function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end

alias p pass
alias pw pass-work

# I give up
alias :q exit
alias :qa exit

# }}}
# Abbreviations {{{

abbr ai="sudo apt install"
abbr sc="sudo systemctl"

# }}}
# Completions {{{

function make_completion --argument alias command
    complete -c $alias -xa "(
        set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
        complete -C\"$command \$cmd\";
    )"
end

complete -c s -w ssh
complete -c cw -w which
complete -c ew -w which
complete -c gw -w which

# }}}
# Bind Keys {{{

# Backwards compatibility?  Screw that, it's more important that our function
# names have underscores so they look pretty.
function jesus_fucking_christ_bind_the_fucking_keys_fish
    bind \cn accept-autosuggestion
    bind \cw backward-kill-word
end
function fish_user_keybindings
    jesus_fucking_christ_bind_the_fucking_keys_fish
end
function fish_user_key_bindings
    jesus_fucking_christ_bind_the_fucking_keys_fish
end

# }}}
# Environment variables {{{

set -g -x NIX_LINK "$HOME/.nix-profile"

function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end
set -gx PATH /sbin
# set -gx LDFLAGS "-L/usr/local/opt/llvm/lib"
set -gx CPPFLAGS -I/usr/local/opt/llvm/include
prepend_to_path /snap/bin
prepend_to_path /Users/david/src/nvim-macos-x86_64/bin
prepend_to_path /usr/local/bin/
prepend_to_path /usr/local/opt/llvm/bin
prepend_to_path "/usr/local/Cellar/gcc/13.2.0/bin/"
prepend_to_path /usr/local/bin/
prepend_to_path /usr/sbin
prepend_to_path /bin
prepend_to_path /usr/bin
prepend_to_path /opt/local/bin
prepend_to_path /usr/local/bin
prepend_to_path /usr/local/go/bin
prepend_to_path /usr/local/sbin
prepend_to_path /usr/games
prepend_to_path "$HOME/.local/bin"
prepend_to_path "$HOME/src/dotfiles/lisp/bin"
prepend_to_path "$HOME/src/dotfiles/bin"
prepend_to_path "$HOME/src/hg"
prepend_to_path "$HOME/bin"
prepend_to_path "$HOME/.go/bin"
prepend_to_path "$HOME/.cargo/bin"

set BROWSER open

set -g -x fish_greeting ''
set -g -x EDITOR nvim
set -g -x COMMAND_MODE unix2003
set -g -x RUBYOPT rubygems
set -g -x PAGER 'less -X'
set -g -x MAVEN_OPTS "-Xmx2048m -Xss2M -XX:ReservedCodeCacheSize=128m"
# set -g -x _JAVA_OPTIONS "-Djava.awt.headless=true"

set -g -x GPG_TTY (tty)

# Less Colors for Man Pages
set -g -x LESS_TERMCAP_mb (printf '\e[01;31m') # begin blinking
set -g -x LESS_TERMCAP_md (printf '\e[01;38;5;74m') # begin bold
set -g -x LESS_TERMCAP_me (printf '\e[0m') # end mode
set -g -x LESS_TERMCAP_se (printf '\e[0m') # end standout-mode
set -g -x LESS_TERMCAP_so (printf '\e[38;5;246m') # begin standout-mode - info box
set -g -x LESS_TERMCAP_ue (printf '\e[0m') # end underline
set -g -x LESS_TERMCAP_us (printf '\e[04;38;5;146m') # begin underline

# }}}
# Python {{{

set -g -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
set -g -x PYTHONPATH ""
set PYTHONPATH "$HOME/lib/hg/hg:$PYTHONPATH"

# }}}
# Go {{{

set -g -x GOPATH "$HOME/.go"

# }}}
# Z {{{
# . ~/src/dotfiles/fish/plugins/conf.d/z.fish
# }}}
# Prompt {{{

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set cyan (set_color cyan)
set gray (set_color -o black)
set hg_promptstring "\
< on $magenta<branch>$normal>\
< at $cyan<bookmark>$normal>\
$green<status|modified|unknown><update>$normal\
" 2>/dev/null

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf '(%s) ' (basename "$VIRTUAL_ENV")
    end
end

function hg_prompt
    hg prompt --angle-brackets $hg_promptstring 2>/dev/null
end

function git_prompt
    if git root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git current-branch)
        set_color green
        git_prompt_status
        set_color normal
    end
end

function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt'
    echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt
    set last_status $status

    echo

    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    hg_prompt
    git_prompt

    echo

    virtualenv_prompt

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

# }}}
# Local {{{
if test -f $HOME/.local.fish
    . $HOME/.local.fish
end
# }}}

true
export HOMEBREW_API_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/api #brew.idayer.com
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles #brew.idayer.com
export HOMEBREW_PIP_INDEX_URL=https://mirrors.aliyun.com/pypi/simple/ #brew.idayer.com
# # oh-my-posh init fish --config ~/.config/oh-my-posh/themes/jandedobbeleer.omp.json | source
# if status is-interactive
#     oh-my-posh init fish --config ~/.config/oh-my-posh/themes/unicorn.omp.json | source
# end

# ================================================
# Fish Shell 完全固定 Oh My Posh unicorn 主题
# ================================================

# 只在交互式 shell 中生效
if status is-interactive

    # 1️⃣ 设置主题路径（使用绝对路径）
    set -gx OMP_THEME $HOME/.config/oh-my-posh/themes/unicorn.omp.json

    # 2️⃣ 清理可能影响 prompt 的旧函数
    # 删除可能存在的自定义 prompt 函数
    for fn in (functions | grep -E 'fish_prompt|fish_right_prompt|rerender_on_dir_change')
        functions -e $fn
    end

    # 3️⃣ 初始化 Oh My Posh
    oh-my-posh init fish --config $OMP_THEME | source

    # 4️⃣ 禁止目录切换时自动重绘覆盖主题
    function nop --on-variable PWD
        # 空函数，不做任何操作
        # 防止其他插件或旧配置调用时覆盖主题
    end

    # 5️⃣ 强制隐藏 Fish 默认提示符
    set -g fish_prompt ''
    set -g fish_right_prompt ''

    # 6️⃣ 可选：禁止其它插件自动修改 PROMPT
    # 如果你使用 fisher 插件管理器，可在这里禁用 prompt 插件
    # 例如：fisher remove bobthefish
end


# 延迟加载 Oh-My-Posh，避免键绑定冲突, 加载后会有主题的问题
# function init_oh_my_posh --on-event fish_postexec
#     if not functions -q __oh_my_posh_initialized
#         oh-my-posh init fish | source
#         function __oh_my_posh_initialized
#         end
#     end
# end

# 在文件末尾添加
# mkdir -p ~/.config/fish/completions
# carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # 选做：生成静态补全文件以提高速度
carapace _carapace fish | source
