#!/bin/bash

_ls () 
{ 
    local IFS=' ';
    command ls $LS_OPTIONS ${1+"$@"}
#    command exa $EXA_OPTIONS ${1+"$@"}
}
_ls_ () 
{ 
    local c=${COMP_WORDS[COMP_CWORD]};
    local IFS='
';
    local s x;
    local -i glob=0;
    local -i isdir=0;
    local -i quoted=0;
    local -i variable=0;
    if [[ "${c:0:1}" == '"' ]]; then
        let quoted++;
        compopt -o plusdirs;
    fi;
    if [[ "${c:0:1}" == '$' ]]; then
        let variable++;
        compopt -o dirnames +o filenames;
    else
        compopt +o dirnames -o filenames;
    fi;
    if test -d "$c"; then
        compopt -o nospace;
    else
        compopt +o nospace;
    fi;
    shopt -q extglob && let glob++;
    ((glob == 0)) && shopt -s extglob;
    case "$c" in 
        *[*?[]*)
            COMPREPLY=();
            ((glob == 0)) && shopt -u extglob;
            return 0
        ;;
        \$\(*\))
            eval COMPREPLY=\(${c}\);
            compopt +o plusdirs
        ;;
        \$\(*)
            COMPREPLY=($(compgen -c -P '$(' -S ')'  -- ${c#??}));
            if ((${#COMPREPLY[@]} > 0)); then
                compopt +o plusdirs;
                let isdir++;
            fi
        ;;
        \`*\`)
            eval COMPREPLY=\(${c}\);
            compopt +o plusdirs
        ;;
        \`*)
            COMPREPLY=($(compgen -c -P '\`' -S '\`' -- ${c#?}));
            if ((${#COMPREPLY[@]} > 0)); then
                compopt +o plusdirs;
                let isdir++;
            fi
        ;;
        \$\{*\})
            eval COMPREPLY=\(${c}\)
        ;;
        \$\{*)
            COMPREPLY=($(compgen -v -P '${' -S '}'  -- ${c#??}));
            if ((${#COMPREPLY[@]} > 0)); then
                compopt +o plusdirs;
                if ((${#COMPREPLY[@]} > 1)); then
                    ((glob == 0)) && shopt -u extglob;
                    return 0;
                fi;
                let isdir++;
                eval COMPREPLY=\(${COMPREPLY[@]}\);
            fi
        ;;
        \$*)
            COMPREPLY=($(compgen -v -P '$' $s   -- ${c#?}));
            if ((${#COMPREPLY[@]} > 0)); then
                compopt +o plusdirs;
                if ((${#COMPREPLY[@]} > 1)); then
                    ((glob == 0)) && shopt -u extglob;
                    return 0;
                fi;
                let isdir++;
                eval COMPREPLY=\(${COMPREPLY[@]}\);
            fi
        ;;
        \~*/*)
            COMPREPLY=($(compgen -d $s +o plusdirs  -- "${c}"));
            if ((${#COMPREPLY[@]} > 0)); then
                compopt +o plusdirs;
                let isdir++;
            fi
        ;;
        \~*)
            COMPREPLY=($(compgen -u $s          -- "${c}"));
            if ((${#COMPREPLY[@]} > 0)); then
                compopt +o plusdirs;
                let isdir++;
            fi
        ;;
        *\:*)
            if [[ $COMP_WORDBREAKS =~ : ]]; then
                x=${c%"${c##*[^\\]:}"};
                COMPREPLY=($(compgen -d $s +o plusdirs -- "${c}"));
                COMPREPLY=(${COMPREPLY[@]#"$x"});
                ((${#COMPREPLY[@]} == 0)) || let isdir++;
            fi;
            ((glob == 0)) && shopt -u extglob;
            return 0
        ;;
        *)
            COMPREPLY=();
            ((glob == 0)) && shopt -u extglob;
            return 0
        ;;
    esac;
    ((quoted)) || _compreply_ $isdir;
    ((glob == 0)) && shopt -u extglob
}

